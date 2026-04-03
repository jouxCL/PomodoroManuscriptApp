Aquí tienes el código completo y funcional para la pantalla `PomodoroScreen`, adhiriéndose estrictamente a tus requisitos, incluyendo la arquitectura de estado con un proveedor central simulado para demostración.

**Notas Importantes:**

1.  **Proveedor Central (Mock):** He incluido una versión `Mock` de `PomodoroManuscriptAppProvider` dentro de este mismo archivo. Esto es **SOLO** para que el código compile y sea funcional de forma independiente para esta solicitud. En una aplicación real, este proveedor debería estar definido en `lib/providers/pomodoromanuscriptapp_provider.dart` y ser provisto en el `main.dart` de tu aplicación usando `ChangeNotifierProvider`.
2.  **Paquete `provider`:** Este código asume que tienes el paquete `provider` añadido a tus dependencias en `pubspec.yaml`:
    ```yaml
    dependencies:
      flutter:
        sdk: flutter
      provider: ^6.0.0 # O la versión más reciente
    ```
3.  **Fuentes Personalizadas:** Para la estética de manuscrito, he usado `fontFamily: 'Cursive'` como un marcador de posición. En una aplicación real, deberías importar una fuente personalizada (ej. de Google Fonts o un archivo `.ttf`) en tu `pubspec.yaml` y definirla en tu `ThemeData` global en `main.dart`.
4.  **`main.dart` y Rutas:** Para que la navegación funcione, tu `main.dart` debe configurar `MaterialApp` con las rutas nombradas `/settings` y `/statistics`, y envolver la aplicación con el `ChangeNotifierProvider` para `PomodoroManuscriptAppProvider`.

---

import 'dart:async'; // Necesario para Timer
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Necesario para consumir el proveedor

// =============================================================================
// MOCK PomodoroManuscriptAppProvider
//
// ESTA ES UNA IMPLEMENTACIÓN MOCK DEL PROVEEDOR CENTRAL.
// En una aplicación real, este código debería estar en:
// `lib/providers/pomodoromanuscriptapp_provider.dart`
// y ser importado y provisto en el `main.dart` de tu aplicación.
// Se incluye aquí SÓLO para que PomodoroScreen sea compilable y funcional
// de forma independiente para esta solicitud.
// =============================================================================

/// Enum para representar las diferentes fases del ciclo Pomodoro.
enum PomodoroPhase {
  pomodoro,
  shortBreak,
  longBreak,
}

/// Proveedor central para gestionar el estado de la aplicación Pomodoro.
class PomodoroManuscriptAppProvider extends ChangeNotifier {
  // --- Propiedades de Configuración (con valores por defecto) ---
  int _pomodoroDuration = 25; // minutos
  int _shortBreakDuration = 5; // minutos
  int _longBreakDuration = 15; // minutos
  int _longBreakInterval = 4; // pomodoros antes de un descanso largo

  // --- Propiedades de Estado del Temporizador ---
  PomodoroPhase _currentPhase = PomodoroPhase.pomodoro;
  Duration _remainingTime = const Duration(minutes: 25);
  bool _isTimerRunning = false;
  int _pomodorosCompletedInCycle = 0; // Pomodoros completados desde el último descanso largo
  int _totalCompletedPomodoros = 0; // Total de pomodoros completados en la app
  Duration _totalPomodoroTime = Duration.zero; // Tiempo total en fase Pomodoro

  Timer? _timer;

  // --- Getters para que la UI consuma el estado ---
  int get pomodoroDuration => _pomodoroDuration;
  int get shortBreakDuration => _shortBreakDuration;
  int get longBreakDuration => _longBreakDuration;
  int get longBreakInterval => _longBreakInterval;

  PomodoroPhase get currentPhase => _currentPhase;
  Duration get remainingTime => _remainingTime;
  bool get isTimerRunning => _isTimerRunning;
  int get pomodorosCompletedInCycle => _pomodorosCompletedInCycle;
  int get totalCompletedPomodoros => _totalCompletedPomodoros;
  Duration get totalPomodoroTime => _totalPomodoroTime;

  // --- API Pública para SettingsScreen (según los requisitos) ---
  /// Actualiza todas las configuraciones del Pomodoro de una sola vez.
  void updatePomodoroSettings({
    required int pomodoroDuration,
    required int shortBreakDuration,
    required int longBreakDuration,
    required int longBreakInterval,
  }) {
    _pomodoroDuration = pomodoroDuration;
    _shortBreakDuration = shortBreakDuration;
    _longBreakDuration = longBreakDuration;
    _longBreakInterval = longBreakInterval;

    // Si el temporizador no está corriendo y estamos en la fase Pomodoro,
    // actualizamos el tiempo restante para reflejar la nueva duración.
    if (!_isTimerRunning && _currentPhase == PomodoroPhase.pomodoro) {
      _remainingTime = Duration(minutes: _pomodoroDuration);
    }
    notifyListeners();
  }

  // --- Métodos de Control del Temporizador ---

  /// Inicia o reanuda el temporizador.
  void startTimer() {
    if (_isTimerRunning) return;

    _isTimerRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        _remainingTime = _remainingTime - const Duration(seconds: 1);
        notifyListeners();