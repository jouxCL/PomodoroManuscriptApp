import 'dart:async';
import 'package:flutter/foundation.dart'; // Requerido para debugPrint

import '../datasources/pomodoro_manuscript_app_local_datasource.dart';
import '../models/pomodoro_manuscript_app_model.dart';

/// Interfaz abstracta para el repositorio de la aplicación Pomodoro.
/// Define las operaciones disponibles para acceder y gestionar el estado de la aplicación.
abstract class PomodoroManuscriptAppRepository {
  /// Obtiene el estado actual de la aplicación.
  /// Si no hay un estado guardado, retorna un estado inicial por defecto.
  Future<PomodoroManuscriptAppState> getAppState();

  /// Actualiza el estado de la aplicación en el almacenamiento.
  Future<void> updateAppState(PomodoroManuscriptAppState appState);
}

/// Implementación concreta de [PomodoroManuscriptAppRepository].
/// Coordina el acceso a los datos a través de la fuente de datos local.
class PomodoroManuscriptAppRepositoryImpl
    implements PomodoroManuscriptAppRepository {
  final PomodoroManuscriptAppLocalDataSource localDataSource;

  PomodoroManuscriptAppRepositoryImpl({required this.localDataSource});

  @override
  Future<PomodoroManuscriptAppState> getAppState() async {
    try {
      final PomodoroManuscriptAppState? appState = await localDataSource
          .loadAppState();
      if (appState != null) {
        debugPrint(
          'PomodoroManuscriptAppRepository: Estado de la aplicación recuperado de la fuente de datos local.',
        );
        return appState;
      } else {
        debugPrint(
          'PomodoroManuscriptAppRepository: No se encontró un estado existente. Retornando estado inicial.',
        );
        return PomodoroManuscriptAppState.initial();
      }
    } catch (e) {
      debugPrint(
        'PomodoroManuscriptAppRepository: Error al obtener el estado de la aplicación: $e',
      );
      // Si la carga falla, se retorna un estado inicial para evitar que la aplicación falle.
      return PomodoroManuscriptAppState.initial();
    }
  }

  @override
  Future<void> updateAppState(PomodoroManuscriptAppState appState) async {
    try {
      await localDataSource.saveAppState(appState);
      debugPrint(
        'PomodoroManuscriptAppRepository: Estado de la aplicación actualizado exitosamente.',
      );
    } catch (e) {
      debugPrint(
        'PomodoroManuscriptAppRepository: Error al actualizar el estado de la aplicación: $e',
      );
      rethrow; // Re-lanza la excepción para permitir que capas superiores la manejen
    }
  }
}
