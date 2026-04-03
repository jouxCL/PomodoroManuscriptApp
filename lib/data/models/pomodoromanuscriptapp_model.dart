import 'dart:convert'; // Para codificación/decodificación JSON
import 'package:flutter/material.dart'; // Incluido según la instrucción, aunque no se usa directamente en el modelo de datos.

/// Modelo de datos principal para la aplicación PomodoroManuscriptApp.
/// Contiene la configuración del usuario y las estadísticas de productividad.
class PomodoroManuscriptAppModel {
  // --- Configuración del usuario ---
  int pomodoroDuration; // Duración de un Pomodoro en minutos (ej. 25)
  int shortBreakDuration; // Duración de un descanso corto en minutos (ej. 5)
  int longBreakDuration; // Duración de un descanso largo en minutos (ej. 15)
  int pomodorosBeforeLongBreak; // Número de Pomodoros antes de un descanso largo (ej. 4)
  String userName; // Nombre del usuario para el saludo personalizado

  // --- Estadísticas de productividad ---
  int totalPomodorosCompleted; // Número total de Pomodoros completados
  int totalTimeFocused; // Tiempo total de enfoque en minutos
  Map<String, int>
      dailyPomodorosCompleted; // Pomodoros completados por día ("YYYY-MM-DD": count)
  Map<String, int>
      dailyFocusTime; // Tiempo de enfoque por día en minutos ("YYYY-MM-DD": minutes)

  /// Constructor para el modelo de datos.
  /// Proporciona valores predeterminados si no se especifican.
  PomodoroManuscriptAppModel({
    this.pomodoroDuration = 25,
    this.shortBreakDuration = 5,
    this.longBreakDuration = 15,
    this.pomodorosBeforeLongBreak = 4,
    this.userName = 'Usuario',
    this.totalPomodorosCompleted = 0,
    this.totalTimeFocused = 0,
    Map<String, int>? dailyPomodorosCompleted,
    Map<String, int>? dailyFocusTime,
  })  : dailyPomodorosCompleted = dailyPomodorosCompleted ?? {},
        dailyFocusTime = dailyFocusTime ?? {};

  /// Crea una instancia de [PomodoroManuscriptAppModel] a partir de un mapa JSON.
  /// Se encarga de la deserialización de los datos, incluyendo los mapas de estadísticas.
  factory PomodoroManuscriptAppModel.fromJson(Map<String, dynamic> json) {
    return PomodoroManuscriptAppModel(
      pomodoroDuration: json['pomodoroDuration'] as int? ?? 25,
      shortBreakDuration: json['shortBreakDuration'] as int? ?? 5,
      longBreakDuration: json['longBreakDuration'] as int? ?? 15,
      pomodorosBeforeLongBreak: json['pomodorosBeforeLongBreak'] as int? ?? 4,
      userName: json['userName'] as String? ?? 'Usuario',
      totalPomodorosCompleted: json['totalPomodorosCompleted'] as int? ?? 0,
      totalTimeFocused: json['totalTimeFocused'] as int? ?? 0,
      dailyPomodorosCompleted: (json['dailyPomodorosCompleted'] != null)
          ? Map<String, int>.from(
              jsonDecode(
                json['dailyPomodorosCompleted'] as String,
              ).map<String, int>((k, v) => MapEntry(k, v as int)),
            )
          : {},
      dailyFocusTime: (json['dailyFocusTime'] != null)
          ? Map<String, int>.from(
              jsonDecode(
                json['dailyFocusTime'] as String,
              ).map<String, int>((k, v) => MapEntry(k, v as int)),
            )
          : {},
    );
  }

  /// Convierte la instancia de [PomodoroManuscriptAppModel] a un mapa JSON.
  /// Se encarga de la serialización de los datos, incluyendo los mapas de estadísticas a cadenas JSON.
  Map<String, dynamic> toJson() {
    return {
      'pomodoroDuration': pomodoroDuration,
      'shortBreakDuration': shortBreakDuration,
      'longBreakDuration': longBreakDuration,
      'pomodorosBeforeLongBreak': pomodorosBeforeLongBreak,
      'userName': userName,
      'totalPomodorosCompleted': totalPomodorosCompleted,
      'totalTimeFocused': totalTimeFocused,
      'dailyPomodorosCompleted': jsonEncode(dailyPomodorosCompleted),
      'dailyFocusTime': jsonEncode(dailyFocusTime),
    };
  }

  /// Incrementa el contador de Pomodoros completados para un día específico
  /// y actualiza el total general.
  void incrementDailyPomodoros(String dateKey) {
    dailyPomodorosCompleted[dateKey] =
        (dailyPomodorosCompleted[dateKey] ?? 0) + 1;
    totalPomodorosCompleted++;
  }

  /// Añade tiempo de enfoque a un día específico y actualiza el total general.
  void addDailyFocusTime(String dateKey, int minutes) {
    dailyFocusTime[dateKey] = (dailyFocusTime[dateKey] ?? 0) + minutes;
    totalTimeFocused += minutes;
  }

  @override
  String toString() {
    return 'PomodoroManuscriptAppModel(\n'
        '  pomodoroDuration: $pomodoroDuration,\n'
        '  shortBreakDuration: $shortBreakDuration,\n'
        '  longBreakDuration: $longBreakDuration,\n'
        '  pomodorosBeforeLongBreak: $pomodorosBeforeLongBreak,\n'
        '  userName: $userName,\n'
        '  totalPomodorosCompleted: $totalPomodorosCompleted,\n'
        '  totalTimeFocused: $totalTimeFocused,\n'
        '  dailyPomodorosCompleted: $dailyPomodorosCompleted,\n'
        '  dailyFocusTime: $dailyFocusTime\n'
        ')';
  }
}
