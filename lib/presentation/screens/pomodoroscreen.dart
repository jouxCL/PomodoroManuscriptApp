Aquí tienes el código Dart completo y funcional para la pantalla `PomodoroScreen`, siguiendo todas tus especificaciones. Para que el código compile y funcione correctamente con el tema Material Design 3 y los colores especificados, he incluido también un archivo `main.dart` de ejemplo que configura el `MaterialApp` y el `ThemeData` de la aplicación.

---

### `pomodoro_screen.dart`

Este es el archivo principal de la pantalla Pomodoro.

import 'package:flutter/material.dart';
import 'dart:async'; // Necesario para el Timer

// Define un enum para las diferentes fases del temporizador Pomodoro
enum PomodoroPhase {
  pomodoro,
  shortBreak,
  longBreak,
}

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  // Duraciones configurables (eventualmente podrían venir de SettingsScreen)
  static const int _pomodoroTimeMinutes = 25;
  static const int _shortBreakTimeMinutes = 5;
  static const int _longBreakTimeMinutes = 15;
  static const int _pomodorosBeforeLongBreak = 4; // Cuántos pomodoros antes de un descanso largo

  // Variables de estado del temporizador
  late Duration _currentDuration;
  late PomodoroPhase _currentPhase;
  bool _isRunning = false;
  int _pomodoroCount = 0; // Número de pomodoros completados en el ciclo actual
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentPhase = PomodoroPhase.pomodoro;
    _currentDuration = const Duration(minutes: _pomodoroTimeMinutes);
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador para evitar fugas de memoria
    super.dispose();
  }

  // Ayudante para obtener la duración de una fase específica
  Duration _getDurationForPhase(PomodoroPhase phase) {
    switch (phase) {
      case PomodoroPhase.pomodoro:
        return const Duration(minutes: _pomodoroTimeMinutes);
      case PomodoroPhase.shortBreak:
        return const Duration(minutes: _shortBreakTimeMinutes);
      case PomodoroPhase.longBreak:
        return const Duration(minutes: _longBreakTimeMinutes);
    }
  }

  // Inicia el temporizador
  void _startTimer() {
    if (_isRunning) return; // Evita iniciar múltiples temporizadores

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentDuration.inSeconds == 0) {
        _timer?.cancel();
        _handlePhaseCompletion();
      } else {
        setState(() {
          _currentDuration = _currentDuration - const Duration(seconds: 1);
        });
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

  // Reinicia el temporizador al inicio de la fase actual
  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _currentDuration = _getDurationForPhase(_currentPhase);
    });
  }

  // Maneja la transición a la siguiente fase después de que un temporizador se completa
  void _handlePhaseCompletion() {
    setState(() {
      _isRunning = false; // Asegura que el temporizador esté detenido
      switch (_currentPhase) {
        case PomodoroPhase.pomodoro:
          _pomodoroCount++;
          if (_pomodoroCount % _pomodorosBeforeLongBreak == 0) {
            _currentPhase = PomodoroPhase.longBreak;
          } else {
            _currentPhase = PomodoroPhase.shortBreak;
          }
          break;
        case PomodoroPhase.shortBreak:
        case PomodoroPhase.longBreak:
          _currentPhase = PomodoroPhase.pomodoro;
          break;
      }
      _currentDuration = _getDurationForPhase(_currentPhase);
    });
    // Opcionalmente, se podría iniciar automáticamente la siguiente fase aquí
    // _startTimer();
  }

  // Salta la fase actual y pasa a la siguiente
  void _skipPhase() {
    _timer?.cancel();
    _handlePhaseCompletion();
    // Si queremos que se inicie automáticamente después de saltar, descomentar:
    // _startTimer();
  }

  // Formatea la duración en una cadena MM:SS
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  // Obtiene el nombre a mostrar para la fase actual
  String _getPhaseDisplayName(PomodoroPhase phase) {
    switch (phase) {
      case PomodoroPhase.pomodoro:
        return 'Pomodoro Focus';
      case PomodoroPhase.shortBreak:
        return 'Short Break';
      case PomodoroPhase.longBreak:
        return 'Long Break';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pomodoro Manuscript',
          style: textTheme.headlineMedium?.copyWith(
            color: colorScheme.onPrimary, // Texto en el color primario (beige)
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navega a SettingsScreen
              Navigator.of(context).pushNamed('/settings');
            },
            color: colorScheme.onPrimary, // Icono en el color primario
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              // Navega a StatisticsScreen
              Navigator.of(context).pushNamed('/statistics');
            },
            color: colorScheme.onPrimary, // Icono en el color primario
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: colorScheme.primary, // Fondo beige para el Drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: colorScheme.secondary, // Color acento para el encabezado
              ),
              child: Text(
                'Pomodoro Manuscript',
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onSecondary, // Texto beige sobre acento
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.timer, color: colorScheme.onPrimary),
              title: Text(
                'Pomodoro',
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                // Ya estamos en PomodoroScreen, no se necesita navegación
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: colorScheme.onPrimary),
              title: Text(
                'Settings',
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.of(context).pushNamed('/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart, color: colorScheme.onPrimary),
              title: Text(
                'Statistics',
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.of(context).pushNamed('/statistics');
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: colorScheme.onPrimary),
              title: Text(
                'Welcome',
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.of(context).pushNamed('/welcome');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Indicador de Fase
            Text(
              _getPhaseDisplayName(_currentPhase),
              style: textTheme.headlineMedium?.copyWith(
                color: colorScheme.onSurface, // Usa onSurface para el texto principal
              ),
            ),
            const SizedBox(height: 32),
            // Display del Temporizador
            Text(
              _formatDuration(_currentDuration),
              style: textTheme.displayLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 48),
            // Botones de Control
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                  child: Text(_isRunning ? 'Pause' : 'Start'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _skipPhase,
                  child: const Text('Skip'),
                ),
              ],
            ),
            const SizedBox(height: 48),
            // Indicador de Ciclo Pomodoro (marcadores de libro)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pomodorosBeforeLongBreak, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(
                    index < _pomodoroCount % _pomodorosBeforeLongBreak
                        ? Icons.bookmark_added // Pomodoro completado
                        : Icons.bookmark_border, // Pomodoro pendiente
                    color: colorScheme.secondary, // Color acento para los marcadores
                    size: 32,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

---

### `main.dart` (Archivo de ejemplo para configurar el tema y las rutas)

Este archivo es necesario para que la `PomodoroScreen` se muestre con el tema y los colores correctos, y para que la navegación funcione. Deberías colocarlo en la raíz de tu proyecto `lib/`.

import 'package:flutter/material.dart';
import 'package:pomodoro_manuscript_app/pomodoro_screen.dart';
// Importa las otras pantallas cuando las crees
// import 'package:pomodoro_manuscript_app/welcome_screen.dart';
// import 'package:pomodoro_manuscript_app/settings_screen.dart';
// import 'package:pomodoro_manuscript_app/statistics_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Manuscript App',
      theme: ThemeData(
        // Configuración de ColorScheme.fromSeed para Material Design 3
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF5F5DC), // Color primario como semilla
          primary: const Color(0xFFF5F5DC), // Color principal (beige)
          secondary: const Color(0xFF8B4513), // Color de acento (marrón)
          onPrimary: const Color(0xFF8B4513), // Color del texto/iconos sobre el color primario
          on