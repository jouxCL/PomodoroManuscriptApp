Aquí tienes el código Dart completo y funcional para la `StatisticsScreen`, junto con los archivos de modelo y proveedor de datos de marcador de posición (`placeholder`) que la aplicación necesitaría para compilar y funcionar, siguiendo estrictamente tus requisitos.

---

**Estructura de Archivos Sugerida:**

lib/
├── main.dart
├── models/
│   └── pomodoro_session.dart  // <-- Nuevo archivo de modelo
├── providers/
│   └── pomodoro_provider.dart // <-- Nuevo archivo de proveedor centralizado
└── screens/
    ├── welcome_screen.dart
    ├── pomodoro_screen.dart
    ├── settings_screen.dart
    └── statistics_screen.dart // <-- Este es el archivo solicitado

---

### 1. `lib/models/pomodoro_session.dart` (Archivo de Marcador de Posición)

Este archivo define el modelo de datos básico para una sesión de Pomodoro, necesario para que el proveedor y la pantalla de estadísticas compilen.

// lib/models/pomodoro_session.dart
class PomodoroSession {
  final DateTime startTime;
  final DateTime endTime;
  final int durationMinutes; // Duración del trabajo Pomodoro
  final bool completedSuccessfully;

  PomodoroSession({
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
    this.completedSuccessfully = true,
  });
}

---

### 2. `lib/providers/pomodoro_provider.dart` (Archivo de Proveedor Centralizado de Marcador de Posición)

Este archivo contiene la única y definitiva versión de `PomodoroManuscriptProvider`. Incluye lógica básica y datos de marcador de posición para que la `StatisticsScreen` pueda consumir información.

// lib/providers/pomodoro_provider.dart
import 'package:flutter/material.dart';
// Importa el modelo de sesión de Pomodoro
import 'package:pomodoro_manuscript_app/models/pomodoro_session.dart';

class PomodoroManuscriptProvider extends ChangeNotifier {
  // --- Configuración de Pomodoro ---
  int _pomodoroDuration = 25; // minutos
  int _shortBreakDuration = 5; // minutos
  int _longBreakDuration = 15; // minutos
  int _pomodorosBeforeLongBreak = 4;

  int get pomodoroDuration => _pomodoroDuration;
  int get shortBreakDuration => _shortBreakDuration;
  int get longBreakDuration => _longBreakDuration;
  int get pomodorosBeforeLongBreak => _pomodorosBeforeLongBreak;

  void setPomodoroDuration(int duration) {
    if (duration > 0) {
      _pomodoroDuration = duration;
      notifyListeners();
    }
  }

  void setShortBreakDuration(int duration) {
    if (duration > 0) {
      _shortBreakDuration = duration;
      notifyListeners();
    }
  }

  // Lógica para actualizar la duración del descanso largo, como se solicitó en la retroalimentación.
  // Esta es la implementación que SettingsScreen llamaría.
  void setLongBreakDuration(int duration) {
    if (duration > 0) {
      _longBreakDuration = duration;
      notifyListeners();
    }
  }

  void setPomodorosBeforeLongBreak(int count) {
    if (count > 0) {
      _pomodorosBeforeLongBreak = count;
      notifyListeners();
    }
  }

  // --- Estadísticas ---
  int _totalPomodoroSessions = 0;
  int _totalPomodoroTimeSeconds = 0; // Tiempo total en segundos de trabajo Pomodoro
  int _totalShortBreaks = 0;
  int _totalLongBreaks = 0;
  final List<PomodoroSession> _completedSessions = [];

  int get totalPomodoroSessions => _totalPomodoroSessions;
  int get totalPomodoroTimeMinutes => (_totalPomodoroTimeSeconds / 60).round();
  int get totalShortBreaks => _totalShortBreaks;
  int get totalLongBreaks => _totalLongBreaks;
  List<PomodoroSession> get completedSessions => List.unmodifiable(_completedSessions);

  // Constructor para inicializar con datos de prueba para la pantalla de estadísticas
  PomodoroManuscriptProvider() {
    _totalPomodoroSessions = 15;
    _totalPomodoroTimeSeconds = 15 * 25 * 60; // 15 sesiones * 25 minutos cada una
    _totalShortBreaks = 12;
    _totalLongBreaks = 3;
    _completedSessions.addAll([
      PomodoroSession(
        startTime: DateTime.now().subtract(const Duration(hours: 1)),
        endTime: DateTime.now().subtract(const Duration(minutes: 35)),
        durationMinutes: 25,
      ),
      PomodoroSession(
        startTime: DateTime.now().subtract(const Duration(hours: 2)),
        endTime: DateTime.now().subtract(const Duration(hours: 1, minutes: 35)),
        durationMinutes: 25,
      ),
      PomodoroSession(
        startTime: DateTime.now().subtract(const Duration(days: 1)),
        endTime: DateTime.now().subtract(const Duration(days: 1, minutes: 25)),
        durationMinutes: 25,
      ),
    ]);
  }

