import 'dart:async'; // Para Future
import 'package:flutter/material.dart'; // Incluido según la regla, aunque no estrictamente necesario aquí.

// Importa los modelos y las fuentes de datos
import '../models/pomodoro_manuscript_app_model.dart';
import '../datasources/pomodoro_manuscript_app_local_datasource.dart';

/// Repositorio para gestionar el estado y los datos de la aplicación.
/// Abstrae las fuentes de datos y proporciona una API limpia para la capa de dominio.
class PomodoroManuscriptAppRepository {
  final PomodoroManuscriptAppLocalDataSource localDataSource;

  /// Constructor que requiere una instancia de [PomodoroManuscriptAppLocalDataSource].
  PomodoroManuscriptAppRepository({required this.localDataSource});

  /// Recupera el estado actual de la aplicación.
  /// Delega la operación a la fuente de datos local.
  Future<AppState> getAppState() async {
    try {
      return await localDataSource.getAppState();
    } catch (e) {
      // En una aplicación real, se podría registrar el error o devolver un estado por defecto.
      debugPrint(
        'Error al obtener el estado de la aplicación desde la fuente de datos local: $e',
      );
      return const AppState(); // Devuelve un estado por defecto en caso de error
    }
  }

  /// Guarda el estado de la aplicación proporcionado.
  /// Delega la operación a la fuente de datos local.
  Future<void> saveAppState(AppState state) async {
    try {
      await localDataSource.saveAppState(state);
    } catch (e) {
      debugPrint(
        'Error al guardar el estado de la aplicación en la fuente de datos local: $e',
      );
      // Maneja el error, por ejemplo, relanzándolo o registrándolo.
      rethrow;
    }
  }
}
