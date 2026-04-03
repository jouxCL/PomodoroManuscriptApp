Aquí tienes el código Dart completo para el `ChangeNotifier` provider de estado para tu aplicación "PomodoroManuscriptApp", siguiendo estrictamente tus requisitos y utilizando **EXCLUSIVAMENTE** los modelos y repositorios proporcionados.

Este provider gestionará la lógica del temporizador, la configuración, las estadísticas y la información del usuario, interactuando directamente con el `PomodoroManuscriptRepository`.

// lib/providers/pomodoro_manuscript_provider.dart

import 'package:flutter/material.dart';
import 'dart:async'; // Necesario para el Timer

// Importa los modelos y repositorios proporcionados
import '../models/pomodoromanuscriptapp_model.dart';
import '../datasources/pomodoromanuscriptapp_local_datasource.dart'; // Necesario para instanciar el repositorio
import '../repositories/pomodoromanuscriptapp_repository.dart';

/// Enum para representar el estado actual del temporizador.
enum TimerState {
  stopped,
  running,
  paused,
}

/// Enum para representar el tipo de ciclo actual del Pomodoro.
enum CycleType {
  pomodoro,
  shortBreak,
  longBreak,
}

/// Provider de estado para la aplicación PomodoroManuscriptApp.
/// Gestiona la configuración, estadísticas, información del usuario y la lógica del temporizador.
class PomodoroManuscriptProvider with ChangeNotifier {
  final PomodoroManuscriptRepository _repository;

  // --- Estado interno de la aplicación (basado en PomodoroManuscriptData) ---
  PomodoroManuscriptData? _data; // Contiene la configuración, estadísticas y usuario
  bool _isLoading = true; // Indica si los datos iniciales están cargando

  // --- Estado específico del temporizador ---
  Timer? _timer; // El temporizador real de Dart
  TimerState _timerState = TimerState.stopped; // Estado actual del temporizador
  CycleType _currentCycleType = CycleType.pomodoro; // Tipo de ciclo actual (Pomodoro, descanso corto/largo)
  int _remainingTime = 0; // Tiempo restante en segundos para el ciclo actual
  int _pomodorosInCycle = 0; // Contador de Pomodoros completados en el ciclo actual para el descanso largo

  /// Constructor del provider. Requiere una instancia de [PomodoroManuscriptRepository].
  /// Inicia la carga de los datos iniciales de la aplicación.
  PomodoroManuscriptProvider(this._repository) {
    _loadInitialData();
  }

  // --- Getters para acceder al estado desde la UI ---

  bool get isLoading => _isLoading;
  String get userName => _data?.userName ?? '';
  bool get isFirstLaunch => _data?.isFirstLaunch ?? true;

  // Configuración del temporizador
  int get pomodoroDurationMinutes => _data?.pomodoroDuration ?? 25;
  int get shortBreakDurationMinutes => _data?.shortBreakDuration ?? 5;
  int get longBreakDurationMinutes => _data?.longBreakDuration ?? 15;
  int get longBreakInterval => _data?.longBreakInterval ?? 3;

  // Estadísticas de productividad
  int get completedPomodoros => _data?.completedPomodoros ?? 0;
  int get totalPomodoroTimeMinutes => _data?.totalPomodoroTime ?? 0;
  int get totalBreakTimeMinutes => _data?.totalBreakTime ?? 0;

  // Estado actual del temporizador
  TimerState get timerState => _timerState;
  CycleType get currentCycleType => _currentCycleType;
  int get remainingTimeSeconds => _remainingTime; // Para mostrar la cuenta regresiva
  int get currentCyclePomodoros => _pomodorosInCycle; // Para mostrar el progreso hacia el descanso largo

  // --- Métodos de inicialización ---

  /// Carga los datos iniciales de la aplicación desde el repositorio.
  /// Establece el tiempo inicial del temporizador y notifica a los listeners.
  Future<void> _loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    _data = await _repository.getPomodoroData();
    // Inicializa el tiempo restante con la duración del Pomodoro por defecto
    _setTimerForPhase(_currentCycleType);

