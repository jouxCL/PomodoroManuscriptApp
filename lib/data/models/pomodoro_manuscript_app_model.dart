// No se requiere 'package:flutter/material.dart' para los modelos de datos.
// No se requiere 'dart:async' para los modelos de datos.

/// Enumera las posibles fases del temporizador Pomodoro.
enum TimerPhase { pomodoro, shortBreak, longBreak, stopped, paused }

/// Representa la configuración configurable del temporizador Pomodoro.
class PomodoroSettings {
  final int pomodoroDurationMinutes;
  final int shortBreakDurationMinutes;
  final int longBreakDurationMinutes;
  final int cyclesBeforeLongBreak;

  PomodoroSettings({
    this.pomodoroDurationMinutes = 25,
    this.shortBreakDurationMinutes = 5,
    this.longBreakDurationMinutes = 15,
    this.cyclesBeforeLongBreak = 4,
  });

  /// Crea una instancia de [PomodoroSettings] a partir de un mapa JSON.
  factory PomodoroSettings.fromJson(Map<String, dynamic> json) {
    return PomodoroSettings(
      pomodoroDurationMinutes: json['pomodoroDurationMinutes'] as int,
      shortBreakDurationMinutes: json['shortBreakDurationMinutes'] as int,
      longBreakDurationMinutes: json['longBreakDurationMinutes'] as int,
      cyclesBeforeLongBreak: json['cyclesBeforeLongBreak'] as int,
    );
  }

  /// Convierte la instancia de [PomodoroSettings] en un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'pomodoroDurationMinutes': pomodoroDurationMinutes,
      'shortBreakDurationMinutes': shortBreakDurationMinutes,
      'longBreakDurationMinutes': longBreakDurationMinutes,
      'cyclesBeforeLongBreak': cyclesBeforeLongBreak,
    };
  }

  /// Crea una copia de esta instancia de [PomodoroSettings] con valores opcionales actualizados.
  PomodoroSettings copyWith({
    int? pomodoroDurationMinutes,
    int? shortBreakDurationMinutes,
    int? longBreakDurationMinutes,
    int? cyclesBeforeLongBreak,
  }) {
    return PomodoroSettings(
      pomodoroDurationMinutes:
          pomodoroDurationMinutes ?? this.pomodoroDurationMinutes,
      shortBreakDurationMinutes:
          shortBreakDurationMinutes ?? this.shortBreakDurationMinutes,
      longBreakDurationMinutes:
          longBreakDurationMinutes ?? this.longBreakDurationMinutes,
      cyclesBeforeLongBreak:
          cyclesBeforeLongBreak ?? this.cyclesBeforeLongBreak,
    );
  }
}

/// Representa las estadísticas de productividad del usuario.
class ProductivityStats {
  final int totalPomodorosCompleted;
  final int totalFocusTimeSeconds;
  final int totalBreakTimeSeconds;

  ProductivityStats({
    this.totalPomodorosCompleted = 0,
    this.totalFocusTimeSeconds = 0,
    this.totalBreakTimeSeconds = 0,
  });

  /// Crea una instancia de [ProductivityStats] a partir de un mapa JSON.
  factory ProductivityStats.fromJson(Map<String, dynamic> json) {
    return ProductivityStats(
      totalPomodorosCompleted: json['totalPomodorosCompleted'] as int,
      totalFocusTimeSeconds: json['totalFocusTimeSeconds'] as int,
      totalBreakTimeSeconds: json['totalBreakTimeSeconds'] as int,
    );
  }

  /// Convierte la instancia de [ProductivityStats] en un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'totalPomodorosCompleted': totalPomodorosCompleted,
      'totalFocusTimeSeconds': totalFocusTimeSeconds,
      'totalBreakTimeSeconds': totalBreakTimeSeconds,
    };
  }

  /// Crea una copia de esta instancia de [ProductivityStats] con valores opcionales actualizados.
  ProductivityStats copyWith({
    int? totalPomodorosCompleted,
    int? totalFocusTimeSeconds,
    int? totalBreakTimeSeconds,
  }) {
    return ProductivityStats(
      totalPomodorosCompleted:
          totalPomodorosCompleted ?? this.totalPomodorosCompleted,
      totalFocusTimeSeconds:
          totalFocusTimeSeconds ?? this.totalFocusTimeSeconds,
      totalBreakTimeSeconds:
          totalBreakTimeSeconds ?? this.totalBreakTimeSeconds,
    );
  }
}

/// Representa el estado global de la aplicación Pomodoro Manuscript.
/// Este modelo encapsula toda la información necesaria para la aplicación.
class AppState {
  final String userName;
  final PomodoroSettings settings;
  final ProductivityStats stats;
  final TimerPhase currentTimerPhase;
  final int
  currentPomodoroCycle; // Número de pomodoros completados en el ciclo actual (antes del descanso largo)

  AppState({
    this.userName = 'Usuario',
    PomodoroSettings? settings,
    ProductivityStats? stats,
    this.currentTimerPhase = TimerPhase.stopped,
    this.currentPomodoroCycle = 0,
  }) : settings = settings ?? PomodoroSettings(),
       stats = stats ?? ProductivityStats();

  /// Crea una instancia de [AppState] a partir de un mapa JSON.
  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      userName: json['userName'] as String,
      settings: PomodoroSettings.fromJson(
        json['settings'] as Map<String, dynamic>,
      ),
      stats: ProductivityStats.fromJson(json['stats'] as Map<String, dynamic>),
      currentTimerPhase: TimerPhase.values.firstWhere(
        (e) => e.toString() == 'TimerPhase.${json['currentTimerPhase']}',
        orElse: () => TimerPhase.stopped,
      ),
      currentPomodoroCycle: json['currentPomodoroCycle'] as int,
    );
  }

  /// Convierte la instancia de [AppState] en un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'settings': settings.toJson(),
      'stats': stats.toJson(),
      'currentTimerPhase': currentTimerPhase.toString().split('.').last,
      'currentPomodoroCycle': currentPomodoroCycle,
    };
  }

  /// Crea una copia de esta instancia de [AppState] con valores opcionales actualizados.
  AppState copyWith({
    String? userName,
    PomodoroSettings? settings,
    ProductivityStats? stats,
    TimerPhase? currentTimerPhase,
    int? currentPomodoroCycle,
  }) {
    return AppState(
      userName: userName ?? this.userName,
      settings: settings ?? this.settings,
      stats: stats ?? this.stats,
      currentTimerPhase: currentTimerPhase ?? this.currentTimerPhase,
      currentPomodoroCycle: currentPomodoroCycle ?? this.currentPomodoroCycle,
    );
  }
}
