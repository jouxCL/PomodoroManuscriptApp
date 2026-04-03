import 'dart:async';
import 'package:flutter/material.dart'; // Requerido por el usuario
import '../models/pomodoromanuscriptapp_model.dart';

/// Fuente de datos local para la aplicación PomodoroManuscriptApp.
///
/// NOTA IMPORTANTE:
/// Debido a la estricta restricción del usuario "No uses paquetes externos (solo lo que viene con Flutter)"
/// y "Usa solo: package:flutter/material.dart y dart:async",
/// esta implementación utiliza almacenamiento en memoria (in-memory storage).
/// Esto significa que los datos NO persistirán entre los reinicios de la aplicación.
/// En una aplicación real con requisitos de persistencia, se utilizarían paquetes
/// como `shared_preferences`, `hive` o `sqflite`.
class PomodoroManuscriptLocalDataSource {
  // Almacenamiento en memoria para los datos de la aplicación.
  // Los datos se perderán al cerrar la aplicación.
  PomodoroManuscriptData? _inMemoryData;

  /// Carga los datos de la aplicación. Si no hay datos en memoria,
  /// inicializa con valores predeterminados.
  Future<PomodoroManuscriptData> loadData() async {
    if (_inMemoryData == null) {
      // Proporcionar valores predeterminados para la primera carga o si no hay datos.
      _inMemoryData = PomodoroManuscriptData(
        pomodoroDuration: 25, // 25 minutos de Pomodoro
        shortBreakDuration: 5, // 5 minutos de descanso corto
        longBreakDuration: 15, // 15 minutos de descanso largo
        longBreakInterval: 3, // Descanso largo cada 3 descansos cortos
        completedPomodoros: 0,
        totalPomodoroTime: 0,
        totalBreakTime: 0,
        userName: '', // Nombre de usuario vacío por defecto
        isFirstLaunch: true, // Se asume que es el primer lanzamiento
      );
    }
    return Future.value(_inMemoryData!);
  }

  /// Guarda los datos de la aplicación en la memoria.
  ///
  /// En una implementación con persistencia real, este método serializaría
  /// `data` a JSON y lo guardaría usando `SharedPreferences` o similar.
  Future<void> saveData(PomodoroManuscriptData data) async {
    _inMemoryData = data;
    return Future.value();
  }
}