    _isLoading = false;
    notifyListeners();
  }

  // --- Métodos de gestión del temporizador ---

  /// Establece la duración del temporizador y el tipo de ciclo actual.
  /// Convierte la duración de minutos a segundos.
  void _setTimerForPhase(CycleType type) {
    _currentCycleType = type;
    int durationInMinutes;
    switch (type) {
      case CycleType.pomodoro:
        durationInMinutes = pomodoroDurationMinutes;
        break;
      case CycleType.shortBreak:
        durationInMinutes = shortBreakDurationMinutes;
        break;
      case CycleType.longBreak:
        durationInMinutes = longBreakDurationMinutes;
        break;
    }
    _remainingTime = durationInMinutes * 60; // Convertir a segundos
    notifyListeners();
  }

  /// Inicia o reanuda el temporizador.
  void startTimer() {
    if (_timerState == TimerState.running) return; // Ya está corriendo

    if (_timerState == TimerState.stopped) {
      // Si se inicia desde parado, asegúrate de que el tiempo restante esté configurado
      _setTimerForPhase(_currentCycleType);
    }

    _timerState = TimerState.running;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    notifyListeners();
  }

  /// Pausa el temporizador.
  void pauseTimer() {
    if (_timerState != TimerState.running) return; // No está corriendo para pausar

    _timer?.cancel();
    _timerState = TimerState.paused;
    notifyListeners();
  }

  /// Reinicia el temporizador al inicio de la fase actual.
  void resetTimer() {
    _timer?.cancel();
    _timerState = TimerState.stopped;
    _setTimerForPhase(_currentCycleType); // Restablecer a la duración inicial de la fase actual
    notifyListeners();
  }

  /// Salta el ciclo actual y avanza al siguiente.
  Future<void> skipTimer() async {
    _timer?.cancel();
    await _moveToNextCycle(); // Mover al siguiente ciclo y actualizar estadísticas
    _timerState = TimerState.stopped; // El temporizador se detiene después de saltar
    notifyListeners();
  }

  /// Método privado llamado cada segundo por el [Timer].
  /// Decrementa el tiempo restante o avanza al siguiente ciclo si el tiempo llega a cero.
  Future<void> _tick() async {
    if (_remainingTime > 0) {
      _remainingTime--;
    } else {
      _timer?.cancel();
      await _moveToNextCycle();
    }
    notifyListeners();
  }

  /// Lógica para avanzar al siguiente ciclo (Pomodoro -> Descanso Corto -> Pomodoro -> ... -> Descanso Largo).
  Future<void> _moveToNextCycle() async {
    if (_currentCycleType == CycleType.pomodoro) {
      // Un Pomodoro ha sido completado
      _pomodorosInCycle++;
      await _incrementCompletedPomodoros(); // Actualizar estadísticas
      await _addPomodoroTime(pomodoroDurationMinutes); // Añadir tiempo a estadísticas

      if (_pomodorosInCycle >= longBreakInterval) {
        // Es hora de un descanso largo
        _pomodorosInCycle = 0; // Reiniciar el contador para el próximo ciclo de descanso largo
        _setTimerForPhase(CycleType.longBreak);
        await _addBreakTime(longBreakDurationMinutes); // Añadir tiempo a estadísticas
      } else {
        // Es hora de un descanso corto
        _setTimerForPhase(CycleType.shortBreak);
        await _addBreakTime(shortBreakDurationMinutes); // Añadir tiempo a estadísticas
      }
    } else {
      // Un descanso (corto o largo) ha terminado, volver a Pomodoro
      _setTimerForPhase(CycleType.pomodoro);
    }

    // Si el temporizador estaba corriendo, reinícialo para la nueva fase
    if (_timerState == TimerState.running) {
      startTimer();
    } else {
      // Si estaba pausado o detenido, asegúrate de que el estado sea 'stopped'
      _timerState = TimerState.stopped;
      notifyListeners();
    }
  }

  // --- Métodos de gestión de configuración ---

  /// Actualiza la configuración de los tiempos del Pomodoro y los descansos.
  /// Persiste los cambios a través del repositorio y actualiza el estado local.
  Future<void> updatePomodoroSettings({
    required int pomodoroDuration,
    required int shortBreakDuration,
    required int longBreakDuration,
    required int longBreakInterval,
  }) async {
    if (_data == null) return; // Los datos deben estar cargados

    await _repository.updatePomodoroSettings(
      pomodoroDuration: pomodoroDuration,
      shortBreakDuration: shortBreakDuration,
      longBreakDuration: longBreakDuration,
      longBreakInterval: longBreakInterval,
    );
    // Actualizar el estado local con los nuevos valores
    _data = _data!.copyWith(
      pomodoroDuration: pomodoroDuration,
      shortBreakDuration: shortBreakDuration,
      longBreakDuration: longBreakDuration,
      longBreakInterval: longBreakInterval,
    );
    // Si el temporizador está detenido, actualiza su duración para reflejar la nueva configuración
    if (_timerState == TimerState.stopped) {
      _setTimerForPhase(_currentCycleType);
    }
    notifyListeners();
  }

  // --- Métodos de gestión de estadísticas ---

  /// Incrementa el contador de Pomodoros completados.
  /// Persiste el cambio y actualiza el estado local.
  Future<void> _incrementCompletedPomodoros() async {
    if (_data == null) return;
    int newCompleted = _data!.completedPomodoros + 1;
    await _repository.updateStatistics(completedPomodoros: newCompleted);
    _data = _data!.copyWith(completedPomodoros: newCompleted);
    // notifyListeners() se llamará en _moveToNextCycle
  }

  /// Añade tiempo a las estadísticas de tiempo total de Pomodoro.
  /// Persiste el cambio y actualiza el estado local.
  Future<void> _addPomodoroTime(int minutes) async {
    if (_data == null) return;
    int newTotalTime = _data!.totalPomodoroTime + minutes;
    await _repository.updateStatistics(totalPomodoroTime: newTotalTime);
    _data = _data!.copyWith(totalPomodoroTime: newTotalTime);
    // notifyListeners() se llamará en _moveToNextCycle
  }

  /// Añade tiempo a las estadísticas de tiempo total de descanso.
  /// Persiste el cambio y actualiza el estado local.
  Future<void> _addBreakTime(int minutes) async {
    if (_data == null) return;
    int newTotalTime = _data!.totalBreakTime + minutes;
    await _repository.updateStatistics(totalBreakTime: newTotalTime);
    _data = _data!.copyWith(totalBreakTime: newTotalTime);
    // notifyListeners() se llamará en _moveToNextCycle
  }

  // --- Métodos de gestión de usuario ---

  /// Establece el nombre del usuario.
  /// Persiste el cambio y actualiza el estado local.
  Future<void> setUserName(String name) async {
    if (_data == null) return;
    await _repository.setUserName(name);
    _data = _data!.copyWith(userName: name);
    notifyListeners();
  }

  /// Marca que el proceso de primer lanzamiento ha sido completado.
  /// Persiste el cambio y actualiza el estado local.
  Future<void> markFirstLaunchComplete() async {
    if (_data == null) return;
    await _repository.markFirstLaunchComplete();
    _data = _data!.copyWith(isFirstLaunch: false);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Asegúrate de cancelar el temporizador para evitar fugas de memoria
    super.dispose();
  }
}