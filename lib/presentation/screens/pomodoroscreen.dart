¡Claro! Aquí tienes el código completo y funcional para la `PomodoroManuscriptApp`, incluyendo la `PomodoroScreen` con la integración del `PomodoroManuscriptProvider` y siguiendo todas tus estrictas instrucciones.

He estructurado el código en varios archivos para una mejor organización, pero lo he consolidado en una única respuesta para tu conveniencia.

---

### 1. `main.dart`

Este archivo configura la aplicación principal, el tema, las rutas y el `ChangeNotifierProvider` para `PomodoroManuscriptProvider`.

// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_manuscript_app/pomodoro_manuscript_provider.dart';
import 'package:pomodoro_manuscript_app/welcome_screen.dart';
import 'package:pomodoro_manuscript_app/pomodoro_screen.dart';
import 'package:pomodoro_manuscript_app/settings_screen.dart';
import 'package:pomodoro_manuscript_app/statistics_screen.dart';

void main() {
  runApp(const PomodoroManuscriptApp());
}

class PomodoroManuscriptApp extends StatelessWidget {
  const PomodoroManuscriptApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PomodoroManuscriptProvider(),
      child: MaterialApp(
        title: 'Pomodoro Manuscript App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFF5F5DC), // Beige primary
            primary: const Color(0xFFF5F5DC), // Beige
            onPrimary: const Color(0xFF8B4513), // Brown for text on primary
            secondary: const Color(0xFF8B4513), // Brown accent
            onSecondary: const Color(0xFFF5F5DC), // Beige for text on accent
            surface: const Color(0xFFF5F5DC), // Beige surface
            onSurface: const Color(0xFF8B4513), // Brown for text on surface
            background: const Color(0xFFF5F5DC), // Beige background
            onBackground: const Color(0xFF8B4513), // Brown for text on background
            error: Colors.red,
            onError: Colors.white,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            displayMedium: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            displaySmall: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            headlineLarge: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            headlineMedium: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            headlineSmall: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            titleLarge: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            titleMedium: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            titleSmall: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            bodyLarge: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            bodyMedium: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            bodySmall: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            labelLarge: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            labelMedium: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
            labelSmall: TextStyle(fontFamily: 'RobotoSerif', color: Color(0xFF8B4513)),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFFF5F5DC), // Beige
            foregroundColor: const Color(0xFF8B4513), // Brown
            elevation: 0,
            titleTextStyle: TextStyle(
              fontFamily: 'RobotoSerif',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: const Color(0xFF8B4513), // Brown
            foregroundColor: const Color(0xFFF5F5DC), // Beige
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B4513), // Brown
              foregroundColor: const Color(0xFFF5F5DC), // Beige
              textStyle: const TextStyle(fontFamily: 'RobotoSerif', fontSize: 18),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF8B4513), // Brown
              textStyle: const TextStyle(fontFamily: 'RobotoSerif', fontSize: 16),
            ),
          ),
          sliderTheme: SliderThemeData(
            activeTrackColor: const Color(0xFF8B4513), // Brown
            inactiveTrackColor: const Color(0xFF8B4513).withOpacity(0.3), // Lighter brown
            thumbColor: const Color(0xFF8B4513), // Brown
            overlayColor: const Color(0xFF8B4513).withOpacity(0.2), // Brown overlay
            valueIndicatorColor: const Color(0xFF8B4513), // Brown
            valueIndicatorTextStyle: const TextStyle(color: Color(0xFFF5F5DC)), // Beige
          ),
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const Color(0xFFF5F5DC); // Beige when selected
              }
              return const Color(0xFF8B4513); // Brown when unselected
            }),
            trackColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const Color(0xFF8B4513); // Brown when selected
              }
              return const Color(0xFF8B4513).withOpacity(0.5); // Lighter brown when unselected
            }),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const WelcomeScreen(),
          '/pomodoro': (context) => const PomodoroScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/statistics': (context) => const StatisticsScreen(),
        },
      ),
    );
  }
}

---

### 2. `pomodoro_manuscript_provider.dart`

Este archivo contiene la lógica de estado y el temporizador Pomodoro.

// pomodoro_manuscript_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';

enum PomodoroStatus {
  focus('Focus'),
  shortBreak('Short Break'),
  longBreak('Long Break'),
  stopped('Stopped');

  final String displayName;
  const PomodoroStatus(this.displayName);
}

class PomodoroManuscriptProvider extends ChangeNotifier {
  // --- Settings ---
  int _pomodoroDurationMinutes = 25; // Default 25 minutes
  int _shortBreakDurationMinutes = 5; // Default 5 minutes
  int _longBreakDurationMinutes = 15; // Default 15 minutes
  int _cyclesBeforeLongBreak = 4; // Default 4 pomodoros before a long break

  // --- Timer State ---
  Timer? _timer;
  int _currentRemainingSeconds = 0;
  PomodoroStatus _currentStatus = PomodoroStatus.stopped;
  bool _isRunning = false;

