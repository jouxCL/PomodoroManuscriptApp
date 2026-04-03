import 'dart:convert';
import 'dart:async'; // Para Future
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pomodoromanuscriptapp_model.dart'; // Importa los modelos definidos

/// Clase para manejar la persistencia de datos localmente usando SharedPreferences.
class PomodoroManuscriptAppLocalDataSource {
  // Claves para SharedPreferences
  static const String _appConfigKey = 'app_config';
  static const String _overallStatsKey = 'overall_stats';

  /// Obtiene la instancia de SharedPreferences.
  /// Se hace privado para que solo esta clase lo use directamente.
  Future<SharedPreferences> _getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  /// Carga la configuración de la aplicación (AppConfig) desde el almacenamiento local.
  /// Si no hay datos o hay un error, devuelve una configuración por defecto.
  Future<AppConfig> getAppConfig() async {
    try {
      final SharedPreferences prefs = await _getSharedPreferences();
      final String? jsonString = prefs.getString(_appConfigKey);

      if (jsonString != null && jsonString.isNotEmpty) {
        final Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        return AppConfig.fromJson(jsonMap);
      }
    } catch (e) {
      // Ignora el error y devuelve la configuración por defecto.
      // En una aplicación real, se podría loggear el error.
      debugPrint('Error loading AppConfig: $e');
    }
    return const AppConfig(); // Devuelve la configuración por defecto si falla o no existe
  }

  /// Guarda la configuración de la aplicación (AppConfig) en el almacenamiento local.
  Future<void> saveAppConfig(AppConfig config) async {
    try {
      final SharedPreferences prefs = await _getSharedPreferences();
      final String jsonString = json.encode(config.toJson());
      await prefs.setString(_appConfigKey, jsonString);
    } catch (e) {
      debugPrint('Error saving AppConfig: $e');
      // Podrías lanzar una excepción o manejar el error de otra manera
      rethrow;
    }
  }

  /// Carga las estadísticas generales (OverallStats) desde el almacenamiento local.
  /// Si no hay datos o hay un error, devuelve estadísticas por defecto.
  Future<OverallStats> getOverallStats() async {
    try {
      final SharedPreferences prefs = await _getSharedPreferences();
      final String? jsonString = prefs.getString(_overallStatsKey);

      if (jsonString != null && jsonString.isNotEmpty) {
        final Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        return OverallStats.fromJson(jsonMap);
      }
    } catch (e) {
      debugPrint('Error loading OverallStats: $e');
    }
    return const OverallStats(); // Devuelve estadísticas por defecto si falla o no existe
  }

  /// Guarda las estadísticas generales (OverallStats) en el almacenamiento local.
  Future<void> saveOverallStats(OverallStats stats) async {
    try {
      final SharedPreferences prefs = await _getSharedPreferences();
      final String jsonString = json.encode(stats.toJson());
      await prefs.setString(_overallStatsKey, jsonString);
    } catch (e) {
      debugPrint('Error saving OverallStats: $e');
      rethrow;
    }
  }
}

---