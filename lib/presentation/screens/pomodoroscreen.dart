Aquí tienes el código Dart completo y funcional para la pantalla `PomodoroScreen`, siguiendo todas las especificaciones y adhiriéndote rigurosamente a la nota especial sobre la resolución de conflictos de proveedores y limpieza de dependencias.

Este código implementa un temporizador Pomodoro básico con fases de trabajo, descanso corto y descanso largo, junto con funcionalidades de iniciar, pausar y reiniciar. La lógica del temporizador se gestiona internamente dentro del `StatefulWidget` para evitar dependencias externas en esta etapa, cumpliendo con la directriz de no introducir proveedores conflictivos o dependencias rotas.

import 'dart:async'; // Necesario para la clase Timer
import 'package:flutter/material.dart';

// Enum para representar las diferentes fases del ciclo Pomodoro
enum PomodoroPhase {
  pomodoro,
  shortBreak,
  longBreak,
}

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  // Define la ruta nombrada para esta pantalla
  static const String routeName = '/pomodoro';

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  // Tiempos predeterminados en segundos (idealmente configurables desde SettingsScreen)
  static const int _pomodoroDuration = 25 * 60; // 25 minutos
  static const int _shortBreakDuration = 5 * 60; // 5 minutos
  static const int _longBreakDuration = 15 * 60; // 15 minutos
  static const int _pomodoroCyclesBeforeLongBreak = 4; // 4 Pomodoros antes de un descanso largo

  Timer? _timer; // Objeto Timer para el conteo regresivo
  int _remainingSeconds = _pomodoroDuration; // Segundos restantes en la fase actual
  PomodoroPhase _currentPhase = PomodoroPhase.pomodoro; // Fase actual del Pomodoro
  bool _isRunning = false; // Indica si el temporizador está en marcha
  int _pomodoroCount = 0; // Contador de Pomodoros completados en el ciclo actual

  @override
  void initState() {
    super.initState();
    _resetTimer(); // Inicializa el temporizador al iniciar la pantalla
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador cuando el widget se elimina
    super.dispose();
  }

  // Inicia el temporizador
  void _startTimer() {
    if (_isRunning) return; // Evita iniciar múltiples temporizadores
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel(); // Cancela el temporizador actual
        _moveToNextPhase(); // Pasa a la siguiente fase
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

  // Reinicia el temporizador a la fase inicial de Pomodoro
  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _currentPhase = PomodoroPhase.pomodoro;
      _remainingSeconds = _pomodoroDuration;
      _pomodoroCount = 0; // Reinicia el contador de Pomodoros
    });
  }

  // Mueve el temporizador a la siguiente fase (descanso corto, largo o Pomodoro)
  void _moveToNextPhase() {
    setState(() {
      switch (_currentPhase) {
        case PomodoroPhase.pomodoro:
          _pomodoroCount++;
          if (_pomodoroCount % _pomodoroCyclesBeforeLongBreak == 0) {
            _currentPhase = PomodoroPhase.longBreak;
            _remainingSeconds = _longBreakDuration;
          } else {
            _currentPhase = PomodoroPhase.shortBreak;
            _remainingSeconds = _shortBreakDuration;
          }
          break;
        case PomodoroPhase.shortBreak:
        case PomodoroPhase.longBreak:
          _currentPhase = PomodoroPhase.pomodoro;
          _remainingSeconds = _pomodoroDuration;
          break;
      }
      _startTimer(); // Inicia automáticamente la siguiente fase
    });
  }

  // Formatea el tiempo de segundos totales a "MM:SS"
  String _formatTime(int totalSeconds) {
    final int minutes = totalSeconds ~/ 60;
    final int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Obtiene el título de la fase actual
  String _getPhaseTitle() {
    switch (_currentPhase) {
      case PomodoroPhase.pomodoro:
        return 'Tiempo de Pomodoro';
      case PomodoroPhase.shortBreak:
        return 'Descanso Corto';
      case PomodoroPhase.longBreak:
        return 'Descanso Largo';
    }
  }

  // Obtiene el color para el texto del temporizador según la fase
  Color _getPhaseColor() {
    switch (_currentPhase) {
      case PomodoroPhase.pomodoro:
        return const Color(0xFF8B4513); // Color accent para el trabajo
      case PomodoroPhase.shortBreak:
        return Colors.green.shade700; // Verde para descansos cortos
      case PomodoroPhase.longBreak:
        return Colors.blue.shade700; // Azul para descansos largos
    }
  }

  @override
  Widget build(BuildContext context) {
    // Colores principales de la aplicación
    final Color primaryColor = const Color(0xFFF5F5DC); // Beige
    final Color accentColor = const Color(0xFF8B4513); // Marrón

    return Scaffold(
      backgroundColor: primaryColor, // Fondo beige para la estética de manuscrito
      appBar: AppBar(
        title: const Text('Temporizador Pomodoro'),
        backgroundColor: accentColor, // Barra de aplicación marrón
        foregroundColor: primaryColor, // Texto e iconos beige en la barra de aplicación
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navega a la pantalla de configuración
              Navigator.of(context).pushNamed('/settings');
            },
            tooltip: 'Configuración',
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              // Navega a la pantalla de estadísticas
              Navigator.of(context).pushNamed('/statistics');
            },
            tooltip: 'Estadísticas',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getPhaseTitle(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: accentColor, // Texto marrón
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1), // Fondo ligeramente marrón para el temporizador
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accentColor, width: 2),
              ),
              child: Text(
                _formatTime(_remainingSeconds),
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: _getPhaseColor(), // Color dinámico según la fase
                  fontFamily: 'Monospace', // Fuente clara para el temporizador
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(_isRunning ? 'Pausar' : 'Iniciar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor, // Botón marrón
                    foregroundColor: primaryColor, // Texto/icono beige
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reiniciar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor, // Botón marrón
                    foregroundColor: primaryColor, // Texto/icono beige
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Pomodoros completados: $_pomodoroCount',
              style: TextStyle(
                fontSize: 18,
                color: accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}