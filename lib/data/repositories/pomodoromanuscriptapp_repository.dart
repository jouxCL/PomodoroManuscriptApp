import 'dart:async'; // Para Future
import '../models/pomodoromanuscriptapp_model.dart'; // Importa los modelos
import '../datasources/pomodoromanuscriptapp_local_datasource.dart'; // Importa la fuente de datos

/// Interfaz abstracta para el repositorio de la aplicación Pomodoro Manuscript.
/// Define los contratos para interactuar con los datos de la aplicación.
abstract class PomodoroManuscriptAppRepository {
  Future<AppConfig> getAppConfig();
  Future<void> saveAppConfig(AppConfig config);
  Future<OverallStats> getOverallStats();
  Future<void> updateOverallStats(OverallStats stats);
  Future<void> addPomodoroStatistic(PomodoroStatistic statistic);
}

/// Implementación concreta del repositorio que usa la fuente de datos local.
class PomodoroManuscriptAppRepositoryImpl
    implements PomodoroManuscriptAppRepository {
  final PomodoroManuscriptAppLocalDataSource localDataSource;

  PomodoroManuscriptAppRepositoryImpl({required this.localDataSource});

  @override
  Future<AppConfig> getAppConfig() async {
    try {
      return await localDataSource.getAppConfig();
    } catch (e) {
      // Aquí puedes manejar errores específicos, loggearlos, o relanzar
      // una excepción de dominio si es necesario.
      debugPrint('Repository Error getting AppConfig: $e');
      return const AppConfig(); // Devuelve un valor por defecto en caso de error
    }
  }

  @override
  Future<void> saveAppConfig(AppConfig config) async {
    try {
      await localDataSource.saveAppConfig(config);
    } catch (e) {
      debugPrint('Repository Error saving AppConfig: $e');
      rethrow; // Relanza el error para que la capa superior lo maneje
    }
  }

  @override
  Future<OverallStats> getOverallStats() async {
    try {
      return await localDataSource.getOverallStats();
    } catch (e) {
      debugPrint('Repository Error getting OverallStats: $e');
      return const OverallStats(); // Devuelve un valor por defecto en caso de error
    }
  }

  @override
  Future<void> updateOverallStats(OverallStats stats) async {
    try {
      await localDataSource.saveOverallStats(stats);
    } catch (e) {
      debugPrint('Repository Error updating OverallStats: $e');
      rethrow;
    }
  }

  @override
  Future<void> addPomodoroStatistic(PomodoroStatistic statistic) async {
    try {
      // 1. Cargar las estadísticas actuales
      OverallStats currentStats = await localDataSource.getOverallStats();

      // 2. Crear una nueva lista de estadísticas de sesión inmutable
      final List<PomodoroStatistic> updatedSessionStats = List.from(
        currentStats.sessionStatistics,
      )..add(statistic);

      // 3. Actualizar las estadísticas generales
      final OverallStats newStats = currentStats.copyWith(
        totalPomodorosCompleted:
            currentStats.totalPomodorosCompleted + statistic.pomodorosCompleted,
        totalWorkTimeMinutes:
            currentStats.totalWorkTimeMinutes + statistic.workTimeMinutes,
        totalBreakTimeMinutes:
            currentStats.totalBreakTimeMinutes + statistic.breakTimeMinutes,
        sessionStatistics: updatedSessionStats,
      );

      // 4. Guardar las estadísticas actualizadas
      await localDataSource.saveOverallStats(newStats);
    } catch (e) {
      debugPrint('Repository Error adding PomodoroStatistic: $e');
      rethrow;
    }
  }
}
