// No se requiere 'package:flutter/material.dart' para los repositorios.
import 'dart:async'; // Necesario para Future

import '../models/pomodoro_manuscript_app_model.dart';
import '../datasources/pomodoro_manuscript_app_local_datasource.dart';

/// Interfaz abstracta para el repositorio de la aplicación Pomodoro Manuscript.
/// Define las operaciones de alto nivel para gestionar el estado de la aplicación.
abstract class PomodoroManuscriptAppRepository {
  /// Recupera el estado actual completo de la aplicación.
  Future<AppState> getAppState();

  /// Actualiza el nombre de usuario.
  Future<void> updateUserName(String userName);

  /// Actualiza la configuración del temporizador Pomodoro.
  Future<void> updatePomodoroSettings(PomodoroSettings settings);

  /// Actualiza las estadísticas de productividad.
  Future<void> updateProductivityStats(ProductivityStats stats);

  /// Actualiza la fase actual del temporizador (Pomodoro, descanso corto, etc.).
  Future<void> updateTimerPhase(TimerPhase phase);

  /// Actualiza el contador del ciclo Pomodoro actual.
  Future<void> updateCurrentPomodoroCycle(int cycle);

  /// Restablece el estado de la aplicación a sus valores por defecto.
  Future<void> resetAppState();
}

/// Implementación concreta de [PomodoroManuscriptAppRepository] que utiliza una fuente de datos local.
class PomodoroManuscriptAppRepositoryImpl
    implements PomodoroManuscriptAppRepository {
  final PomodoroManuscriptAppLocalDataSource localDataSource;

  PomodoroManuscriptAppRepositoryImpl({required this.localDataSource});

  @override
  Future<AppState> getAppState() async {
    return await localDataSource.getAppState();
  }

  @override
  Future<void> updateUserName(String userName) async {
    final currentAppState = await localDataSource.getAppState();
    final updatedAppState = currentAppState.copyWith(userName: userName);
    await localDataSource.saveAppState(updatedAppState);
  }

  @override
  Future<void> updatePomodoroSettings(PomodoroSettings settings) async {
    final currentAppState = await localDataSource.getAppState();
    final updatedAppState = currentAppState.copyWith(settings: settings);
    await localDataSource.saveAppState(updatedAppState);
  }

  @override
  Future<void> updateProductivityStats(ProductivityStats stats) async {
    final currentAppState = await localDataSource.getAppState();
    final updatedAppState = currentAppState.copyWith(stats: stats);
    await localDataSource.saveAppState(updatedAppState);
  }

  @override
  Future<void> updateTimerPhase(TimerPhase phase) async {
    final currentAppState = await localDataSource.getAppState();
    final updatedAppState = currentAppState.copyWith(currentTimerPhase: phase);
    await localDataSource.saveAppState(updatedAppState);
  }

  @override
  Future<void> updateCurrentPomodoroCycle(int cycle) async {
    final currentAppState = await localDataSource.getAppState();
    final updatedAppState = currentAppState.copyWith(
      currentPomodoroCycle: cycle,
    );
    await localDataSource.saveAppState(updatedAppState);
  }

  @override
  Future<void> resetAppState() async {
    // Guarda un nuevo estado de aplicación con valores por defecto
    await localDataSource.saveAppState(AppState());
  }
}
