Aquí tienes el código Dart completo para el `ChangeNotifier` (Provider) de estado de la aplicación "PomodoroManuscriptApp", siguiendo estrictamente las reglas y utilizando exclusivamente los modelos y repositorios proporcionados.

Este provider gestiona el estado global de la aplicación, incluyendo la configuración del Pomodoro, las estadísticas de productividad, el estado actual del temporizador y el nombre de usuario, interactuando con el `PomodoroManuscriptAppRepository` para persistir los datos.

// providers/pomodoro_manuscript_app_provider.dart
import 'dart:async'; // Necesario para Timer
import 'package:flutter/material.dart'; // Necesario para ChangeNotifier

// Importa los modelos y repositorios desde la base de código proporcionada
import '../models/pomodoro_manuscript_app_model.dart';
import '../repositories/pomodoro_manuscript_app_repository.dart';

/// [PomodoroManuscriptAppProvider] gestiona el estado global de la aplicación
/// Pomodoro Manuscript, incluyendo la lógica del temporizador, la configuración
/// del usuario y las estadísticas de productividad.
///
/// Utiliza [ChangeNotifier] para notificar a los widgets escuchadores sobre
/// los cambios de estado y se comunica con [PomodoroManuscriptAppRepository]
/// para la persistencia de datos.
class PomodoroManuscriptAppProvider with ChangeNotifier {
  final PomodoroManuscriptAppRepository _repository;

  // Estado interno de la aplicación, que se carga y guarda a través del repositorio.
  AppState _appState;

  // Temporizador de Dart para la cuenta regresiva.
  Timer? _timer;

  // Segundos restantes en la fase actual del temporizador.
  // Este es un estado transitorio que no se persiste directamente en AppState.
  int _currentRemainingSeconds;

  /// Constructor del provider.
  /// Requiere una instancia de [PomodoroManuscriptAppRepository] para la gestión de datos.
  PomodoroManuscriptAppProvider({required PomodoroManuscriptAppRepository repository})
      : _repository = repository,
        _appState = AppState(), // Inicializa con un estado por defecto
        _currentRemainingSeconds = PomodoroSettings().pomodoroDurationMinutes * 60 {
    // Inicializa los segundos restantes con la duración por defecto de un Pomodoro.
    _loadInitialState(); // Carga el estado inicial de forma asíncrona.
  }

  // --- Getters para que la UI consuma el estado ---
  String get userName => _appState.userName;
  PomodoroSettings get settings => _appState.settings;
  ProductivityStats get stats => _appState.stats;
  TimerPhase get currentTimerPhase => _appState.currentTimerPhase;
  int get currentPomodoroCycle => _appState.currentPomodoroCycle;
  int get currentRemainingSeconds => _currentRemainingSeconds;

  /// Indica si el temporizador está actualmente en ejecución (no pausado ni detenido).
  bool get isTimerRunning => _timer != null && _timer!.isActive;

  /// Indica si el temporizador está en estado de pausa.
  bool get isTimerPaused => _appState.currentTimerPhase == TimerPhase.paused;

  /// Indica si el temporizador está en estado detenido.
  bool get isTimerStopped => _appState.currentTimerPhase == TimerPhase.stopped;

  // --- Inicialización y Carga de Estado ---

  /// Carga el estado inicial de la aplicación desde el repositorio.
  /// Se llama una vez al inicializar el provider.
  Future<void> _loadInitialState() async {
    _appState = await _repository.getAppState();
    _initializeRemainingSeconds(); // Configura los segundos restantes según el estado cargado.
    notifyListeners(); // Notifica a los escuchadores que el estado ha cambiado.
  }

  /// Inicializa [_currentRemainingSeconds] basándose en la fase actual del temporizador
  /// y la configuración.
  ///
  /// Nota: Si el temporizador estaba en pausa o detenido al cerrar la app,
  /// los segundos restantes exactos no se persisten. Por lo tanto, se reinicia
  /// a la duración completa de la fase correspondiente (o Pomodoro por defecto).
  void _initializeRemainingSeconds() {
    switch (_appState.currentTimerPhase) {
      case TimerPhase.pomodoro:
        _currentRemainingSeconds = _appState.settings.pomodoroDurationMinutes * 60;
        break;
      case TimerPhase.shortBreak:
        _currentRemainingSeconds = _appState.settings.shortBreakDurationMinutes * 60;
        break;
      case TimerPhase.longBreak:
        _currentRemainingSeconds = _appState.settings.longBreakDurationMinutes * 60;
        break;
      case TimerPhase.stopped:
      case TimerPhase.paused:
        // Si estaba detenido o pausado, reiniciamos a la duración completa de un Pomodoro.
        // Esto es una limitación del modelo AppState que no guarda los segundos restantes.
        _currentRemainingSeconds = _appState.settings.pomodoroDurationMinutes * 60;
        break;
    }
  }

  // --- Acciones relacionadas con el Usuario ---

  /// Actualiza el nombre de usuario y lo persiste en el repositorio.
  Future<void> updateUserName(String newName) async {
    _appState = _appState.copyWith(userName: newName);
    await _repository.updateUserName(newName);
    notifyListeners();
  }

  // --- Acciones relacionadas con la Configuración ---

