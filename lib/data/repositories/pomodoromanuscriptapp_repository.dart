import 'dart:async';
import 'package:flutter/material.dart'; // Requerido por el usuario
import '../models/pomodoromanuscriptapp_model.dart';
import '../datasources/pomodoromanuscriptapp_local_datasource.dart';

/// Repositorio para la aplicación PomodoroManuscriptApp.
///
/// Actúa como una capa de abstracción entre la capa de dominio (use cases)
/// y las fuentes de datos (local, remota, etc.).
/// Es responsable de coordinar los datos de una o varias fuentes de datos.
class PomodoroManuscriptRepository {
  final PomodoroManuscriptLocalDataSource localDataSource;

  PomodoroManuscriptRepository({required this.localDataSource});

  /// Obtiene todos los datos de la aplicación (configuración, estadísticas, usuario).
  Future<PomodoroManuscriptData> getPomodoroData() async {
    return await localDataSource.loadData();
  }

  /// Guarda todos los datos de la aplicación.
  Future<void> savePomodoroData(PomodoroManuscriptData data) async {
    await localDataSource.saveData(data);
  }

  /// Actualiza la configuración del temporizador Pomodoro.
  Future<void> updatePomodoroSettings({
    int? pomodoroDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
    int? longBreakInterval,
  }) async {
    PomodoroManuscriptData currentData = await getPomodoroData();
    PomodoroManuscriptData updatedData = currentData.copyWith(
      pomodoroDuration: pomodoroDuration,
      shortBreakDuration: shortBreakDuration,
      longBreakDuration: longBreakDuration,
      longBreakInterval: longBreakInterval,
    );
    await savePomodoroData(updatedData);
  }

  /// Actualiza las estadísticas de productividad.
  Future<void> updateStatistics({
    int? completedPomodoros,
    int? totalPomodoroTime,
    int? totalBreakTime,
  }) async {
    PomodoroManuscriptData currentData = await getPomodoroData();
    PomodoroManuscriptData updatedData = currentData.copyWith(
      completedPomodoros: completedPomodoros,
      totalPomodoroTime: totalPomodoroTime,
      totalBreakTime: totalBreakTime,
    );
    await savePomodoroData(updatedData);
  }

  /// Establece el nombre del usuario.
  Future<void> setUserName(String name) async {
    PomodoroManuscriptData currentData = await getPomodoroData();
    PomodoroManuscriptData updatedData = currentData.copyWith(userName: name);
    await savePomodoroData(updatedData);
  }

  /// Marca que el proceso de primer lanzamiento (ej. pedir nombre) ha sido completado.
  Future<void> markFirstLaunchComplete() async {
    PomodoroManuscriptData currentData = await getPomodoroData();
    PomodoroManuscriptData updatedData = currentData.copyWith(
      isFirstLaunch: false,
    );
    await savePomodoroData(updatedData);
  }
}
