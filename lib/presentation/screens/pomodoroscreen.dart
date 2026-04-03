Aquí tienes el código Dart completo y funcional para la `PomodoroScreen`, incluyendo un *stub* de `PomodoroProvider` para asegurar que el código compile y demuestre la integración con la gestión de estado requerida.

**Nota importante sobre las importaciones:**
El requisito "Importa solo: `package:flutter/material.dart`" entra en conflicto con la "NOTA ESPECIAL Y ESTRICTA DEL USUARIO" que exige "Integra la gestión de estado... desde `pomodoromanuscriptapp_provider.dart`" usando `Consumer`, `context.watch` o `context.read`. Para cumplir con esta última y crítica instrucción, es indispensable importar `package:provider/provider.dart`. Además, para la funcionalidad del temporizador, se requiere `dart:async`. He priorizado la funcionalidad y la integración de estado según la nota especial, asumiendo que la restricción de importación se refiere principalmente a otros paquetes de UI o utilidades, no a los fundamentales para la gestión de estado o la lógica de tiempo.

---

// pomodoro_screen.dart

import 'dart:async'; // Necesario para la clase Timer
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Necesario para la gestión de estado con Provider

// --- START: pomodoromanuscriptapp_provider.dart STUB ---
// Esta sección simula el contenido del archivo 'pomodoromanuscriptapp_provider.dart'.
// En una aplicación real, este código residiría en su propio archivo:
// lib/providers/pomodoromanuscriptapp_provider.dart
// Se incluye aquí para que PomodoroScreen sea autocontenido y compilable.

/// Enum para representar las diferentes fases del ciclo Pomodoro.
enum PomodoroPhase {
  pomodoro,
  shortBreak,
  longBreak,
}

/// Clase que gestiona el estado del temporizador Pomodoro.
/// Extiende ChangeNotifier para notificar a los oyentes sobre los cambios de estado.
class PomodoroProvider extends ChangeNotifier {
  // Duraciones configurables (valores por defecto)
  Duration _pomodoroDuration = const Duration(minutes: 25);
  Duration _shortBreakDuration = const Duration(minutes: 5);
  Duration _longBreakDuration = const Duration(minutes: 15);
  int _longBreakInterval = 4; // Número de pomodoros antes de un descanso largo

  // Estado actual del temporizador
  PomodoroPhase _currentPhase = PomodoroPhase.pomodoro;
  Duration _remainingTime = const Duration(minutes: 25);
  bool _isRunning = false;
  int _pomodoroCount = 0; // Pomodoros completados en el ciclo actual
  Timer? _timer;

  // Getters para acceder al estado desde los widgets
  Duration get pomodoroDuration => _pomodoroDuration;
  Duration get shortBreakDuration => _shortBreakDuration;
  Duration get longBreakDuration => _longBreakDuration;
  int get longBreakInterval => _longBreakInterval;
  PomodoroPhase get currentPhase => _currentPhase;
  Duration get remainingTime => _remainingTime;
  bool get isRunning => _isRunning;
  int get pomodoroCount => _pomodoroCount;

  PomodoroProvider() {
    // Inicializa el tiempo restante con la duración del Pomodoro por defecto
    _remainingTime = _pomodoroDuration;
  }

  /// Inicia el temporizador.
  void startTimer() {
    if (_isRunning) return; // Evita iniciar si ya está corriendo
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    notifyListeners(); // Notifica a los widgets que el estado ha cambiado
  }

  /// Pausa el temporizador.
  void pauseTimer() {
    if (!_isRunning) return; // Evita pausar si no está corriendo
    _isRunning = false;
    _timer?.cancel(); // Cancela el temporizador actual
    notifyListeners();
  }

  /// Reinicia el temporizador a su estado inicial.
  void resetTimer() {
    _timer?.cancel();
    _isRunning = false;
    _currentPhase = PomodoroPhase.pomodoro;
    _remainingTime = _pomodoroDuration;
    _pomodoroCount = 0;
    notifyListeners();
  }

  /// Salta a la siguiente fase del ciclo Pomodoro.
  void skipPhase() {
    _timer?.cancel();
    _isRunning = false; // Pausa el temporizador al saltar
    _moveToNextPhase();
    notifyListeners();
  }

  /// Actualiza las configuraciones del temporizador.
  void updateSettings({
    Duration? pomodoro,
    Duration? shortBreak,
    Duration? longBreak,
    int? longBreakInterval,
  }) {
    _pomodoroDuration = pomodoro ?? _pomodoroDuration;
    _shortBreakDuration = shortBreak ?? _shortBreakDuration;
    _longBreakDuration = longBreak ?? _longBreakDuration;
    _longBreakInterval = longBreakInterval ?? _longBreakInterval;

    // Si el temporizador no está corriendo, actualiza el tiempo restante
    // para reflejar la nueva configuración de la fase actual.
    if (!_isRunning) {
      if (_currentPhase == PomodoroPhase.pomodoro && pomodoro != null) {
        _remainingTime = _pomodoroDuration;
      } else if (_currentPhase == PomodoroPhase.shortBreak && shortBreak != null) {
        _remainingTime = _shortBreakDuration;
      } else if (_currentPhase == PomodoroPhase.longBreak && longBreak != null) {
        _remainingTime = _longBreakDuration;
      }
    }
    notifyListeners();
  }

  /// Función interna llamada cada segundo por el temporizador.
  void _tick() {
    if (_remainingTime.inSeconds > 0) {
      _remainingTime = _remainingTime - const Duration(seconds: 1);
    } else {
      // El tiempo ha terminado, pasar a la siguiente fase
      _timer?.cancel();
      _isRunning = false; // El temporizador se detiene al finalizar una fase
      _moveToNextPhase();
    }
    notifyListeners();
  }

  /// Lógica para pasar a la siguiente fase del ciclo Pomodoro.
  void _moveToNextPhase() {
    if (_currentPhase == PomodoroPhase.pomodoro) {
      _pomodoroCount++;
      if (_pomodoroCount % _longBreakInterval == 0) {
        _currentPhase = PomodoroPhase.longBreak;
        _remainingTime = _longBreakDuration;
      } else {
        _currentPhase = PomodoroPhase.shortBreak;
        _remainingTime = _shortBreakDuration;
      }
    } else { // Si la fase anterior fue un descanso (corto o largo)
      _currentPhase = PomodoroPhase.pomodoro;
      _remainingTime = _pomodoroDuration;
      // Si acabamos de terminar un descanso largo, reiniciamos el contador de pomodoros
      if (_pomodoroCount % _longBreakInterval == 0 && _