  void incrementPomodoroSessions(int durationMinutes) {
    _totalPomodoroSessions++;
    _totalPomodoroTimeSeconds += durationMinutes * 60;
    _completedSessions.add(PomodoroSession(
      startTime: DateTime.now().subtract(Duration(minutes: durationMinutes)),
      endTime: DateTime.now(),
      durationMinutes: durationMinutes,
    ));
    notifyListeners();
  }

  void incrementShortBreaks() {
    _totalShortBreaks++;
    notifyListeners();
  }

  void incrementLongBreaks() {
    _totalLongBreaks++;
    notifyListeners();
  }
}

---

### 3. `lib/screens/statistics_screen.dart` (Código Solicitado)

Este es el código completo para la pantalla `StatisticsScreen`, que consume datos del `PomodoroManuscriptProvider` y presenta una UI con la estética de manuscrito.

// lib/screens/statistics_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Necesario para Consumer
// Importa el proveedor centralizado
import 'package:pomodoro_manuscript_app/providers/pomodoro_provider.dart';
// Importa el modelo de sesión de Pomodoro (aunque el proveedor lo maneja, es bueno tenerlo accesible si se necesita directamente)
import 'package:pomodoro_manuscript_app/models/pomodoro_session.dart';


class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFFF5F5DC); // Papel de manuscrito beige
    final Color accentColor = const Color(0xFF8B4513); // Tinta marrón

    return Scaffold(
      backgroundColor: primaryColor, // Color de fondo para la pantalla
      appBar: AppBar(
        title: Text(
          'Statistics',
          style: TextStyle(
            color: accentColor,
            fontFamily: 'OldStandardTT', // Fuente personalizada para estética de manuscrito
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0, // Sin sombra para un aspecto de papel plano
        iconTheme: IconThemeData(color: accentColor), // Color del botón de retroceso
      ),
      body: Consumer<PomodoroManuscriptProvider>(
        builder: (context, pomodoroProvider, child) {
          final int totalSessions = pomodoroProvider.totalPomodoroSessions;
          final int totalWorkMinutes = pomodoroProvider.totalPomodoroTimeMinutes;
          final int totalShortBreaks = pomodoroProvider.totalShortBreaks;
          final int totalLongBreaks = pomodoroProvider.totalLongBreaks;
          final List<PomodoroSession> recentSessions = pomodoroProvider.completedSessions;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(context, 'Overall Productivity', accentColor),
                const SizedBox(height: 16),
                _buildStatisticCard(
                  context,
                  'Total Pomodoro Sessions',
                  '$totalSessions',
                  Icons.check_circle_outline,
                  accentColor,
                ),
                _buildStatisticCard(
                  context,
                  'Total Work Time',
                  '${totalWorkMinutes} minutes',
                  Icons.timer,
                  accentColor,
                ),
                _buildStatisticCard(
                  context,
                  'Total Short Breaks',
                  '$totalShortBreaks',
                  Icons.free_breakfast,
                  accentColor,
                ),
                _buildStatisticCard(
                  context,
                  'Total Long Breaks',
                  '$totalLongBreaks',
                  Icons.king_bed,
                  accentColor,
                ),
                const SizedBox(height: 32),
                _buildSectionTitle(context, 'Recent Sessions', accentColor),
                const SizedBox(height: 16),
                recentSessions.isEmpty
                    ? Text(
                        'No sessions completed yet.',
                        style: TextStyle(fontSize: 16, color: accentColor.withOpacity(0.7)),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(), // Deshabilita el scroll del ListView
                        itemCount: recentSessions.length > 5 ? 5 : recentSessions.length, // Mostrar hasta 5 sesiones recientes
                        itemBuilder: (context, index) {
                          // Mostrar las sesiones más recientes primero
                          final session = recentSessions[recentSessions.length - 1 - index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: _buildRecentSessionItem(
                              context,
                              '${session.durationMinutes} min work',
                              '${session.startTime.day}/${session.startTime.month} ${session.startTime.hour}:${session.startTime.minute.toString().padLeft(2, '0')}',
                              accentColor,
                            ),
                          );
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget auxiliar para títulos de sección
  Widget _buildSectionTitle(BuildContext context, String title, Color accentColor) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: accentColor,
        fontFamily: 'OldStandardTT', // Fuente consistente
      ),
    );
  }

  // Widget auxiliar para tarjetas de estadísticas individuales
  Widget _buildStatisticCard(
      BuildContext context, String title, String value, IconData icon, Color accentColor)