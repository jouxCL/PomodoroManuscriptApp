import 'package:flutter/material.dart'; // Solo para el tipo DateTime, aunque no es estrictamente necesario aquí.
import 'dart:convert'; // Para codificación/decodificación JSON

/// Clase para la configuración de los tiempos del Pomodoro.
@immutable
class PomodoroSettings {
  final int workDurationMinutes; // Duración del Pomodoro en minutos
  final int shortBreakDurationMinutes; // Duración del descanso corto en minutos
  final int longBreakDurationMinutes; // Duración del descanso largo en minutos
  final int longBreakInterval; // Cada cuántos Pomodoros hay un descanso largo

  const PomodoroSettings({
    this.workDurationMinutes = 25,
    this.shortBreakDurationMinutes = 5,
    this.longBreakDurationMinutes = 15,
    this.longBreakInterval = 4,
  });

  /// Crea una nueva instancia de PomodoroSettings con valores modificados.
  PomodoroSettings copyWith({
    int? workDurationMinutes,
    int? shortBreakDurationMinutes,
    int? longBreakDurationMinutes,
    int? longBreakInterval,
  }) {
    return PomodoroSettings(
      workDurationMinutes: workDurationMinutes ?? this.workDurationMinutes,
      shortBreakDurationMinutes: shortBreakDurationMinutes ?? this.shortBreakDurationMinutes,
            longBreakDurationMinutes: longBreakDurationMinutes ?? this.longBreakDurationMinutes,
      longBreakInterval: longBreakInterval ?? this.longBreakInterval,
    );
  }

  /// Convierte una instancia de PomodoroSettings a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'workDurationMinutes': workDurationMinutes,
      'shortBreakDurationMinutes': shortBreakDurationMinutes,
      'longBreakDurationMinutes': longBreakDurationMinutes,
      'longBreakInterval': longBreakInterval,
    };
  }

  /// Crea una instancia de PomodoroSettings desde un mapa JSON.
  factory PomodoroSettings.fromJson(Map<String, dynamic> json) {
    return PomodoroSettings(
      workDurationMinutes: json['workDurationMinutes'] as int? ?? 25,
      shortBreakDurationMinutes: json['shortBreakDurationMinutes'] as int? ?? 5,
      longBreakDurationMinutes: json['longBreakDurationMinutes'] as int? ?? 15,
      longBreakInterval: json['longBreakInterval'] as int? ?? 4,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PomodoroSettings &&
          runtimeType == other.runtimeType &&
          workDurationMinutes == other.workDurationMinutes &&
          shortBreakDurationMinutes == other.shortBreakDurationMinutes &&
          longBreakDurationMinutes == other.longBreakDurationMinutes &&
          longBreakInterval == other.longBreakInterval;

  @override
  int get hashCode =>
      workDurationMinutes.hashCode ^
      shortBreakDurationMinutes.hashCode ^
      longBreakDurationMinutes.hashCode ^
      longBreakInterval.hashCode;
}

/// Clase para el perfil de usuario.
@immutable
class UserProfile {
  final String userName;
  final String customGreeting;

  const UserProfile({
    this.userName = 'Usuario',
    this.customGreeting = '¡Bienvenido de nuevo!',
  });

  /// Crea una nueva instancia de UserProfile con valores modificados.
  UserProfile copyWith({
    String? userName,
    String? customGreeting,
  }) {
    return UserProfile(
      userName: userName ?? this.userName,
      customGreeting: customGreeting ?? this.customGreeting,
    );
  }

  /// Convierte una instancia de UserProfile a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'customGreeting': customGreeting,
    };
  }

  /// Crea una instancia de UserProfile desde un mapa JSON.
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userName: json['userName'] as String? ?? 'Usuario',
      customGreeting: json['customGreeting'] as String? ?? '¡Bienvenido de nuevo!',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          userName == other.userName &&
          customGreeting == other.customGreeting;

  @override
  int get hashCode => userName.hashCode ^ customGreeting.hashCode;
}

/// Clase que encapsula la configuración general de la aplicación.
@immutable
class AppConfig {
  final PomodoroSettings settings;
  final UserProfile userProfile;

  const AppConfig({
    this.settings = const PomodoroSettings(),
    this.userProfile = const UserProfile(),
  });

  /// Crea una nueva instancia de AppConfig con valores modificados.
  AppConfig copyWith({
    PomodoroSettings? settings,
    UserProfile? userProfile,
  }) {
    return AppConfig(
      settings: settings ?? this.settings,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  /// Convierte una instancia de AppConfig a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'settings': settings.toJson(),
      'userProfile': userProfile.toJson(),
    };
  }

  /// Crea una instancia de AppConfig desde un mapa JSON.
  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      settings: json['settings'] != null
          ? PomodoroSettings.fromJson(json['settings'] as Map<String, dynamic>)
          : const PomodoroSettings(),
      userProfile: json['userProfile'] != null
          ? UserProfile.fromJson(json['userProfile'] as Map<String, dynamic>)
          : const UserProfile(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppConfig &&
          runtimeType == other.runtimeType &&
          settings == other.settings &&
          userProfile == other.userProfile;

  @override
  int get hashCode => settings.hashCode ^ userProfile.hashCode;
}

/// Clase para registrar una sesión de estadísticas de Pomodoro.
@immutable
class PomodoroStatistic {
  final String id; // Identificador único para la estadística
  final DateTime date; // Fecha y hora de la sesión
  final int pomodorosCompleted; // Número de pomodoros completados en esta sesión
  final int workTimeMinutes; // Tiempo total de trabajo en minutos en esta sesión
  final int breakTimeMinutes; // Tiempo total de descanso en minutos en esta sesión

  PomodoroStatistic({
    required this.id,
    required this.date,
    this.pomodorosCompleted = 0,
    this.workTimeMinutes = 0,
    this.breakTimeMinutes = 0,
  });

  /// Convierte una instancia de PomodoroStatistic a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(), // Serializa DateTime a String ISO 8601
      'pomodorosCompleted': pomodorosCompleted,
      'workTimeMinutes': workTimeMinutes,
      'breakTimeMinutes': breakTimeMinutes,
    };
  }

  /// Crea una instancia de PomodoroStatistic desde un mapa JSON.
  factory PomodoroStatistic.fromJson(Map<String, dynamic> json) {
    return PomodoroStatistic(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String), // Deserializa String ISO 8601 a DateTime
      pomodorosCompleted: json['pomodorosCompleted'] as int? ?? 0,
      workTimeMinutes: json['workTimeMinutes'] as int? ?? 0,
      breakTimeMinutes: json['breakTimeMinutes'] as int? ?? 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PomodoroStatistic &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          date == other.date &&
          pomodorosCompleted == other.pomodorosCompleted &&
          workTimeMinutes == other.workTimeMinutes &&
          breakTimeMinutes == other.breakTimeMinutes;

  @override
  int get hashCode =>
      id.hashCode ^
      date.hashCode ^
      pomodorosCompleted.hashCode ^
      workTimeMinutes.hashCode ^
      breakTimeMinutes.hashCode;
}

/// Clase para las estadísticas generales de la aplicación.
@immutable
class OverallStats {
  final int totalPomodorosCompleted;
  final int totalWorkTimeMinutes;
  final int totalBreakTimeMinutes;
  final List<PomodoroStatistic> sessionStatistics; // Historial de sesiones

  const OverallStats({
    this.totalPomodorosCompleted = 0,
    this.totalWorkTimeMinutes = 0,
    this.totalBreakTimeMinutes = 0,
    this.sessionStatistics = const [],
  });

  /// Crea una nueva instancia de OverallStats con valores modificados.
  OverallStats copyWith({
    int? totalPomodorosCompleted,
    int? totalWorkTimeMinutes,
    int? totalBreakTimeMinutes,
    List<PomodoroStatistic>? sessionStatistics,
  }) {
    return OverallStats(
      totalPomodorosCompleted: totalPomodorosCompleted ?? this.totalPomodorosCompleted,
      totalWorkTimeMinutes: totalWorkTimeMinutes ?? this.totalWorkTimeMinutes,
      totalBreakTimeMinutes: totalBreakTimeMinutes ?? this.totalBreakTimeMinutes,
      sessionStatistics: sessionStatistics ?? this.sessionStatistics,
    );
  }

  /// Convierte una instancia de OverallStats a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'totalPomodorosCompleted': totalPomodorosCompleted,
      'totalWorkTimeMinutes': totalWorkTimeMinutes,
      'totalBreakTimeMinutes': totalBreakTimeMinutes,
      'sessionStatistics': sessionStatistics.map((s) => s.toJson()).toList(),
    };
  }

  /// Crea una instancia de OverallStats desde un mapa JSON.
  factory OverallStats.fromJson(Map<String, dynamic> json) {
    return OverallStats(
      totalPomodorosCompleted: json['totalPomodorosCompleted'] as int? ?? 0,
      totalWorkTimeMinutes: json['totalWorkTimeMinutes'] as int? ?? 0,
      totalBreakTimeMinutes: json['totalBreakTimeMinutes'] as int? ?? 0,
      sessionStatistics: (json['sessionStatistics'] as List<dynamic>?)
              ?.map((e) => PomodoroStatistic.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OverallStats &&
          runtimeType == other.runtimeType &&
          totalPomodorosCompleted == other.totalPomodorosCompleted &&
          totalWorkTimeMinutes == other.totalWorkTimeMinutes &&
          totalBreakTimeMinutes == other.totalBreakTimeMinutes &&
          listEquals(sessionStatistics, other.sessionStatistics); // Usa listEquals para comparar listas

  @override
  int get hashCode =>
      totalPomodorosCompleted.hashCode ^
      totalWorkTimeMinutes.hashCode ^
      totalBreakTimeMinutes.hashCode ^
      sessionStatistics.hashCode;
}

// Helper para comparar listas, ya que List no tiene un operador == profundo por defecto.
// Esto es una implementación simple, para casos más complejos se podría usar un paquete como collection.
bool listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null) return b == null;
  if (b == null || a.length != b.length) return false;
  if (identical(a, b)) return true;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) {
      return false;
    }
  }
  return true;
}

---