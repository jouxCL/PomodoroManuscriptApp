import 'dart:async'; // Para Future
import 'package:flutter/material.dart'; // Incluido según la regla, aunque no estrictamente necesario aquí.

// Importa el modelo de datos
import '../models/pomodoro_manuscript_app_model.dart';

/// NOTA IMPORTANTE:
/// Debido a la estricta restricción "Usa solo: package:flutter/material.dart y dart:async",
/// una solución de almacenamiento local verdaderamente persistente como SharedPreferences
/// o el acceso al sistema de archivos (dart:io) no puede ser utilizada, ya que requieren
/// paquetes o librerías adicionales no listadas explícitamente.
///
/// Esta implementación proporciona una fuente de datos local EN MEMORIA.
/// Los datos NO persistirán entre los reinicios de la aplicación.
///
/// El modelo `AppState` incluye métodos `fromJson` y `toJson`, pero estos
/// no son utilizados por esta fuente de datos en memoria debido a las restricciones
/// de paquetes que impiden el uso de `dart:convert` para serialización/deserialización.
/// En un escenario del mundo real con persistencia, estos métodos serían cruciales.
class PomodoroManuscriptAppLocalDataSource {
  // Almacenamiento en memoria para el AppState
  AppState _currentAppState = const AppState(); // Inicializa con valores por defecto

  PomodoroManuscriptAppLocalDataSource();

  /// Recupera el [AppState] actual del almacenamiento en memoria.
  Future<AppState> getAppState() async {
    // Simula un pequeño retraso para una operación asíncrona
    await Future.delayed(const Duration(milliseconds: 100));
    return _currentAppState;
  }

  /// Guarda el [AppState] dado en el almacenamiento en memoria.
  Future<void> saveAppState(AppState state) async {
    // Simula un pequeño retraso para una operación asíncrona
    await Future.delayed(const Duration(milliseconds: 100));
    _currentAppState = state;
  }
}

---