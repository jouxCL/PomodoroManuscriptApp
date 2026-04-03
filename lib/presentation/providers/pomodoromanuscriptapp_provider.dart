Aquí tienes el código Dart completo para el `ChangeNotifier` provider de estado, siguiendo estrictamente los modelos y repositorios proporcionados, y abordando los requisitos de gestión de estado y los posibles errores de compilación.

Este provider gestiona la configuración de la aplicación (`AppConfig`), las estadísticas generales (`OverallStats`) y el estado actual del temporizador Pomodoro, interactuando con el `PomodoroManuscriptAppRepository` para la persistencia de datos.

// File: lib/providers/pomodoro_manuscript_app_provider.dart

import 'package:flutter/material.dart';
import 'dart:async'; // Para el uso de Timer

// Importa los modelos y el repositorio desde sus rutas relativas.
// Asegúrate de que estas rutas coincidan con la estructura de tu proyecto.
import '../models/pomodoromanuscriptapp_model.dart';
import '../repositories/pomodoromanuscriptapp_repository.dart';

/// Enum para representar el estado actual del temporizador Pomodoro.
/// Esto ayuda a la UI a saber si está en fase de trabajo, descanso, pausado o detenido.
enum PomodoroTimerState {
  work,
  shortBreak,
  longBreak,
  paused,
  stopped,
}

/// `PomodoroManuscriptAppProvider` es un `ChangeNotifier` que gestiona
/// el estado global de la aplicación Pomodoro Manuscript.
///
/// Se encarga de:
/// 1. Cargar y guardar la configuración de la aplicación (tiempos de Pomodoro, perfil de usuario).
/// 2. Cargar y actualizar las estadísticas de productividad.
/// 3. Controlar el ciclo de vida del temporizador Pomodoro (iniciar, pausar, detener, transicionar fases).
/// 4. Acumular estadísticas de la sesión actual antes de guardarlas.
class PomodoroManuscriptAppProvider with ChangeNotifier {
  final PomodoroManuscriptAppRepository _repository;

  // --- Estado de la aplicación ---
  // `_appConfig` contiene la configuración de Pomodoro y el perfil de usuario.
  AppConfig _appConfig = const AppConfig();
  // `_overallStats` contiene las estadísticas acumuladas y el historial de sesiones.
  OverallStats _overallStats = const OverallStats();

  // --- Estado del temporizador Pomodoro ---
  // Indica la fase actual del temporizador (trabajo, descanso, etc.).
  PomodoroTimerState _timerState = PomodoroTimerState.stopped;
  // Tiempo restante para la fase actual.
  Duration _remainingTime = Duration.zero;
  // Contador de Pomodoros completados en el ciclo actual (antes de un descanso largo).
  int _currentCyclePomodoros = 0;
  // Indica si el temporizador está activamente contando hacia abajo.
  bool _isTimerRunning = false;
  // Instancia del temporizador de Dart.
  Timer? _timer;

  // --- Estadísticas de la sesión actual (acumuladas en memoria antes de guardar) ---
  // Estas variables acumulan los datos de la sesión actual de Pomodoro
  // y se guardan en `OverallStats` cuando la sesión se detiene.
  int _currentSessionWorkTimeMinutes = 0;
  int _currentSessionBreakTimeMinutes = 0;
  int _currentSessionPomodorosCompleted = 0;

  /// Constructor del provider.
  /// Requiere una implementación del repositorio para interactuar con los datos.
  PomodoroManuscriptAppProvider({required PomodoroManuscriptAppRepository repository})
      : _repository = repository {
    _loadInitialData(); // Carga los datos iniciales al crear el provider.
  }

  // --- Getters para acceder al estado desde la UI ---
  AppConfig get appConfig => _appConfig;
  OverallStats get overallStats => _overallStats;
  PomodoroTimerState get timerState => _timerState;
  Duration get remainingTime => _remainingTime;
  int get currentCyclePomodoros => _currentCyclePomodoros;
  bool get isTimerRunning => _isTimerRunning;

  // --- Métodos de inicialización y carga de datos ---

  /// Carga la configuración y estadísticas iniciales desde el repositorio.
  Future<void> _loadInitialData() async {
    _appConfig = await _repository.getAppConfig();
    _overallStats = await _repository.getOverallStats();
    // Inicializa el temporizador para la fase de trabajo con la configuración cargada.
    _resetTimerForPhase(PomodoroTimerState.work);
    notifyListeners(); // Notifica a los oyentes que el estado inicial ha sido cargado.
  }

