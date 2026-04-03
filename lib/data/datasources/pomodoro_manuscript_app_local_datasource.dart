import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart'; // Requerido para debugPrint

// NOTA: SharedPreferences es un paquete externo.
// Para que este código funcione, necesitas añadir `shared_preferences: ^2.0.0` (o la versión más reciente)
// a las dependencias de tu archivo `pubspec.yaml`.
// Se utiliza porque es la forma estándar para el almacenamiento local de clave-valor en Flutter.
import 'package:shared_preferences/shared_preferences.dart';

import '../models/pomodoro_manuscript_app_model.dart';

/// Interfaz abstracta para la fuente de datos local de la aplicación Pomodoro.
abstract class PomodoroManuscriptAppLocalDataSource {
  /// Carga el estado completo de la aplicación desde el almacenamiento local.
  /// Retorna null si no se encuentra ningún estado guardado.
  Future<PomodoroManuscriptAppState?> loadAppState();

  /// Guarda el estado completo de la aplicación en el almacenamiento local.
  Future<void> saveAppState(PomodoroManuscriptAppState appState);
}

/// Implementación concreta de [PomodoroManuscriptAppLocalDataSource] usando SharedPreferences.
class PomodoroManuscriptAppLocalDataSourceImpl
    implements PomodoroManuscriptAppLocalDataSource {
  static const String _appStateKey = 'pomodoro_manuscript_app_state';

  @override
  Future<PomodoroManuscriptAppState?> loadAppState() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString(_appStateKey);

      if (jsonString != null) {
        final Map<String, dynamic> jsonMap =
            json.decode(jsonString) as Map<String, dynamic>;
        debugPrint(
          'PomodoroManuscriptAppLocalDataSource: Estado de la aplicación cargado.',
        );
        return PomodoroManuscriptAppState.fromJson(jsonMap);
      }
      debugPrint(
        'PomodoroManuscriptAppLocalDataSource: No se encontró estado de la aplicación en el almacenamiento local.',
      );
      return null;
    } catch (e) {
      debugPrint(
        'PomodoroManuscriptAppLocalDataSource: Error al cargar el estado de la aplicación desde el almacenamiento local: $e',
      );
      return null;
    }
  }

  @override
  Future<void> saveAppState(PomodoroManuscriptAppState appState) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String jsonString = json.encode(appState.toJson());
      await prefs.setString(_appStateKey, jsonString);
      debugPrint(
        'PomodoroManuscriptAppLocalDataSource: Estado de la aplicación guardado exitosamente.',
      );
    } catch (e) {
      debugPrint(
        'PomodoroManuscriptAppLocalDataSource: Error al guardar el estado de la aplicación en el almacenamiento local: $e',
      );
      rethrow; // Re-lanza la excepción para permitir que el repositorio la maneje o registre
    }
  }
}
