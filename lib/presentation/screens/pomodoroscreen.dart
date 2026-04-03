Aquí tienes el código Dart completo y funcional para la `PomodoroScreen` de tu aplicación "PomodoroManuscriptApp", siguiendo todos los requisitos especificados.

He incluido un `main` function y `MaterialApp` con `ColorScheme.fromSeed` para que puedas ejecutar y probar la pantalla directamente. También he añadido pantallas placeholder (`SettingsScreen`, `StatisticsScreen`) para la navegación.

**Características clave implementadas:**

*   **Estética de Manuscrito:**
    *   `backgroundColor: Color(0xFFF5F5DC)` (beige) para el fondo del `Scaffold`.
    *   `ColorScheme` configurado con `primary: Color(0xFFF5F5DC)` y `secondary: Color(0xFF8B4513)`.
    *   `TextTheme` personalizado para usar una fuente `serif` genérica, simulando "Times New Roman". Se incluye una nota sobre cómo añadir la fuente real si la tienes.
    *   Sombras sutiles y bordes redondeados para elementos como el temporizador, dando una sensación de papel superpuesto.
*   **Temporizador Pomodoro Funcional:**
    *   `StatefulWidget` para manejar el estado del temporizador.
    *   Botones "Iniciar", "Pausar" y "Reiniciar".
    *   Muestra el tiempo restante en formato `MM:SS`.
    *   Cambio automático entre fases (Pomodoro, Descanso Corto, Descanso Largo).
    *   Un descanso largo cada 4 Pomodoros (después de 3 descansos cortos).
    *   Diálogos informativos al completar cada fase.
*   **Saludo Personalizado:**
    *   Muestra un saludo dinámico (`Buenos días/tardes/noches`) con el nombre del usuario. El nombre se pasa como parámetro o usa un valor por defecto.
*   **Monitoreo de Estadísticas:**
    *   Contador de "Pomodoros Completados" en la sesión actual.
*   **Navegación:**
    *   `AppBar` con iconos para navegar a `SettingsScreen` y `StatisticsScreen` usando rutas nombradas.

import 'dart:async'; // Necesario para la clase Timer
import 'package:flutter/material.dart';

// Enum para representar las diferentes fases del ciclo Pomodoro
enum PomodoroPhase {
  pomodoro,
  shortBreak,
  longBreak,
}

class PomodoroScreen extends StatefulWidget {
  // El nombre de usuario se pasaría desde WelcomeScreen o se cargaría de SharedPreferences
  final String userName;

  const PomodoroScreen({Key? key, this.userName = 'Usuario'}) : super(key: key);

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  // --- Tiempos Configurables (Valores por defecto, idealmente vendrían de SettingsScreen) ---
  // En minutos
  int _pomodoroTime = 25;
  int _shortBreakTime = 5;
  int _longBreakTime = 15;
  int _pomodorosBeforeLongBreak = 4; // Descanso largo después de 3 descansos cortos (4 pomodoros)

  // --- Estado del Temporizador ---
  late int _currentRemainingTime; // En segundos
  Timer? _timer;
  bool _isRunning = false;
  bool _isPaused = false;

  // --- Estado del Ciclo Pomodoro ---
  PomodoroPhase _currentPhase = PomodoroPhase.pomodoro;
  int _completedPomodoros = 0; // Pomodoros completados en esta sesión (para estadísticas)
  int _currentCyclePomodoros = 0; // Pomodoros completados en el ciclo actual (antes de un descanso largo)

  // --- Saludo al Usuario ---
  String _greeting = 'Cargando...';

  @override
  void initState() {
    super.initState();
    _setInitialTimerDuration();
    _loadUserNameAndGreeting();
  }

  // Establece la duración inicial del temporizador según la fase actual
  void _setInitialTimerDuration() {
    switch (_currentPhase) {
      case PomodoroPhase.pomodoro:
        _currentRemainingTime = _pomodoroTime * 60;
        break;
      case PomodoroPhase.shortBreak:
        _currentRemainingTime = _shortBreakTime * 60;
        break;
      case PomodoroPhase.longBreak:
        _currentRemainingTime = _longBreakTime * 60;
        break;
    }
  }

