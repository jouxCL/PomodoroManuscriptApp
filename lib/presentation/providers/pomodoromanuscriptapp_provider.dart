Aquí tienes el código Dart completo para el `ChangeNotifier` del estado de la aplicación "PomodoroManuscriptApp", siguiendo todas las reglas y correcciones solicitadas.

**Estructura de Archivos (según las correcciones de nombres):**

lib/
├── models/
│   └── pomodoro_manuscript_app_model.dart  (EXISTENTE)
├── datasources/
│   └── pomodoro_manuscript_app_local_datasource.dart (EXISTENTE)
├── repositories/
│   └── pomodoro_manuscript_app_repository.dart (EXISTENTE)
└── providers/
    └── pomodoro_manuscript_app_provider.dart (NUEVO ARCHIVO)

---

### `lib/providers/pomodoro_manuscript_app_provider.dart`

import 'dart:async'; // Para el uso de Timer
import 'package:flutter/material.dart'; // Para ChangeNotifier y debugPrint

// Importaciones de los modelos y repositorios proporcionados
import '../models/pomodoro_manuscript_app_model.dart';
import '../repositories/pomodoro_manuscript_app_repository.dart';

/// Enum para representar las diferentes fases del ciclo Pomodoro.
enum PomodoroPhase {
  work,
  shortBreak,
  longBreak,
}

/// [PomodoroManuscriptAppProvider] es un ChangeNotifier que gestiona el estado
/// global de la aplicación Pomodoro.
///
/// Se encarga de la lógica del temporizador, la gestión de las fases,
/// la actualización de estadísticas y la persistencia de datos a través del repositorio.
class PomodoroManuscriptAppProvider extends ChangeNotifier {
  final PomodoroManuscriptAppRepository _repository;

  // --- Estado interno del Provider ---
  PomodoroManuscriptAppState _appState = PomodoroManuscriptAppState.initial();
  Timer? _timer;
  int _remainingSeconds = 0;
  PomodoroPhase _currentPhase = PomodoroPhase.work;
  int _pomodoroCyclesCompletedInSession = 0; // Cuenta los ciclos de trabajo completados en la sesión actual
  bool _isRunning = false;
  bool _isInitialized = false; // Indica si el estado inicial ha sido cargado

  /// Constructor del provider.
  /// Requiere una instancia de [PomodoroManuscriptAppRepository] para interactuar con los datos.
  PomodoroManuscriptAppProvider({required PomodoroManuscriptAppRepository repository})
      : _repository = repository {
    _loadInitialState(); // Carga el estado inicial al crear el provider
  }

  // --- Getters para acceder al estado desde la UI ---
  PomodoroSettings get currentSettings => _appState.settings;
  ProductivityStats get currentStats => _appState.stats;
  UserPreferences get currentUserPreferences => _appState.preferences;
  PomodoroPhase get currentPhase => _currentPhase;
  bool get isRunning => _isRunning;
  int get pomodoroCyclesCompletedInSession => _pomodoroCyclesCompletedInSession;
  bool get isInitialized => _isInitialized;
  int get remainingSeconds => _remainingSeconds; // Exponer segundos restantes directamente

  /// Retorna el tiempo restante formateado como "MM:SS".
  String get remainingTimeFormatted {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Carga el estado inicial de la aplicación desde el repositorio.
  /// Si no hay estado guardado, utiliza el estado inicial por defecto.
  Future<void> _loadInitialState() async {
    _appState = await _repository.getAppState();
    // Establece la duración inicial del temporizador según la configuración cargada
    _remainingSeconds = _appState.settings.workDurationMinutes * 60;
    _isInitialized = true;
    notifyListeners(); // Notifica a los listeners que el estado ha sido inicializado
    debugPrint('PomodoroManuscriptAppProvider: Estado inicial cargado: $_appState');
  }

  /// Inicia o reanuda el temporizador.
  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), _tick);
      notifyListeners();
      debugPrint('PomodoroManuscriptAppProvider: Temporizador iniciado. Fase: $_currentPhase, Restante: $_remainingSeconds s');
    }
  }

  /// Pausa el temporizador.
  void pauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _timer = null;
      _isRunning = false;
      notifyListeners();
      debugPrint('PomodoroManuscriptAppProvider: Temporizador pausado.');
    }
  }

  /// Detiene el temporizador y lo reinicia a la duración inicial de la fase actual.
  void resetTimer() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
    _remainingSeconds = _getDurationForPhase(_currentPhase) * 60;
    notifyListeners();
    debugPrint('PomodoroManuscriptAppProvider: Temporizador reiniciado para la fase actual: $_currentPhase.');
  }

  /// Avanza inmediatamente a la siguiente fase del ciclo Pomodoro.
  /// El temporizador se pausa al saltar de fase.
  void skipPhase() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false; // Asegura que el temporizador esté pausado al saltar
    _moveToNextPhase(autoStartNext: false); // No auto-iniciar la siguiente fase al saltar
    debugPrint('PomodoroManuscriptAppProvider: Fase saltada. Moviendo a la siguiente fase.');
  }

  /// Método llamado cada segundo por el [Timer].
  /// Decrementa el tiempo restante y gestiona la transición de fase cuando el tiempo llega a cero.
  void _tick(Timer timer) {
    if (_remainingSeconds > 0) {
      _remainingSeconds--;
      notifyListeners();
    } else {
      // El temporizador ha llegado a cero, cancelar y mover a la siguiente fase
      _timer?.cancel();
      _timer = null;
      _isRunning = false; // El temporizador ya no está corriendo en este punto
      _moveToNextPhase(autoStartNext: true); // Indica que la siguiente fase debe iniciarse automáticamente
    }
  }

  /// Gestiona la transición a la siguiente fase del ciclo Pomodoro.
  /// Actualiza las estadísticas, guarda el estado y reinicia el temporizador si `autoStartNext` es true.
  Future<void> _moveToNextPhase({bool autoStartNext = false}) async {
    int durationInMinutes;
    int previousPhaseDurationSeconds = 0; // Para acumular estadísticas de la fase recién terminada

    switch (_currentPhase) {
      case PomodoroPhase.work:
        // Acumula tiempo de trabajo y pomodoros completados
        previousPhaseDurationSeconds = _appState.settings.workDurationMinutes * 60;
        _appState = _appState.copyWith(
          stats: _appState.stats.copyWith(
            completedPomodoros: _appState.stats.completedPomodoros + 1,
            totalWorkTimeSeconds: _appState.stats.totalWorkTimeSeconds + previousPhaseDurationSeconds,
          ),
        );
        _pomodoroCyclesCompletedInSession++;

        if (_pomodoroCyclesCompletedInSession % _appState.settings.pomodoroCyclesBeforeLongBreak == 0) {
          _currentPhase = PomodoroPhase.longBreak;
          durationInMinutes = _appState.settings.longBreakDurationMinutes;
          debugPrint('PomodoroManuscriptAppProvider: Moviendo a Descanso Largo. Ciclos completados en sesión: $_pomodoroCyclesCompletedInSession');
        } else {
          _currentPhase = PomodoroPhase.shortBreak;
          durationInMinutes = _appState.settings.shortBreakDurationMinutes;
          debugPrint('PomodoroManuscriptAppProvider: Moviendo a Descanso Corto. Ciclos completados en sesión: $_pomodoroCyclesCompletedInSession');
        }
        break;

      case PomodoroPhase.shortBreak:
        // Acumula tiempo de descanso
        previousPhaseDurationSeconds = _appState.settings.shortBreakDurationMinutes * 60;
        _appState = _appState.copyWith(
          stats: _appState.stats.copyWith(
            totalBreakTimeSeconds: _appState.stats.totalBreakTimeSeconds + previousPhaseDurationSeconds,
          ),
        );
        _currentPhase = PomodoroPhase.work;
        durationInMinutes = _appState.settings.workDurationMinutes;
        debugPrint('PomodoroManuscriptAppProvider: Moviendo a Trabajo después de Descanso Corto.');
        break;

      case PomodoroPhase.longBreak:
        // Acumula tiempo de descanso
        previousPhaseDurationSeconds = _appState.settings.longBreakDurationMinutes * 60;
        _appState = _appState.copyWith(
          stats: _appState.stats.copyWith(
            totalBreakTimeSeconds: _appState.stats.totalBreakTimeSeconds + previousPhaseDurationSeconds,
          ),
        );
        _currentPhase = PomodoroPhase.work;
        durationInMinutes = _appState.settings.workDurationMinutes;
        // Reinicia los ciclos de sesión después de un descanso largo
        _pomodoroCyclesCompletedInSession = 0;
        debugPrint('PomodoroManuscriptAppProvider: Moviendo a Trabajo después de Descanso Largo. Ciclos de sesión reiniciados.');
        break;
    }

    _remainingSeconds = durationInMinutes * 60;
    await _repository.updateAppState(_appState); // Guarda las estadísticas actualizadas
    notifyListeners();

    if (autoStartNext) {
      startTimer(); // Reinicia el temporizador para la nueva fase
    }
  }

  /// Actualiza la configuración de los tiempos del Pomodoro.
  /// Persiste los cambios y actualiza el tiempo restante si el temporizador no está activo.
  Future<void> updateSettings(PomodoroSettings newSettings) async {
    _appState = _appState.copyWith(settings: newSettings);
    await _repository.updateAppState(_appState);
    // Si la duración de la fase actual cambió, actualiza los segundos restantes
    // solo si el temporizador no está corriendo para evitar interrupciones.
    if (!_isRunning) {
      _remainingSeconds = _getDurationForPhase(_currentPhase) * 60;
    }
    notifyListeners();
    debugPrint('PomodoroManuscriptAppProvider: Configuración actualizada: $newSettings');
  }

  /// Actualiza el nombre de usuario.
  /// Persiste los cambios.
  Future<void> updateUserName(String newName) async {
    _appState = _appState.copyWith(preferences: _appState.preferences.copyWith(userName: newName));
    await _repository.updateAppState(_appState);
    notifyListeners();
    debugPrint('PomodoroManuscriptAppProvider: Nombre de usuario actualizado a: $newName');
  }

  /// Método auxiliar para obtener la duración en minutos de una fase específica.
  int _getDurationForPhase(PomodoroPhase phase) {
    switch (phase) {
      case PomodoroPhase.work:
        return _appState.settings.workDurationMinutes;
      case PomodoroPhase.shortBreak:
        return _appState.settings.shortBreakDurationMinutes;
      case PomodoroPhase.longBreak:
        return _appState.settings.longBreakDurationMinutes;
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador cuando el provider es desechado
    super.dispose();
    debugPrint('PomodoroManuscriptAppProvider: Disposed.');
  }
}