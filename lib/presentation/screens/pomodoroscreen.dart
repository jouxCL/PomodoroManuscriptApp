Aquí tienes el código completo y funcional para la pantalla `PomodoroScreen`, siguiendo todas las especificaciones y atendiendo la retroalimentación proporcionada.

Este archivo (`pomodoro_screen.dart`) está diseñado para ser añadido a tu proyecto Flutter. No incluye `main.dart` ni `welcomescreen.dart`, ya que la solicitud es solo para `PomodoroScreen` y las notas sobre `main.dart` y `welcomescreen.dart` son para correcciones en esos archivos, no para su generación aquí.

// pomodoro_screen.dart
import 'package:flutter/material.dart';
import 'dart:async'; // Necesario para Timer

// Enum para representar las diferentes fases del Pomodoro
enum PomodoroPhase {
  focus,
  shortBreak,
  longBreak,
}

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  Timer? _timer;
  int _secondsRemaining = 0;
  bool _isRunning = false;
  PomodoroPhase _currentPhase = PomodoroPhase.focus;
  int _pomodorosCompleted = 0; // Pomodoros completados en el ciclo actual (antes del descanso largo)
  int _totalPomodorosCompleted = 0; // Total de pomodoros completados en la sesión

  // Tiempos configurables (en segundos)
  final int _focusTime = 25 * 60; // 25 minutos
  final int _shortBreakTime = 5 * 60; // 5 minutos
  final int _longBreakTime = 15 * 60; // 15 minutos
  final int _pomodorosBeforeLongBreak = 4; // Cada 4 pomodoros, un descanso largo

  @override
  void initState() {
    super.initState();
    _secondsRemaining = _focusTime; // Iniciar con el tiempo de enfoque
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Inicia o reanuda el temporizador
  void _startTimer() {
    if (_isRunning) return; // Evitar iniciar múltiples temporizadores

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
        _handlePhaseCompletion();
      }
    });
  }

  // Pausa el temporizador
  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  // Reinicia el temporizador a su estado inicial
  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _currentPhase = PomodoroPhase.focus;
      _secondsRemaining = _focusTime;
      _pomodorosCompleted = 0;
      _totalPomodorosCompleted = 0;
    });
  }

  // Maneja la finalización de una fase (enfoque o descanso)
  void _handlePhaseCompletion() {
    if (_currentPhase == PomodoroPhase.focus) {
      _totalPomodorosCompleted++;
      _pomodorosCompleted++;
      if (_pomodorosCompleted % _pomodorosBeforeLongBreak == 0) {
        _currentPhase = PomodoroPhase.longBreak;
        _secondsRemaining = _longBreakTime;
      } else {
        _currentPhase = PomodoroPhase.shortBreak;
        _secondsRemaining = _shortBreakTime;
      }
    } else {
      // Después de un descanso, siempre volvemos al enfoque
      _currentPhase = PomodoroPhase.focus;
      _secondsRemaining = _focusTime;
    }
    _startTimer(); // Iniciar automáticamente la siguiente fase
  }

  // Formatea los segundos restantes a un string MM:SS
  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  // Obtiene el nombre de la fase actual para mostrar en la UI
  String _getPhaseName(PomodoroPhase phase) {
    switch (phase) {
      case PomodoroPhase.focus:
        return 'Enfoque';
      case PomodoroPhase.shortBreak:
        return 'Descanso Corto';
      case PomodoroPhase.longBreak:
        return 'Descanso Largo';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Definir los colores principales de la app
    final Color primaryColor = Color(0xFFF5F5DC); // Beige
    final Color accentColor = Color(0xFF8B4513); // Marrón

    // Estilo de texto para simular Times New Roman y el color de manuscrito
    final TextStyle manuscriptTextStyle = TextStyle(
      fontFamily: 'serif', // Usa una fuente serif genérica para simular Times New Roman
      color: accentColor,
      fontSize: 20,
      height: 1.5, // Espaciado de línea para legibilidad
    );

    return Scaffold(
      backgroundColor: primaryColor, // Fondo beige para toda la pantalla
      appBar: AppBar(
        title: Text(
          'Temporizador Pomodoro',
          style: manuscriptTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        elevation: 0, // Sin sombra para un aspecto más plano
        iconTheme: IconThemeData(color: accentColor), // Iconos de la AppBar en color marrón
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Indicador de la fase actual
              Text(
                _getPhaseName(_currentPhase),
                style: manuscriptTextStyle.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              // Temporizador principal
              Text(
                _formatTime(_secondsRemaining),
                style: manuscriptTextStyle.copyWith(fontSize: 96, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              // Botones de control
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isRunning ? _pauseTimer : _startTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor, // Fondo marrón para los botones
                      foregroundColor: primaryColor, // Texto beige en los botones
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      _isRunning ? 'Pausar' : 'Iniciar',
                      style: manuscriptTextStyle.copyWith(color: primaryColor, fontSize: 22),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _resetTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Reiniciar',
                      style: manuscriptTextStyle.copyWith(color: primaryColor, fontSize: 22),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Contador de Pomodoros completados
              Text(
                'Pomodoros completados: $_totalPomodorosCompleted',
                style: manuscriptTextStyle.copyWith(fontSize: 28),
              ),
              Text(
                'Ciclo actual: $_pomodorosCompleted / $_pomodorosBeforeLongBreak',
                style: manuscriptTextStyle.copyWith(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}