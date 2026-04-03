import 'dart:async'; // Para operaciones asíncronas con Future
import 'dart:convert'; // Para jsonEncode/jsonDecode
import 'package:shared_preferences/shared_preferences.dart'; // Para almacenamiento local persistente
import '../models/pomodoromanuscriptapp_model.dart'; // Importa el modelo de datos

/// Interfaz abstracta para la fuente de datos local de la aplicación PomodoroManuscriptApp.
/// Define los contratos para cargar y guardar los datos del modelo.
abstract class PomodoroManuscriptAppLocalDataSource {
  /// Carga los datos del modelo PomodoroManuscriptAppModel desde el almacenamiento local.
  /// Retorna null si no hay datos guardados o si ocurre un error.
  Future<PomodoroManuscriptAppModel?> loadData();

  /// Guarda los datos del modelo PomodoroManuscriptAppModel en el almacenamiento local.
  Future<void> saveData(PomodoroManuscriptAppModel model);
}

/// Clave utilizada para almacenar los datos del modelo en SharedPreferences.
const String _kPomodoroDataKey = 'pomodoroManuscriptAppData';

/// Implementación concreta de [PomodoroManuscriptAppLocalDataSource] utilizando SharedPreferences.
class PomodoroManuscriptAppLocalDataSourceImpl
    implements PomodoroManuscriptAppLocalDataSource {
  final SharedPreferences _preferences;

  /// Constructor que recibe una instancia de [SharedPreferences].
  /// Esto permite la inyección de dependencias y facilita las pruebas.
  PomodoroManuscriptAppLocalDataSourceImpl(this._preferences);

  @override
  Future<PomodoroManuscriptAppModel?> loadData() async {
    try {
      final String? jsonString = _preferences.getString(_kPomodoroDataKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        return PomodoroManuscriptAppModel.fromJson(jsonMap);
      }
    } catch (e) {
      // En un entorno de producción, se debería usar un logger.
      // print('Error al cargar datos desde SharedPreferences: $e');
      // Retornar null para indicar que no se pudieron cargar datos válidos.
    }
    return null; // No se encontraron datos o hubo un error.
  }

  @override
  Future<void> saveData(PomodoroManuscriptAppModel model) async {
    try {
      final Map<String, dynamic> jsonMap = model.toJson();
      final String jsonString = jsonEncode(jsonMap);
      await _preferences.setString(_kPomodoroDataKey, jsonString);
    } catch (e) {
      // En un entorno de producción, se debería usar un logger.
      // print('Error al guardar datos en SharedPreferences: $e');
      rethrow; // Re-lanza la excepción para que sea manejada por capas superiores.
    }
  }
}
