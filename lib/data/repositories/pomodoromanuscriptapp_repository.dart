import 'dart:async'; // Para operaciones asíncronas con Future
import '../datasources/pomodoromanuscriptapp_local_datasource.dart'; // Importa la fuente de datos local
import '../models/pomodoromanuscriptapp_model.dart'; // Importa el modelo de datos

/// Interfaz abstracta para el repositorio de la aplicación PomodoroManuscriptApp.
/// Define los contratos para interactuar con los datos del modelo,
/// proporcionando una abstracción sobre la fuente de datos.
abstract class PomodoroManuscriptAppRepository {
  /// Obtiene los datos completos del modelo PomodoroManuscriptAppModel.
  /// Si no hay datos guardados, retorna un modelo con valores predeterminados.
  Future<PomodoroManuscriptAppModel> getPomodoroData();

  /// Guarda el modelo PomodoroManuscriptAppModel completo en la fuente de datos.
  Future<void> savePomodoroData(PomodoroManuscriptAppModel model);

  /// Actualiza el nombre de usuario y guarda el modelo.
  Future<void> updateUserName(String newName);

  /// Actualiza la configuración de los tiempos de Pomodoro y descansos, y guarda el modelo.
  Future<void> updatePomodoroSettings({
    int? pomodoroDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
    int? pomodorosBeforeLongBreak,
  });

  /// Registra la finalización de un Pomodoro, actualizando las estadísticas
  /// de Pomodoros completados y tiempo de enfoque.
  Future<void> recordPomodoroCompletion(int durationMinutes);
}

/// Implementación concreta de [PomodoroManuscriptAppRepository].
/// Coordina el acceso a los datos a través de la fuente de datos local.
class PomodoroManuscriptAppRepositoryImpl
    implements PomodoroManuscriptAppRepository {
  final PomodoroManuscriptAppLocalDataSource _localDataSource;

  /// Constructor que recibe una instancia de [PomodoroManuscriptAppLocalDataSource].
  /// Esto permite la inyección de dependencias y facilita las pruebas.
  PomodoroManuscriptAppRepositoryImpl(this._localDataSource);

  @override
  Future<PomodoroManuscriptAppModel> getPomodoroData() async {
    final PomodoroManuscriptAppModel? data = await _localDataSource.loadData();
    // Si no hay datos guardados, retorna un nuevo modelo con valores predeterminados.
    return data ?? PomodoroManuscriptAppModel();
  }

  @override
  Future<void> savePomodoroData(PomodoroManuscriptAppModel model) async {
    await _localDataSource.saveData(model);
  }

  @override
  Future<void> updateUserName(String newName) async {
    final PomodoroManuscriptAppModel currentData = await getPomodoroData();
    currentData.userName = newName;
    await savePomodoroData(currentData);
  }

  @override
  Future<void> updatePomodoroSettings({
    int? pomodoroDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
    int? pomodorosBeforeLongBreak,
  }) async {
    final PomodoroManuscriptAppModel currentData = await getPomodoroData();
    if (pomodoroDuration != null)
      currentData.pomodoroDuration = pomodoroDuration;
    if (shortBreakDuration != null)
      currentData.shortBreakDuration = shortBreakDuration;
    if (longBreakDuration != null)
      currentData.longBreakDuration = longBreakDuration;
    if (pomodorosBeforeLongBreak != null)
      currentData.pomodorosBeforeLongBreak = pomodorosBeforeLongBreak;
    await savePomodoroData(currentData);
  }

  @override
  Future<void> recordPomodoroCompletion(int durationMinutes) async {
    final PomodoroManuscriptAppModel currentData = await getPomodoroData();
    final String todayKey = _formatDate(DateTime.now());

    currentData.incrementDailyPomodoros(todayKey);
    currentData.addDailyFocusTime(todayKey, durationMinutes);

    await savePomodoroData(currentData);
  }

  /// Método auxiliar para formatear una fecha a una clave de cadena "YYYY-MM-DD".
  String _formatDate(DateTime date) {
    return '${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}';
  }

  /// Método auxiliar para asegurar que los números de un solo dígito tengan un cero inicial.
  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }
}
