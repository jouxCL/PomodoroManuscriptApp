Aquí tienes el código Dart completo y funcional para la pantalla `StatisticsScreen` de tu aplicación "PomodoroManuscriptApp", siguiendo todas tus instrucciones estrictas, incluyendo la integración con `Provider` y el uso consistente del tema.

He incluido una implementación mínima de `PomodoroManuscriptProvider` y la estructura `MaterialApp` en `main()` para que el código sea completamente ejecutable y demuestre la funcionalidad. En una aplicación real, `PomodoroManuscriptProvider` estaría en su propio archivo (`lib/providers/pomodoro_manuscript_provider.dart`) y `MaterialApp` en `lib/main.dart`.

**Nota sobre la importación de `provider`:**
El requisito "Importa solo: `package:flutter/material.dart`" entra en conflicto directo con el requisito "Integración del Provider: En `PomodoroScreen`, `SettingsScreen` y `StatisticsScreen`, utiliza `Consumer<PomodoroManuscriptProvider>` o `Provider.of<PomodoroManuscriptProvider>(context)`". Para cumplir con la integración del Provider, es indispensable importar `package:provider/provider.dart`. He priorizado la funcionalidad del Provider, asumiendo que este requisito específico anula la restricción general de importaciones en este contexto.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Necesario para la integración del Provider

// --- PomodoroManuscriptProvider Definition (as assumed for this exercise) ---
// En una aplicación real, esta clase estaría en un archivo separado,
// por ejemplo, `lib/providers/pomodoro_manuscript_provider.dart`.
// Se incluye aquí para hacer el código de StatisticsScreen completamente ejecutable.
class PomodoroManuscriptProvider extends ChangeNotifier {
  // --- Datos de Estadísticas ---
  int _completedPomodoros = 15;
  int _totalFocusTimeMinutes = 450; // Ejemplo: 15 pomodoros * 30 min
  int _totalBreakTimeMinutes = 150; // Ejemplo: (15-1) descansos cortos * 5 min + (15/4) descansos largos * 15 min
  int _pomodorosToday = 3;
  int _pomodorosThisWeek = 10;
  int _pomodorosThisMonth = 15;
  int _longestFocusSessionMinutes = 30;
  int _shortestFocusSessionMinutes = 25; // Ejemplo, podría ser diferente si el usuario detiene antes

  // Getters para las estadísticas
  int get completedPomodoros => _completedPomodoros;
  int get totalFocusTimeMinutes => _totalFocusTimeMinutes;
  int get totalBreakTimeMinutes => _totalBreakTimeMinutes;
  int get pomodorosToday => _pomodorosToday;
  int get pomodorosThisWeek => _pomodorosThisWeek;
  int get pomodorosThisMonth => _pomodorosThisMonth;
  int get longestFocusSessionMinutes => _longestFocusSessionMinutes;
  int get shortestFocusSessionMinutes => _shortestFocusSessionMinutes;

  // Estadística calculada de ejemplo
  double get averagePomodoroDurationMinutes {
    if (_completedPomodoros == 0) return 0.0;
    return _totalFocusTimeMinutes / _completedPomodoros;
  }

  // --- Otros estados de Pomodoro (mínimos para compilación, no usados directamente en StatisticsScreen) ---
  // Estos serían usados por PomodoroScreen y SettingsScreen
  int _pomodoroDuration = 25;
  int _shortBreakDuration = 5;
  int _longBreakDuration = 15;
  int _pomodorosPerLongBreak = 4;

  int get pomodoroDuration => _pomodoroDuration;
  int get shortBreakDuration => _shortBreakDuration;
  int get longBreakDuration => _longBreakDuration;
  int get pomodorosPerLongBreak => _pomodorosPerLongBreak;

  // Métodos de ejemplo para otras pantallas (SettingsScreen)
  void update