  // --- Cycle & Statistics ---
  int _currentCycle = 0; // Number of pomodoros completed in the current set
  int _completedPomodoros = 0; // Total pomodoros completed across sessions
  int _totalFocusTimeSeconds = 0; // Total focus time recorded

  PomodoroManuscriptProvider() {
    _currentRemainingSeconds = _pomodoroDurationMinutes * 60;
  }

  // --- Getters ---
  int get pomodoroDurationMinutes => _pomodoroDurationMinutes;
  int get shortBreakDurationMinutes => _shortBreakDurationMinutes;
  int get longBreakDurationMinutes => _longBreakDurationMinutes;
  int get cyclesBeforeLongBreak => _cyclesBeforeLongBreak;

  int get currentRemainingSeconds => _currentRemainingSeconds;
  PomodoroStatus get currentStatus => _currentStatus;
  bool get isRunning => _isRunning;

  int get currentCycle => _currentCycle;
  int get completedPomodoros => _completedPomodoros;
  int get totalFocusTimeMinutes => (_totalFocusTimeSeconds / 60).round();

  String get formattedTime {
    int minutes = _currentRemainingSeconds ~/ 60;
    int seconds = _currentRemainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // --- Actions ---
  void startTimer() {
    if (_isRunning) return; // Prevent starting if already running
    if (_currentStatus == PomodoroStatus.stopped) {
      // If starting from stopped, ensure we are in focus mode
      _currentStatus = PomodoroStatus.focus;
      _currentRemainingSeconds = _pomodoroDurationMinutes * 60;
    }

    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentRemainingSeconds > 0) {
        _currentRemainingSeconds--;
        if (_currentStatus == PomodoroStatus.focus) {
          _totalFocusTimeSeconds++; // Track focus time only during focus
        }
      } else {
        _timer?.cancel();
        _isRunning = false;
        _nextPhase();
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void pauseTimer() {
    if (!_isRunning) return;
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    _timer?.cancel();
    _isRunning = false;
    _currentStatus = PomodoroStatus.stopped;
    _currentRemainingSeconds = _pomodoroDurationMinutes * 60;
    _currentCycle = 0; // Reset cycle count for the current set
    notifyListeners();
  }

  void _nextPhase() {
    if (_currentStatus == PomodoroStatus.focus) {
      _completedPomodoros++;
      _currentCycle++;
      if (_currentCycle % _cyclesBeforeLongBreak == 0) {
        _currentStatus = PomodoroStatus.longBreak;
        _currentRemainingSeconds = _longBreakDurationMinutes * 60;
      } else {
        _currentStatus = PomodoroStatus.shortBreak;
        _currentRemainingSeconds = _shortBreakDurationMinutes * 60;
      }
    } else if (_currentStatus == PomodoroStatus.shortBreak || _currentStatus == PomodoroStatus.longBreak) {
      _currentStatus = PomodoroStatus.focus;
      _currentRemainingSeconds = _pomodoroDurationMinutes * 60;
      if (_currentCycle % _cyclesBeforeLongBreak == 0 && _currentStatus == PomodoroStatus.focus) {
        // If it was a long break, reset the cycle count for the next set
        _currentCycle = 0;
      }
    }
    // Automatically start the next phase
    startTimer();
    notifyListeners();
  }

  // --- Settings Update ---
  void updatePomodoroSettings({
    int? pomodoro,
    int? shortBreak,
    int? longBreak,
    int? cycles,
  }) {
    _pomodoroDurationMinutes = pomodoro ?? _pomodoroDurationMinutes;
    _shortBreakDurationMinutes = shortBreak ?? _shortBreakDurationMinutes;
    _longBreakDurationMinutes = longBreak ?? _longBreakDurationMinutes;
    _cyclesBeforeLongBreak = cycles ?? _cyclesBeforeLongBreak;

    // If timer is stopped, update the displayed time immediately
    if (_currentStatus == PomodoroStatus.stopped) {
      _currentRemainingSeconds = _pomodoroDurationMinutes * 60;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

---

### 3. `welcome_screen.dart`

La pantalla de bienvenida con un saludo personalizado y navegación.

// welcome_screen.dart
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Pomodoro Manuscript',
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book,
                size: 120,
                color: colorScheme.secondary,
              ),
              const SizedBox(height: 32),
              Text(
                '¡Bienvenido, Escriba!',
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Prepárate para un enfoque ininterrumpido y productivo.',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onBackground,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/pomodoro');
                },
                child: const Text('Comenzar Pomodoro'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
                child: const Text('Configuración'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/statistics');
                },
                child: const Text('Estadísticas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

---

### 4. `pomodoro_screen.dart`

Esta es la pantalla principal del temporizador Pomodoro, integrada con el `PomodoroManuscriptProvider`.

// pomodoro_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_manuscript_app/pomodoro_manuscript_provider.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Pomodoro',
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: colorScheme.onSurface),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          IconButton(
            icon: Icon(Icons.bar_chart, color: colorScheme.onSurface),
            onPressed: () {
              Navigator.pushNamed(context, '/statistics');
            },
          ),
        ],
      ),
      body: Consumer<PomodoroManuscriptProvider>(
        builder: (context, provider, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.currentStatus.displayName,
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.secondary.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      provider.formattedTime,
                      style: textTheme.displayLarge?.copyWith(
                        fontSize: 96,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: provider.isRunning ? provider.pauseTimer : provider.startTimer,
                        child: Text(provider.isRunning ? 'Pausar' : 'Iniciar'),
                      ),
                      const SizedBox(width: 24),
                      ElevatedButton(
                        onPressed: provider.resetTimer,
                        child: const Text('Reiniciar'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Pomodoros Completados: ${provider.completedPomodoros}',
                    style: textTheme.titleMedium?.copyWith(color: colorScheme.onBackground),
                  ),
                  Text(
                    'Ciclo Actual: ${provider.currentCycle} / ${provider.cyclesBeforeLongBreak}',
                    style: textTheme.titleSmall?.copyWith(color: colorScheme.onBackground),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

---

### 5. `settings_screen.dart`

La pantalla de configuración para ajustar los tiempos del Pomodoro.

// settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_manuscript_app/pomodoro_manuscript_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Configuración',
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
        ),
        centerTitle: true,
      ),
      body: Consumer<PomodoroManuscriptProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              _buildSettingSlider(
                context,
                title: 'Tiempo de Enfoque (minutos)',
                value: provider.pomodoroDurationMinutes.toDouble(),
                min: 1.0,
                max: 60.0,
                divisions: 59,
                onChanged: (value) {
                  provider.updatePomodoroSettings(pomodoro: value.toInt());
                },
              ),
              _buildSettingSlider(
                context,
                title: 'Descanso Corto (minutos)',
                value: provider.shortBreakDurationMinutes.toDouble(),
                min: 1.0,
                max: 30.0,
                divisions: 29,
                onChanged: (value) {
                  provider.updatePomodoroSettings(shortBreak: value.toInt());
                },
              ),
              _buildSettingSlider(
                context,
                title: 'Descanso Largo (minutos)',
                value: provider.longBreakDurationMinutes.toDouble(),
                min: 5.0,
                max: 60.0,
                divisions: 55,
                onChanged: (value) {
                  provider.updatePomodoroSettings(longBreak: value.toInt());
                },
              ),
              _buildSettingSlider(
                context,
                title: 'Ciclos antes de Descanso Largo',
                value: provider.cyclesBeforeLongBreak.toDouble(),
                min: 1.0,
                max: 10.0,
                divisions: 9,
                onChanged: (value) {
                  provider.updatePomodoroSettings(cycles: value.toInt());
                },
              ),
              // Puedes añadir más configuraciones aquí si es necesario
            ],
          );
        },
      ),
    );
  }

  Widget _buildSettingSlider(
    BuildContext context, {
    required String title,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ${value.toInt()}',
            style: textTheme.titleMedium?.copyWith(color: colorScheme.onBackground),
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
            label: value.toInt().toString(),
          ),
        ],
      ),
    );
  }
}

