import 'package:flutter/material.dart'; // Requerido por el usuario, aunque no estrictamente necesario para este modelo.
import 'dart:async'; // Requerido por el usuario, aunque no estrictamente necesario para este modelo.

/// Modelo de datos principal para la aplicación PomodoroManuscriptApp.
/// Contiene la configuración del temporizador, estadísticas de productividad
/// e información del usuario.
class PomodoroManuscriptData {
  // --- Configuración del Temporizador ---
  /// Duración de una sesión de Pomodoro en minutos.
  final int pomodoroDuration;

  /// Duración de un descanso corto en minutos.
  final int shortBreakDuration;

  /// Duración de un descanso largo en minutos.
  final int longBreakDuration;

  /// Número de descansos cortos antes de un descanso largo.
  final int longBreakInterval;

  // --- Estadísticas de Productividad ---
  /// Número total de Pomodoros completados.
  final int completedPomodoros;

  /// Tiempo total acumulado en sesiones de Pomodoro en minutos.
  final int totalPomodoroTime;

  /// Tiempo total acumulado en descansos (cortos y largos) en minutos.
  final int totalBreakTime;

  // --- Información del Usuario ---
  /// Nombre del usuario para saludos personalizados.
  final String userName;

  /// Indica si es la primera vez que el usuario inicia la aplicación.
  /// Se usa para preguntar el nombre del usuario y mostrar el saludo inicial.
  final bool isFirstLaunch;

  PomodoroManuscriptData({
    required this.pomodoroDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.longBreakInterval,
    required this.completedPomodoros,
    required this.totalPomodoroTime,
    required this.totalBreakTime,
    required this.userName,
    required this.isFirstLaunch,
  });

  /// Crea una nueva instancia de `PomodoroManuscriptData` a partir de un mapa JSON.
  factory PomodoroManuscriptData.fromJson(Map<String, dynamic> json) {
    return PomodoroManuscriptData(
      pomodoroDuration: json['pomodoroDuration'] as int,
      shortBreakDuration: json['shortBreakDuration'] as int,
      longBreakDuration: json['longBreakDuration'] as int,
      longBreakInterval: json['longBreakInterval'] as int,
      completedPomodoros: json['completedPomodoros'] as int,
      totalPomodoroTime: json['totalPomodoroTime'] as int,
      totalBreakTime: json['totalBreakTime'] as int,
      userName: json['userName'] as String,
      isFirstLaunch: json['isFirstLaunch'] as bool,
    );
  }

  /// Convierte la instancia actual de `PomodoroManuscriptData` a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'pomodoroDuration': pomodoroDuration,
      'shortBreakDuration': shortBreakDuration,
      'longBreakDuration': longBreakDuration,
      'longBreakInterval': longBreakInterval,
      'completedPomodoros': completedPomodoros,
      'totalPomodoroTime': totalPomodoroTime,
      'totalBreakTime': totalBreakTime,
      'userName': userName,
      'isFirstLaunch': isFirstLaunch,
    };
  }

  /// Crea una copia de esta instancia de `PomodoroManuscriptData` con los valores
  /// proporcionados, manteniendo los valores originales si no se especifican.
  PomodoroManuscriptData copyWith({
    int? pomodoroDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
    int? longBreakInterval,
    int? completedPomodoros,
    int? totalPomodoroTime,
    int? totalBreakTime,
    String? userName,
    bool? isFirstLaunch,
  }) {
    return PomodoroManuscriptData(
      pomodoroDuration: pomodoroDuration ?? this.pomodoroDuration,
      shortBreakDuration: shortBreakDuration ?? this.shortBreakDuration,
      longBreakDuration: longBreakDuration ?? this.longBreakDuration,
      longBreakInterval: longBreakInterval ?? this.longBreakInterval,
      completedPomodoros: completedPomodoros ?? this.completedPomodoros,
      totalPomodoroTime: totalPomodoroTime ?? this.totalPomodoroTime,
      totalBreakTime: totalBreakTime ?? this.totalBreakTime,
      userName: userName ?? this.userName,
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
    );
  }
}
