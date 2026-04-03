import 'package:flutter/material.dart'; // Para la anotación @immutable

/// Representa el estado completo de la aplicación, incluyendo configuraciones,
/// perfil de usuario y estadísticas de productividad.
@immutable
class AppState {
  final int pomodoroDuration; // Duración de un Pomodoro en minutos
  final int shortBreakDuration; // Duración de un descanso corto en minutos
  final int longBreakDuration; // Duración de un descanso largo en minutos
  final int cyclesBeforeLongBreak; // Número de ciclos de Pomodoro antes de un descanso largo
  final String userName; // Nombre del usuario para el saludo personalizado
  final int totalPomodorosCompleted; // Total de Pomodoros completados
  final int totalFocusTimeSeconds; // Tiempo total de enfoque en segundos
  final int totalBreaksTaken; // Total de descansos tomados
  final DateTime? lastSessionDate; // Fecha de la última sesión (puede ser nula)

  /// Constructor constante para la inmutabilidad.
  /// Proporciona valores por defecto para todos los campos.
  const AppState({
    this.pomodoroDuration = 25,
    this.shortBreakDuration = 5,
    this.longBreakDuration = 15,
    this.cyclesBeforeLongBreak = 4,
    this.userName = 'Usuario',
    this.totalPomodorosCompleted = 0,
    this.totalFocusTimeSeconds = 0,
    this.totalBreaksTaken = 0,
    this.lastSessionDate,
  });

  /// Crea una nueva instancia de [AppState] a partir de un mapa JSON.
  /// Utiliza el operador de coalescencia nula (??) para proporcionar valores
  /// por defecto seguros si una clave no existe en el JSON.
  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      pomodoroDuration: json['pomodoroDuration'] as int? ?? 25,
      shortBreakDuration: json['shortBreakDuration'] as int? ?? 5,
      longBreakDuration: json['longBreakDuration'] as int? ?? 15,
      cyclesBeforeLongBreak: json['cyclesBeforeLongBreak'] as int? ?? 4,
      userName: json['userName'] as String? ?? 'Usuario',
      totalPomodorosCompleted: json['totalPomodorosCompleted'] as int? ?? 0,
      totalFocusTimeSeconds: json['totalFocusTimeSeconds'] as int? ?? 0,
      totalBreaksTaken: json['totalBreaksTaken'] as int? ?? 0,
      lastSessionDate: json['lastSessionDate'] != null
          ? DateTime.tryParse(json['lastSessionDate'] as String)
          : null,
    );
  }

  /// Convierte la instancia actual de [AppState] a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'pomodoroDuration': pomodoroDuration,
      'shortBreakDuration': shortBreakDuration,
      'longBreakDuration': longBreakDuration,
      'cyclesBeforeLongBreak': cyclesBeforeLongBreak,
      'userName': userName,
      'totalPomodorosCompleted': totalPomodorosCompleted,
      'totalFocusTimeSeconds': totalFocusTimeSeconds,
      'totalBreaksTaken': totalBreaksTaken,
      'lastSessionDate': lastSessionDate?.toIso8601String(),
    };
  }

  /// Crea una copia de esta instancia de [AppState] con los valores modificados.
  AppState copyWith({
    int? pomodoroDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
    int? cyclesBeforeLongBreak,
    String? userName,
    int? totalPomodorosCompleted,
    int? totalFocusTimeSeconds,
    int? totalBreaksTaken,
    DateTime? lastSessionDate,
  }) {
    return AppState(
      pomodoroDuration: pomodoroDuration ?? this.pomodoroDuration,
      shortBreakDuration: shortBreakDuration ?? this.shortBreakDuration,
      longBreakDuration: longBreakDuration ?? this.longBreakDuration,
      cyclesBeforeLongBreak: cyclesBeforeLongBreak ?? this.cyclesBeforeLongBreak,
      userName: userName ?? this.userName,
      totalPomodorosCompleted: totalPomodorosCompleted ?? this.totalPomodorosCompleted,
      totalFocusTimeSeconds: totalFocusTimeSeconds ?? this.totalFocusTimeSeconds,
      totalBreaksTaken: totalBreaksTaken ?? this.totalBreaksTaken,
      lastSessionDate: lastSessionDate ?? this.lastSessionDate,
    );
  }

  /// Implementación manual de `operator ==` para comparar instancias de [AppState].
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.pomodoroDuration == pomodoroDuration &&
        other.shortBreakDuration == shortBreakDuration &&
        other.longBreakDuration == longBreakDuration &&
        other.cyclesBeforeLongBreak == cyclesBeforeLongBreak &&
        other.userName == userName &&
        other.totalPomodorosCompleted == totalPomodorosCompleted &&
        other.totalFocusTimeSeconds == totalFocusTimeSeconds &&
        other.totalBreaksTaken == totalBreaksTaken &&
        other.lastSessionDate == lastSessionDate;
  }

  /// Implementación manual de `hashCode` para instancias de [AppState].
  @override
  int get hashCode {
    return pomodoroDuration.hashCode ^
        shortBreakDuration.hashCode ^
        longBreakDuration.hashCode ^
        cyclesBeforeLongBreak.hashCode ^
        userName.hashCode ^
        totalPomodorosCompleted.hashCode ^
        totalFocusTimeSeconds.hashCode ^
        totalBreaksTaken.hashCode ^
        lastSessionDate.hashCode;
  }
}

---