---

### 6. `statistics_screen.dart`

La pantalla de estadísticas que muestra datos reales del `PomodoroManuscriptProvider`.

// statistics_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_manuscript_app/pomodoro_manuscript_provider.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Estadísticas',
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
        ),
        centerTitle: true,
      ),
      body: Consumer<PomodoroManuscriptProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tu Progreso:',
                  style: textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildStatCard(
                  context,
                  icon: Icons.check_circle_outline,
                  title: 'Pomodoros Completados',
                  value: provider.completedPomodoros.toString(),
                ),
                _buildStatCard(
                  context,
                  icon: Icons.timer,
                  title: 'Tiempo Total de Enfoque',
                  value: '${provider.totalFocusTimeMinutes} minutos',
                ),
                // Puedes añadir más estadísticas aquí
                const Spacer(),
                Center(
                  child: Text(
                    '¡Sigue así, tu productividad está creciendo!',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onBackground,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, {required IconData icon, required String title, required String value}) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      color: colorScheme.primary,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: colorScheme.secondary),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: textTheme.headlineSmall?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

---

**Para ejecutar esta aplicación:**

1.  Crea un nuevo proyecto Flutter: `flutter create pomodoro_manuscript_app`
2.  Navega al directorio del proyecto: `cd pomodoro_manuscript_app`
3.  Asegúrate de tener la dependencia `provider` en tu `pubspec.yaml`:
    ```yaml
    dependencies:
      flutter:
        sdk: flutter
      provider: ^6.0.5 # O la última versión estable
    ```
4.  Ejecuta `flutter pub get`.
5.  Crea los archivos `.dart` mencionados (`main.dart`, `pomodoro_manuscript_provider.dart`,