  /// Actualiza la configuración del temporizador Pomodoro y la persiste.
  Future<void> updatePomodoroSettings(PomodoroSettings newSettings) async {
    _appState = _appState.copyWith(settings: newSettings);
    await _repository.updatePomodoroSettings(newSettings);
    // Si la configuración cambia mientras el temporizador está detenido o pausado,
    // actualiza los segundos restantes para reflejar la nueva configuración.
    if (isTimerStopped || isTimerPaused) {
      _initializeRemainingSeconds();
    }
    notifyListeners();
  }

  // --- Acciones de Control del Temporizador ---

  /// Inicia el temporizador. Si ya está corriendo, no hace nada.
  /// Si estaba detenido o pausado, lo inicia en la fase Pomodoro.
  void startTimer() {
    if (isTimerRunning) return;

    // Si el temporizador estaba detenido o pausado, lo reiniciamos a la fase Pomodoro.
    if (_appState.currentTimerPhase == TimerPhase.stopped || _appState.currentTimerPhase == TimerPhase.paused) {
      _setTimerPhase(TimerPhase.pomodoro); // Establece la fase a Pomodoro
      _currentRemainingSeconds = _appState.settings.pomodoroDurationMinutes * 60; // Reinicia segundos
    }
    
    // Inicia el temporizador que se ejecuta cada segundo.
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    notifyListeners();
  }

  /// Pausa el temporizador. Si no está corriendo, no hace nada.
  void pauseTimer() {
    if (!isTimerRunning) return;

    _timer?.cancel(); // Cancela el temporizador actual.
    _timer = null; // Elimina la referencia al temporizador.
    _setTimerPhase(TimerPhase.paused); // Establece la fase a pausada.
    notifyListeners();
  }

  /// Detiene completamente el temporizador y lo reinicia.
  void stopTimer() {
    _timer?.cancel(); // Cancela el temporizador actual.
    _timer = null; // Elimina la referencia al temporizador.
    _setTimerPhase(TimerPhase.stopped); // Establece la fase a detenida.
    _initializeRemainingSeconds(); // Reinicia los segundos restantes a la duración por defecto de Pomodoro.
    notifyListeners();
  }

  // --- Lógica Interna del Temporizador ---

  /// Método llamado cada segundo por el [Timer].
  void _tick() {
    if (_currentRemainingSeconds > 0) {
      _currentRemainingSeconds--;
      notifyListeners();
    } else {
      _timer?.cancel(); // Detiene el temporizador actual al llegar a cero.
      _advancePhase(); // Avanza a la siguiente fase.
    }
  }

  /// Avanza el temporizador a la siguiente fase (Pomodoro, descanso corto, descanso largo).
  /// Actualiza las estadísticas y el ciclo de Pomodoro según la lógica.
  Future<void> _advancePhase() async {
    TimerPhase nextPhase;
    int nextRemainingSeconds;
    ProductivityStats updatedStats = _appState.stats;
    int updatedPomodoroCycle = _appState.currentPomodoroCycle;

    switch (_appState.currentTimerPhase) {
      case TimerPhase.pomodoro:
        // Actualiza las estadísticas por un Pomodoro completado
        updatedStats = updatedStats.copyWith(
          totalPomodorosCompleted: updatedStats.totalPomodorosCompleted + 1,
          totalFocusTimeSeconds: updatedStats.totalFocusTimeSeconds + (_appState.settings.pomodoroDurationMinutes * 60),
        );
        updatedPomodoroCycle++; // Incrementa el contador de ciclos

        // Determina si es un descanso corto o largo
        if (updatedPomodoroCycle % _appState.settings.cyclesBeforeLongBreak == 0) {
          nextPhase = TimerPhase.longBreak;
          nextRemainingSeconds = _appState.settings.longBreakDurationMinutes * 60;
        } else {
          nextPhase = TimerPhase.shortBreak;
          nextRemainingSeconds = _appState.settings.shortBreakDurationMinutes * 60;
        }
        break;

      case TimerPhase.shortBreak:
        // Actualiza las estadísticas por un descanso corto completado
        updatedStats = updatedStats.copyWith(
          totalBreakTimeSeconds: updatedStats.totalBreakTimeSeconds + (_appState.settings.shortBreakDurationMinutes * 60),
        );
        nextPhase = TimerPhase.pomodoro;
        nextRemainingSeconds = _appState.settings.pomodoroDurationMinutes * 60;
        break;

      case TimerPhase.longBreak:
        // Actualiza las estadísticas por un descanso largo completado
        updatedStats = updatedStats.copyWith(
          totalBreakTimeSeconds: updatedStats.totalBreakTimeSeconds + (_appState.settings.longBreakDurationMinutes * 60),
        );
        updatedPomodoroCycle = 0; // Reinicia el ciclo después de un descanso largo
        nextPhase = TimerPhase.pomodoro;
        nextRemainingSeconds = _appState.settings.pomodoroDurationMinutes * 60;
        break;

      case TimerPhase.stopped:
      case TimerPhase.paused:
        // Este caso no debería ocurrir si el temporizador está funcionando y completa una fase.
        // Si por alguna razón se llega aquí, se reinicia a un Pomodoro.
        nextPhase = TimerPhase.pomodoro;
        nextRemainingSeconds = _appState.settings.pomodoroDurationMinutes * 60;