¡Excelente! Aquí tienes el código Dart completo y funcional para la `PomodoroScreen`, adhiriéndome estrictamente a todos los requisitos, incluyendo la corrección de los errores de compilación relacionados con la resolución de paquetes y las expresiones no constantes.

Este código implementa un temporizador Pomodoro con las funcionalidades básicas de iniciar, pausar, reiniciar y saltar sesiones, así como la lógica para alternar entre Pomodoro, descanso corto y descanso largo. La interfaz de usuario sigue la estética de manuscrito con los colores especificados.

import 'dart:async'; // Necesario para la clase Timer
import 'package:flutter/material.dart';
import 'dart:ui'; // Necesario para FontFeature.tabularFigures

// Enum para representar los diferentes tipos de sesiones del Pomodoro
enum SessionType {
  pomodoro,
  shortBreak,
  longBreak,
}

class PomodoroScreen extends StatefulWidget {
  // Definimos las rutas nombradas para la navegación a otras pantallas.
  // Se espera que estas rutas estén definidas en el MaterialApp principal.
  static const String routeName = '/pomodoro';
  static const String settingsRoute = '/settings';
  static const String statisticsRoute = '/statistics';

  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  Timer? _timer;
  bool _isRunning = false;
  Duration _currentDuration = const Duration(minutes: 25); // Duración inicial por defecto (Pomodoro)
  SessionType _sessionType = SessionType.pomodoro;
  int _pomodoroCount = 0; // Número de pomodoros completados en el ciclo actual

  // --- Constantes de configuración (definidas internamente para evitar errores de paquete) ---
  // En una aplicación real, estos valores provendrían de un servicio de configuración
  // o preferencias de usuario (ej. SharedPreferences) y se cargarían al iniciar la pantalla.
  static const Duration _pomodoroDuration = Duration(minutes: 25);
  static const Duration _shortBreakDuration = Duration(minutes: 5);
  static const Duration _longBreakDuration = Duration(minutes: 15);
  static const int _pomodoroCyclesBeforeLongBreak = 4; // Cuántos pomodoros antes de un descanso largo
  // -----------------------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    _resetTimer(initial: true); // Inicializa el estado del temporizador al cargar la pantalla
  }

  @override
  void dispose() {
    _timer?.cancel(); // Asegura que el temporizador se cancele al salir de la pantalla
    super.dispose();
  }

  /// Inicia o reanuda el temporizador.
  void _startTimer() {
    if (_isRunning) return; // Evita iniciar múltiples temporizadores
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentDuration.inSeconds == 0) {
        _timer?.cancel();
        _nextSession(); // Pasa a la siguiente sesión cuando el tiempo llega a cero
      } else {
        setState(() {
          _currentDuration = _currentDuration - const Duration(seconds: 1);
        });
      }
    });
  }

  /// Pausa el temporizador.
  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  /// Reinicia el temporizador a la duración predeterminada de la sesión actual.
  void _resetTimer({bool initial = false}) {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      switch (_sessionType) {
        case SessionType.pomodoro:
          _currentDuration = _pomodoroDuration;
          break;
        case SessionType.shortBreak:
          _currentDuration = _shortBreakDuration;
          break;
        case SessionType.longBreak:
          _currentDuration = _longBreakDuration;
          break;
      }
      if (initial) {
        _pomodoroCount = 0; // Reinicia el contador de pomodoros solo en la carga inicial o reset completo
      }
    });
  }

  /// Salta la sesión actual y pasa a la siguiente.
  void _skipSession() {
    _timer?.cancel();
    _nextSession();
  }

  /// Lógica para determinar la siguiente sesión (Pomodoro, Descanso Corto, Descanso Largo).
  void _nextSession() {
    setState(() {
      switch (_sessionType) {
        case SessionType.pomodoro:
          _pomodoroCount++;
          if (_pomodoroCount % _pomodoroCyclesBeforeLongBreak == 0) {
            _sessionType = SessionType.longBreak;
          } else {
            _sessionType = SessionType.shortBreak;
          }
          break;
        case SessionType.shortBreak:
        case SessionType.longBreak:
          _sessionType = SessionType.pomodoro;
          break;
      }
      _resetTimer(); // Reinicia la duración para el nuevo tipo de sesión
      if (_isRunning) {
        // Si el temporizador estaba corriendo, lo reinicia para la nueva sesión
        _startTimer();
      }
    });
  }

  /// Formatea una duración en un string "MM:SS".
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  /// Obtiene el título legible de la sesión actual.
  String _getSessionTitle() {
    switch (_sessionType) {
      case SessionType.pomodoro:
        return 'Sesión de Pomodoro';
      case SessionType.shortBreak:
        return 'Descanso Corto';
      case SessionType.longBreak:
        return 'Descanso Largo';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Accede al ColorScheme del tema actual para Material Design 3
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    // Define el color accent directamente, como se especificó
    final Color accentColor = const Color(0xFF8B4513); // Color #8B4513 (marrón)

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
        backgroundColor: colorScheme.primary, // Fondo del AppBar (beige)
        foregroundColor: accentColor, // Color del texto e iconos del AppBar (marrón)
        elevation: 0, // Sin sombra para un aspecto más plano y de "manuscrito"
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Configuración',
            onPressed: () {
              // Navega a la pantalla de configuración usando la ruta nombrada
              Navigator.pushNamed(context, PomodoroScreen.settingsRoute);
            },
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Estadísticas',
            onPressed: () {
              // Navega a la pantalla de estadísticas usando la ruta nombrada
              Navigator.pushNamed(context, PomodoroScreen.statisticsRoute);
            },
          ),
        ],
      ),
      backgroundColor: colorScheme.primary, // Fondo principal de la pantalla (beige)
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Título de la sesión actual (Pomodoro, Descanso Corto, etc.)
            Text(
              _getSessionTitle(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: accentColor, // Usa el color accent para el título
              ),
            ),
            const SizedBox(height: 20),
            // Visualización del temporizador
            Text(
              _formatDuration(_currentDuration),
              // NOTA: Este Text no puede ser 'const' porque su contenido (_currentDuration) cambia.
              style: TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.w100, // Peso ligero para un aspecto elegante
                color: accentColor,
                // Asegura que los dígitos tengan un ancho fijo para evitar "saltos" en la UI
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: 40),
            // Botones de control del temporizador
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(_isRunning ? 'Pausar' : 'Iniciar'),
                  // NOTA: Este Text no puede ser 'const' porque su contenido cambia.
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor, // Fondo del botón (marrón)
                    foregroundColor: colorScheme.primary, // Texto/icono del botón (beige)
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reiniciar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: colorScheme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _skipSession,
                  icon: const Icon(Icons.skip_next),
                  label: const Text('Saltar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: colorScheme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Contador de pomodoros completados en el ciclo actual
            Text(
              'Pomodoros completados en este ciclo: $_pomodoroCount',
              // NOTA: Este Text no puede ser 'const' porque su contenido cambia.
              style: TextStyle(
                fontSize: 20,
                color: accentColor.withOpacity(0.8), // Un poco más claro para contraste
              ),
            ),
          ],
        ),
      ),
    );
  }
}