  // Carga el nombre de usuario y genera el saludo
  void _loadUserNameAndGreeting() {
    // En una aplicación real, el nombre de usuario se cargaría de SharedPreferences.
    // Para este ejemplo, usamos el nombre pasado o un valor por defecto.
    setState(() {
      final hour = DateTime.now().hour;
      String timeOfDay;
      if (hour < 12) {
        timeOfDay = 'Buenos días';
      } else if (hour < 18) {
        timeOfDay = 'Buenas tardes';
      } else {
        timeOfDay = 'Buenas noches';
      }
      _greeting = '$timeOfDay ${widget.userName}, bienvenido a tu sesión de Pomodoro.';
    });
  }

  // Inicia el temporizador
  void _startTimer() {
    if (_isRunning && !_isPaused) return; // Ya está corriendo
    if (_isPaused) {
      _resumeTimer(); // Si está pausado, lo reanuda
      return;
    }

    setState(() {
      _isRunning = true;
      _isPaused = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentRemainingTime > 0) {
        setState(() {
          _currentRemainingTime--;
        });
      } else {
        _timer?.cancel();
        _nextPhase(); // Pasa a la siguiente fase cuando el tiempo se agota
      }
    });
  }

  // Pausa el temporizador
  void _pauseTimer() {
    if (_isRunning && !_isPaused) {
      _timer?.cancel();
      setState(() {
        _isPaused = true;
        _isRunning = false;
      });
    }
  }

  // Reanuda el temporizador desde el estado de pausa
  void _resumeTimer() {
    setState(() {
      _isPaused = false;
      _isRunning = true;
    });
    _startTimer(); // Simplemente llama a startTimer de nuevo, continuará desde el tiempo restante actual
  }

  // Reinicia el temporizador y las estadísticas de la sesión
  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _currentPhase = PomodoroPhase.pomodoro; // Reinicia a la fase Pomodoro
      _setInitialTimerDuration(); // Restablece el tiempo para Pomodoro
      _completedPomodoros = 0; // Reinicia las estadísticas de la sesión
      _currentCyclePomodoros = 0; // Reinicia las estadísticas del ciclo
    });
  }

  // Lógica para pasar a la siguiente fase del ciclo Pomodoro
  void _nextPhase() {
    setState(() {
      if (_currentPhase == PomodoroPhase.pomodoro) {
        _completedPomodoros++; // Incrementa los Pomodoros completados
        _currentCyclePomodoros++; // Incrementa los Pomodoros en el ciclo actual
        if (_currentCyclePomodoros % _pomodorosBeforeLongBreak == 0) {
          _currentPhase = PomodoroPhase.longBreak;
        } else {
          _currentPhase = PomodoroPhase.shortBreak;
        }
      } else {
        // Después de cualquier descanso, siempre se vuelve a Pomodoro
        _currentPhase = PomodoroPhase.pomodoro;
      }
      _setInitialTimerDuration(); // Establece la duración para la nueva fase
      _isRunning = false; // Detiene el temporizador después del cambio de fase
      _isPaused = false;
    });

    // Muestra un diálogo informativo al completar una fase
    _showPhaseCompletionDialog();
  }

  // Muestra un diálogo al completar una fase (Pomodoro o Descanso)
  void _showPhaseCompletionDialog() {
    String title;
    String content;
    if (_currentPhase == PomodoroPhase.pomodoro) {
      title = '¡Descanso Terminado!';
      content = 'Es hora de volver a concentrarse. Inicia tu próximo Pomodoro.';
    } else if (_currentPhase == PomodoroPhase.shortBreak) {
      title = '¡Pomodoro Completado!';
      content = 'Tómate un breve descanso. Inicia tu descanso corto.';
    } else { // Long Break
      title = '¡Pomodoro Completado!';
      content = 'Has completado $_currentCyclePomodoros Pomodoros. ¡Disfruta de tu merecido descanso largo!';
    }

    showDialog(
      context: context,
      barrierDismissible: false, // El usuario debe presionar OK
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface, // Fondo del diálogo
          title: Text(title, style: Theme.of(context).textTheme.titleLarge),
          content: Text(content, style: Theme.of(context).textTheme.bodyMedium),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Theme.of(context).colorScheme.primaryContainer)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Formatea el tiempo de segundos a MM: