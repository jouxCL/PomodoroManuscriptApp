import 'dart:convert'; // Para jsonEncode/jsonDecode

/// Representa la configuración de los tiempos del Pomodoro.
class PomodoroSettings {
  final int workDurationMinutes;
  final int shortBreakDurationMinutes;
  final int longBreakDurationMinutes;
  final int pomodoroCyclesBeforeLongBreak;

  PomodoroSettings({
    this.workDurationMinutes = 25,
    this.shortBreakDurationMinutes = 5,
    this.longBreakDurationMinutes = 15,
    this.pomodoroCyclesBeforeLongBreak = 4,
  });

  /// Crea una instancia de [PomodoroSettings] a partir de un mapa JSON.
  factory PomodoroSettings.fromJson(Map<String, dynamic> json) {
    return PomodoroSettings(
      workDurationMinutes: json['workDurationMinutes'] as int,
      shortBreakDurationMinutes: json['shortBreakDurationMinutes'] as int,
      longBreakDurationMinutes: json['longBreakDurationMinutes'] as int,
      pomodoroCyclesBeforeLongBreak:
          json['pomodoroCyclesBeforeLongBreak'] as int,
    );
  }

  /// Convierte la instancia de [PomodoroSettings] a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'workDurationMinutes': workDurationMinutes,
      'shortBreakDurationMinutes': shortBreakDurationMinutes,
      'longBreakDurationMinutes': longBreakDurationMinutes,
      'pomodoroCyclesBeforeLongBreak': pomodoroCyclesBeforeLongBreak,
    };
  }

  /// Crea una nueva instancia de [PomodoroSettings] con valores opcionales actualizados.
  PomodoroSettings copyWith({
    int? workDurationMinutes,
    int? shortBreakDurationMinutes,
    int? longBreakDurationMinutes,
    int? pomodoroCyclesBeforeLongBreak,
  }) {
    return PomodoroSettings(
      workDurationMinutes: workDurationMinutes ?? this.workDurationMinutes,
      shortBreakDurationMinutes:
          shortBreakDurationMinutes ?? this.shortBreakDurationMinutes,
      longBreakDurationMinutes:
          longBreakDurationMinutes ?? this.longBreakDurationMinutes,
      pomodoroCyclesBeforeLongBreak:
          pomodoroCyclesBeforeLongBreak ?? this.pomodoroCyclesBeforeLongBreak,
    );
  }
}

/// Representa las estadísticas de productividad del usuario.
class ProductivityStats {
  final int completedPomodoros;
  final int totalWorkTimeSeconds; // Tiempo total acumulado en fases de trabajo
  final int
  totalBreakTimeSeconds; // Tiempo total acumulado en fases de descanso

  ProductivityStats({
    this.completedPomodoros = 0,
    this.totalWorkTimeSeconds = 0,
    this.totalBreakTimeSeconds = 0,
  });

  /// Crea una instancia de [ProductivityStats] a partir de un mapa JSON.
  factory ProductivityStats.fromJson(Map<String, dynamic> json) {
    return ProductivityStats(
      completedPomodoros: json['completedPomodoros'] as int,
      totalWorkTimeSeconds: json['totalWorkTimeSeconds'] as int,
      totalBreakTimeSeconds: json['totalBreakTimeSeconds'] as int,
    );
  }

  /// Convierte la instancia de [ProductivityStats] a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'completedPomodoros': completedPomodoros,
      'totalWorkTimeSeconds': totalWorkTimeSeconds,
      'totalBreakTimeSeconds': totalBreakTimeSeconds,
    };
  }

  /// Crea una nueva instancia de [ProductivityStats] con valores opcionales actualizados.
  ProductivityStats copyWith({
    int? completedPomodoros,
    int? totalWorkTimeSeconds,
    int? totalBreakTimeSeconds,
  }) {
    return ProductivityStats(
      completedPomodoros: completedPomodoros ?? this.completedPomodoros,
      totalWorkTimeSeconds: totalWorkTimeSeconds ?? this.totalWorkTimeSeconds,
      totalBreakTimeSeconds:
          totalBreakTimeSeconds ?? this.totalBreakTimeSeconds,
    );
  }
}

/// Representa las preferencias del usuario, como su nombre.
class UserPreferences {
  final String userName;

  UserPreferences({
    this.userName = 'Usuario', // Nombre de usuario por defecto
  });

  /// Crea una instancia de [UserPreferences] a partir de un mapa JSON.
  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(userName: json['userName'] as String);
  }

  /// Convierte la instancia de [UserPreferences] a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {'userName': userName};
  }

  /// Crea una nueva instancia de [UserPreferences] con valores opcionales actualizados.
  UserPreferences copyWith({String? userName}) {
    return UserPreferences(userName: userName ?? this.userName);
  }
}

/// Modelo de datos principal que encapsula todo el estado de la aplicación Pomodoro.
class PomodoroManuscriptAppState {
  final PomodoroSettings settings;
  final ProductivityStats stats;
  final UserPreferences preferences;

  PomodoroManuscriptAppState({
    required this.settings,
    required this.stats,
    required this.preferences,
  });

  /// Crea un estado inicial por defecto para la aplicación.
  factory PomodoroManuscriptAppState.initial() {
    return PomodoroManuscriptAppState(
      settings: PomodoroSettings(),
      stats: ProductivityStats(),
      preferences: UserPreferences(),
    );
  }

  /// Crea una instancia de [PomodoroManuscriptAppState] a partir de un mapa JSON.
  factory PomodoroManuscriptAppState.fromJson(Map<String, dynamic> json) {
    return PomodoroManuscriptAppState(
      settings: PomodoroSettings.fromJson(
        json['settings'] as Map<String, dynamic>,
      ),
      stats: ProductivityStats.fromJson(json['stats'] as Map<String, dynamic>),
      preferences: UserPreferences.fromJson(
        json['preferences'] as Map<String, dynamic>,
      ),
    );
  }

  /// Convierte la instancia de [PomodoroManuscriptAppState] a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'settings': settings.toJson(),
      'stats': stats.toJson(),
      'preferences': preferences.toJson(),
    };
  }

  /// Crea una nueva instancia de [PomodoroManuscriptAppState] con valores opcionales actualizados.
  PomodoroManuscriptAppState copyWith({
    PomodoroSettings? settings,
    ProductivityStats? stats,
    UserPreferences? preferences,
  }) {
    return PomodoroManuscriptAppState(
      settings: settings ?? this.settings,
      stats: stats ?? this.stats,
      preferences: preferences ?? this.preferences,
    );
  }
}
