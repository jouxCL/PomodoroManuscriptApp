Aquí tienes el código Dart completo para el `ChangeNotifier` del estado de la aplicación "PomodoroManuscriptApp", utilizando exclusivamente los modelos y repositorios que proporcionaste.

Este `Provider` gestiona el estado de la aplicación, interactuando con el `PomodoroManuscriptAppRepository` para cargar, guardar y actualizar los datos, y notificando a sus oyentes (widgets de la UI) sobre cualquier cambio.

// lib/providers/pomodoro_manuscript_app_provider.dart
import 'package:flutter/material.dart'; // Para ChangeNotifier y debugPrint
import '../models/pomodoromanuscriptapp_model.dart'; // Importa el modelo de datos
import '../repositories/pomodoromanuscriptapp_repository.dart'; // Importa el repositorio

/// Provider de estado para la aplicación PomodoroManuscriptApp.
/// Gestiona la configuración, estadísticas y lógica de negocio,
/// interactuando con el repositorio para la persistencia de datos.
class PomodoroManuscriptAppProvider with ChangeNotifier {
  final PomodoroManuscriptAppRepository _repository;

  // El modelo de datos que representa el estado actual de la aplicación.
  // Se inicializa con un modelo por defecto y luego se carga desde el repositorio.
  PomodoroManuscriptAppModel _model;

  // Bandera para indicar si los datos están siendo cargados.
  bool _isLoading = false;

  /// Constructor del provider.
  /// Requiere una instancia de [PomodoroManuscriptAppRepository] para interactuar con los datos.
  PomodoroManuscriptAppProvider(this._repository)
      : _model = PomodoroManuscriptAppModel() {
    // Carga los datos iniciales al crear el provider.
    _loadInitialData();
  }

  // --- Getters para acceder al estado desde la UI ---

  /// Retorna el modelo completo de la aplicación.
  PomodoroManuscriptAppModel get model => _model;

  /// Retorna el estado de carga de los datos.
  bool get isLoading => _isLoading;

  /// Duración de un Pomodoro en minutos.
  int get pomodoroDuration => _model.pomodoroDuration;

  /// Duración de un descanso corto en minutos.
  int get shortBreakDuration => _model.shortBreakDuration;

  /// Duración de un descanso largo en minutos.
  int get longBreakDuration => _model.longBreakDuration;

  /// Número de Pomodoros antes de un descanso largo.
  int get pomodorosBeforeLongBreak => _model.pomodorosBeforeLongBreak;

  /// Nombre del usuario para el saludo personalizado.
  String get userName => _model.userName;

  /// Número total de Pomodoros completados.
  int get totalPomodorosCompleted => _model.totalPomodorosCompleted;

  /// Tiempo total de enfoque en minutos.
  int get totalTimeFocused => _model.totalTimeFocused;

  /// Pomodoros completados por día ("YYYY-MM-DD": count).
  Map<String, int> get dailyPomodorosCompleted => _model.dailyPomodorosCompleted;

  /// Tiempo de enfoque por día en minutos ("YYYY-MM-DD": minutes).
  Map<String, int> get dailyFocusTime => _model.dailyFocusTime;

  // --- Métodos para modificar el estado y persistir los cambios ---

  /// Carga los datos iniciales de la aplicación desde el repositorio.
  /// Establece el estado de carga y notifica a los oyentes.
  Future<void> _loadInitialData() async {
    _isLoading = true;
    notifyListeners(); // Notifica que la carga ha comenzado.

    try {
      _model = await _repository.getPomodoroData();
    } catch (e) {
      // En un entorno de producción, se debería usar un logger.
      debugPrint('Error al cargar datos iniciales: $e');
      // Si falla la carga, el modelo se mantiene con los valores por defecto.
    } finally {
      _isLoading = false;
      notifyListeners(); // Notifica que la carga ha finalizado y el estado está listo.
    }
  }

  /// Actualiza el nombre de usuario y guarda el cambio.
  /// [newName] El nuevo nombre de usuario.
  Future<void> updateUserName(String newName) async {
    try {
      await _repository.updateUserName(newName);
      _model.userName = newName; // Actualiza el modelo local.
      notifyListeners(); // Notifica a los oyentes sobre el cambio.
    } catch (e) {
      debugPrint('Error al actualizar el nombre de usuario: $e');
      // Podrías manejar el error de forma más sofisticada, por ejemplo,
      // mostrando un mensaje al usuario o revertiendo el cambio en la UI.
    }
  }

  /// Actualiza la configuración de los tiempos de Pomodoro y descansos, y guarda el cambio.
  /// Los parámetros nulos indican que no se debe cambiar esa configuración.
  Future<void> updatePomodoroSettings({
    int? pomodoroDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
    int? pomodorosBeforeLongBreak,
  }) async {
    try {
      await _repository.updatePomodoroSettings(
        pomodoroDuration: pomodoroDuration,
        shortBreakDuration: shortBreakDuration,
        longBreakDuration: longBreakDuration,
        pomodorosBeforeLongBreak: pomodorosBeforeLongBreak,
      );
      // Actualiza el modelo local con los nuevos valores.
      if (pomodoroDuration != null) _model.pomodoroDuration = pomodoroDuration;
      if (shortBreakDuration != null) _model.shortBreakDuration = shortBreakDuration;
      if (longBreakDuration != null) _model.longBreakDuration = longBreakDuration;
      if (pomodorosBeforeLongBreak != null) _model.pomodorosBeforeLongBreak = pomodorosBeforeLongBreak;
      notifyListeners(); // Notifica a los oyentes sobre el cambio.
    } catch (e) {
      debugPrint('Error al actualizar la configuración de Pomodoro: $e');
    }
  }

  /// Registra la finalización de un Pomodoro, actualizando las estadísticas.
  /// [durationMinutes] La duración del Pomodoro completado en minutos.
  Future<void> recordPomodoroCompletion(int durationMinutes) async {
    try {
      // El repositorio se encarga de actualizar el modelo y guardarlo.
      await _repository.recordPomodoroCompletion(durationMinutes);
      // Después de que el repositorio actualiza y guarda,
      // volvemos a cargar el modelo para asegurar que el estado local esté sincronizado
      // con los datos persistidos (incluyendo los mapas de estadísticas).
      _model = await _repository.getPomodoroData();
      notifyListeners(); // Notifica a los oyentes sobre el cambio en las estadísticas.
    } catch (e) {
      debugPrint('Error al registrar la finalización del Pomodoro: $e');
    }
  }
}