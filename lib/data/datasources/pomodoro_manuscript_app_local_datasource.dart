// No se requiere 'package:flutter/material.dart' para los datasources.
import 'dart:async'; // Necesario para Future

import '../models/pomodoro_manuscript_app_model.dart';

/// Interfaz abstracta para la fuente de datos local de la aplicación Pomodoro Manuscript.
/// Define los métodos para interactuar con el estado de la aplicación.
abstract class PomodoroManuscriptAppLocalDataSource {
  /// Recupera el estado actual de la aplicación.
  Future<AppState> getAppState();

  /// Guarda el estado de la aplicación.
  Future<void> saveAppState(AppState state);
}

/// Implementación en memoria de [PomodoroManuscriptAppLocalDataSource].
/// Almacena el estado de la aplicación en una variable local, sin persistencia real.
class PomodoroManuscriptAppLocalDataSourceImpl
    implements PomodoroManuscriptAppLocalDataSource {
  // Almacenamiento en memoria
  AppState _appState = AppState(); // Inicializa con valores por defecto

  @override
  Future<AppState> getAppState() async {
    // Simula un pequeño retraso para una operación asíncrona
    await Future.delayed(const Duration(milliseconds: 50));
    return _appState;
  }

  @override
  Future<void> saveAppState(AppState state) async {
    // Simula un pequeño retraso para una operación asíncrona
    await Future.delayed(const Duration(milliseconds: 50));
    _appState = state;
  }
}