  // --- Métodos para gestionar la configuración de la aplicación (AppConfig) ---

  /// Actualiza la configuración de los tiempos del Pomodoro y la guarda en el repositorio.
  Future<void> updatePomodoroSettings(PomodoroSettings newSettings) async {
    _appConfig = _appConfig.copyWith(settings: newSettings);
    await _repository.saveAppConfig(_appConfig);
    // Si el temporizador está detenido, reinícialo con la nueva duración de trabajo.
    if (_timerState == PomodoroTimerState.stopped) {
      _resetTimerForPhase(PomodoroTimerState.work);
    } else if (_timerState == PomodoroTimerState.work) {
      // Si está en fase de trabajo, actualiza el tiempo restante si la duración de trabajo cambió.
      // Esto podría interrumpir un Pomodoro en curso, pero asegura que la UI refleje la nueva configuración.
      _remainingTime = Duration(minutes: newSettings.workDurationMinutes);
    }
    notifyListeners();
  }

  /// Actualiza el perfil de usuario (nombre y saludo) y lo guarda en el repositorio.
  Future<void> updateUserProfile(UserProfile newUserProfile) async {
    _appConfig = _appConfig.copyWith(userProfile: newUserProfile);
    await _repository.saveAppConfig(_appConfig);
    notifyListeners();
  }

  // --- Métodos para gestionar las estadísticas generales (OverallStats) ---

  /// Añade una estadística de sesión de Pomodoro al historial y actualiza las estadísticas generales.
  /// Este método es llamado internamente por `_saveCurrentSessionStats`.
  Future<void> _addPomodoroStatistic(PomodoroStatistic statistic) async {
    await _repository.addPomodoroStatistic(statistic);
    // Recarga las estadísticas completas para asegurar que el estado local esté sincronizado.
    _overallStats = await _repository.getOverallStats();
    notifyListeners();
  }

  /// Reinicia todas las estadísticas generales a sus valores por defecto.
  Future<void> resetOverallStats() async {
    _overallStats = const OverallStats();
    await _repository.updateOverallStats(_overallStats);
    notifyListeners();
  }

  // --- Métodos para gestionar el temporizador Pomodoro ---

  /// Inicia o reanuda el temporizador.
  void startTimer() {
    if (_isTimerRunning) return; // Si ya está corriendo, no hacer nada.

    // Si el tiempo ha terminado y no estamos en estado detenido,
    // significa que una fase acaba de terminar y debemos pasar a la siguiente.
    if (_remainingTime == Duration.zero && _timerState != PomodoroTimerState.stopped) {
      _moveToNextPhase();
      return;
    }
    // Si el temporizador está detenido, inicializa para la fase de trabajo.
    if (_timerState == PomodoroTimerState.stopped) {
      _resetTimerForPhase(PomodoroTimerState.work);
    }

    _isTimerRunning = true;
    // Inicia un temporizador periódico que llama a `_tick` cada segundo.
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    notifyListeners();
  }

  /// Pausa el temporizador.
  void pauseTimer() {
    if (!_isTimerRunning) return; // Si no está corriendo, no hacer nada.
    _timer?.cancel(); // Cancela el temporizador actual.
    _isTimerRunning = false;
    _timerState = PomodoroTimerState.paused; // Establece el estado a pausado.
    notifyListeners();
  }

  /// Detiene el temporizador, reinicia la sesión actual y guarda las estadísticas acumuladas.
  void stopTimer() {
    _timer?.cancel(); // Cancela cualquier temporizador activo.
    _isTimerRunning = false;
    _timerState = PomodoroTimerState.stopped; // Establece el estado a detenido.
    _resetTimerForPhase(PomodoroTimerState.work); // Reinicia el tiempo restante a la duración de trabajo por defecto.

    _saveCurrentSessionStats(); // Guarda las estadísticas acumuladas de la sesión actual.
    _resetCurrentSessionStats(); // Reinicia los acumuladores de la sesión.
    _currentCyclePomodoros = 0; // Reinicia el contador de Pomodoros en el ciclo.
    notifyListeners();
  }

  /// Método que se ejecuta cada segundo mientras el temporizador está activo.
  void _tick() {
    if (_remainingTime.inSeconds > 0) {
      _remainingTime = _remainingTime - const Duration(seconds: 1);
      notifyListeners();
    } else {
      // Si el tiempo llega a cero, cancela el temporizador y pasa a la siguiente fase.
      _timer?.cancel();