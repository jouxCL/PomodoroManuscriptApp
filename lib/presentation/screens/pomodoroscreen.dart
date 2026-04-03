¡Excelente! Entendido. Me enfocaré rigurosamente en los nuevos requisitos para completar la `WelcomeScreen`, `main.dart`, la lógica de primer inicio y la integración del saludo personalizado en `PomodoroScreen`, manteniendo la estética y los colores definidos.

Aquí tienes el código completo y funcional para `main.dart`, `welcome_screen.dart`, `pomodoro_screen.dart`, `settings_screen.dart` y `statistics_screen.dart`.

---

**1. `pubspec.yaml` (Asegúrate de añadir esta dependencia)**

Para que el código funcione, necesitarás la dependencia `shared_preferences`. Añádela a tu archivo `pubspec.yaml` bajo `dependencies:`:

dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2 # Añade esta línea
  cupertino_icons: ^1.0.2

Luego, ejecuta `flutter pub get` en tu terminal.

---

**2. `main.dart`**

Este archivo inicializa la aplicación, configura el tema Material 3, las rutas y la lógica para decidir si mostrar `WelcomeScreen` o `PomodoroScreen` en el primer inicio.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'welcome_screen.dart';
import 'pomodoro_screen.dart';
import 'settings_screen.dart';
import 'statistics_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
  
  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    // Colores principales de la app
    final Color primaryColor = Color(0xFFF5F5DC); // Beige
    final Color accentColor = Color(0xFF8B4513); // Marrón

    return MaterialApp(
      title: 'Pomodoro Manuscript App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          onPrimary: accentColor,
          secondary: accentColor,
          onSecondary: primaryColor,
          surface: primaryColor,
          onSurface: accentColor,
          background: primaryColor,
          onBackground: accentColor,
          error: Colors.red,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: primaryColor, // Fondo general de las pantallas
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: accentColor, // Color del texto y iconos en AppBar
          elevation: 0,
          titleTextStyle: TextStyle(
            color: accentColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(color: accentColor),
          displayMedium: TextStyle(color: accentColor),
          displaySmall: TextStyle(color: accentColor),
          headlineLarge: TextStyle(color: accentColor),
          headlineMedium: TextStyle(color: accentColor),
          headlineSmall: TextStyle(color: accentColor),
          titleLarge: TextStyle(color: accentColor),
          titleMedium: TextStyle(color: accentColor),
          titleSmall: TextStyle(color: accentColor),
          bodyLarge: TextStyle(color: accentColor),
          bodyMedium: TextStyle(color: accentColor),
          bodySmall: TextStyle(color: accentColor),
          labelLarge: TextStyle(color: accentColor),
          labelMedium: TextStyle(color: accentColor),
          labelSmall: TextStyle(color: accentColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor, // Color de fondo del botón
            foregroundColor: primaryColor, // Color del texto del botón
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: accentColor, // Color del texto del botón
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: primaryColor.withOpacity(0.7),
          labelStyle: TextStyle(color: accentColor),
          hintStyle: TextStyle(color: accentColor.withOpacity(0.6)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: accentColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: accentColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: accentColor, width: 2),
          ),
        ),
      ),
      initialRoute: isFirstLaunch ? '/welcome' : '/pomodoro',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/pomodoro': (context) => PomodoroScreen(),
        '/settings': (context) => SettingsScreen(),
        '/statistics': (context) => StatisticsScreen(),
      },
    );
  }
}

---

**3. `welcome_screen.dart`**

Esta pantalla permite al usuario ingresar su nombre. Solo se muestra en el primer inicio de la aplicación.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveUserNameAndNavigate() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', _nameController.text.trim());
      await prefs.setBool('isFirstLaunch', false); // Marcar como no primer inicio

      Navigator.of(context).pushReplacementNamed('/pomodoro');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color accentColor = Theme.of(context).colorScheme.onPrimary;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          'Bienvenido a Pomodoro Manuscript',
          style: TextStyle(color: accentColor),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¡Hola! Parece que es tu primera vez aquí.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Para empezar, ¿cómo te llamas?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Tu nombre',
                    hintText: 'Ej: Juan Pérez',
                    prefixIcon: Icon(Icons.person, color: accentColor),
                  ),
                  style: TextStyle(color: accentColor),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, ingresa tu nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _saveUserNameAndNavigate,
                  child: const Text('Continuar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

---

**4. `pomodoro_screen.dart`**

Esta es la pantalla principal del temporizador Pomodoro, ahora con el saludo personalizado al usuario.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async'; // Para el temporizador

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  String _userName = 'Usuario'; // Valor por defecto
  int _pomodoroDuration = 25 * 60; // 25 minutos en segundos
  int _shortBreakDuration = 5 * 60; // 5 minutos en segundos
  int _longBreakDuration = 15 * 60; // 15 minutos en segundos
  int _currentDuration = 25 * 60; // Duración actual del temporizador
  int _remainingSeconds = 25 * 60; // Segundos restantes
  Timer? _timer;
  bool _isRunning = false;
  int _pomodoroCount = 0; // Contador de ciclos Pomodoro completados
  PomodoroPhase _currentPhase = PomodoroPhase.pomodoro;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadSettings(); // Cargar configuraciones guardadas
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Usuario';
    });
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _pomodoroDuration = prefs.getInt('pomodoroDuration') ?? (25 * 60);
      _shortBreakDuration = prefs.getInt('shortBreakDuration') ?? (5 * 60);
      _longBreakDuration = prefs.getInt('longBreakDuration') ?? (15 * 60);
      // Reiniciar el temporizador con la nueva duración si no está corriendo
      if (!_isRunning) {
        _currentDuration = _pomodoroDuration;
        _remainingSeconds = _pomodoroDuration;
      }
    });
  }

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        _handlePhaseCompletion();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _currentPhase = PomodoroPhase.pomodoro;
      _currentDuration = _pomodoroDuration;
      _remainingSeconds = _pomodoroDuration;
      _pomodoroCount = 0; // Reiniciar el contador de ciclos
    });
  }

  void _handlePhaseCompletion() {
    // Lógica para cambiar de fase (Pomodoro -> Descanso Corto -> Pomodoro -> Descanso Largo, etc.)
    setState(() {
      if (_currentPhase == PomodoroPhase.pomodoro) {
        _pomodoroCount++;
        if (_pomodoroCount % 4 == 0) {
          _currentPhase = PomodoroPhase.longBreak;
          _currentDuration = _longBreakDuration;
        } else {
          _currentPhase = PomodoroPhase.shortBreak;
          _currentDuration = _shortBreakDuration;
        }
      } else {
        _currentPhase = PomodoroPhase.pomodoro;
        _currentDuration = _pomodoroDuration;
      }
      _remainingSeconds = _currentDuration;
      // Opcional: iniciar automáticamente la siguiente fase
      // _startTimer();
    });

    // Mostrar una notificación o diálogo
    _showCompletionDialog(_currentPhase);
  }

  void _showCompletionDialog(PomodoroPhase nextPhase) {
    String title;
    String content;
    if (nextPhase == PomodoroPhase.pomodoro) {
      title = '¡Descanso Terminado!';
      content = 'Es hora de volver a concentrarte. ¿Listo para otro Pomodoro?';
    } else if (nextPhase == PomodoroPhase.shortBreak) {
      title = '¡Pomodoro Completado!';
      content = 'Tómate un breve descanso. ¡Te lo mereces!';
    } else { // Long Break
      title = '¡Pomodoro Completado!';
      content = 'Has completado 4 Pomodoros. ¡Disfruta de un descanso largo!';
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          content: Text(content, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          actions: <Widget>[
            TextButton(
              child: Text('Continuar', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
              onPressed: () {
                Navigator.of(context).pop();
                _startTimer(); // Iniciar la siguiente fase automáticamente
              },
            ),
          ],
        );
      },
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _getPhaseTitle() {
    switch (_currentPhase) {
      case PomodoroPhase.pomodoro:
        return 'Concentración';
      case PomodoroPhase.shortBreak:
        return 'Descanso Corto';
      case PomodoroPhase.longBreak:
        return 'Descanso Largo';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color accentColor = Theme.of(context).colorScheme.onPrimary;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('Pomodoro Manuscript', style: TextStyle(color: accentColor)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: accentColor),
            onPressed: () async {
              await Navigator.of(context).pushNamed('/settings');
              _loadSettings(); // Recargar settings al volver
            },
          ),
          IconButton(
            icon: Icon(Icons.bar_chart, color: accentColor),
            onPressed: () {
              Navigator.of(context).pushNamed('/statistics');
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hola, $_userName!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                _getPhaseTitle(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      value: _remainingSeconds / _currentDuration,
                      strokeWidth: 10,
                      backgroundColor: accentColor.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                    ),
                  ),
                  Text(
                    _formatTime(_remainingSeconds),
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isRunning ? _pauseTimer : _startTimer,
                    child: Text(_isRunning ? 'Pausar' : 'Iniciar'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _resetTimer,
                    child: const Text('Reiniciar'),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Ciclos Pomodoro completados: $_pomodoroCount',
                style: TextStyle(
                  fontSize: 18,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum PomodoroPhase {
  pomodoro,
  shortBreak,
  longBreak,
}

---

**5. `settings_screen.dart`**

Una pantalla básica de configuración. Aquí se podrían añadir opciones para ajustar los tiempos de Pomodoro, descanso, etc.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _pomodoroController;
  late TextEditingController _shortBreakController;
  late TextEditingController _longBreakController;

  @override
  void initState() {
    super.initState();
    _pomodoroController = TextEditingController();
    _shortBreakController = TextEditingController();
    _longBreakController = TextEditingController();
    _loadSettings();
  }

  @override
  void dispose() {
    _pomodoroController.dispose();
    _shortBreakController.dispose();
    _longBreakController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _pomodoroController.text = ((prefs.getInt('pomodoroDuration') ?? (25 * 60)) ~/ 60).toString();
      _shortBreakController.text = ((prefs.getInt('shortBreakDuration') ?? (5 * 60)) ~/ 60).toString();
      _longBreakController.text = ((prefs.getInt('longBreakDuration') ?? (15 * 60)) ~/ 60).toString();
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('pomodoroDuration', int.parse(_pomodoroController.text) * 60);
    await prefs.setInt('shortBreakDuration', int.parse(_shortBreakController.text) * 60);
    await prefs.setInt('longBreakDuration', int.parse(_longBreakController.text) * 60);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Configuración guardada', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color accentColor = Theme.of(context).colorScheme.onPrimary;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('Configuración', style: TextStyle(color: accentColor)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tiempos del Pomodoro (en minutos)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _pomodoroController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Duración del Pomodoro',
                suffixText: 'min',
              ),
              style: TextStyle(color: accentColor),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _shortBreakController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Duración del Descanso Corto',
                suffixText: 'min',
              ),
              style: TextStyle(color: accentColor),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _longBreakController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Duración del Descanso Largo',
                suffixText: 'min',
              ),
              style: TextStyle(color: accentColor),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: _saveSettings,
                child: const Text('Guardar Configuración'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

---

**6. `statistics_screen.dart`**

Una pantalla básica para mostrar estadísticas.

import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color accentColor = Theme.of(context).colorScheme.onPrimary;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('Estadísticas', style: TextStyle(color: accentColor)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bar_chart,
                size: 80,
                color: accentColor.withOpacity(0.7),
              ),
              const SizedBox(height: 20),
              Text(
                'Aquí se mostrarán tus estadísticas de productividad.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: accentColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '¡Sigue trabajando para ver tus progresos!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: accentColor.withOpacity(0.8),
                ),
              ),
              // Aquí se podrían añadir gráficos, listas de sesiones, etc.
            ],
          ),
        ),
      ),
    );
  }
}

---

**Explicación de los cambios y cumplimiento de requisitos:**

1.  **`main.dart` completo:**
    *   Configura `MaterialApp` con `ColorScheme.fromSeed` usando `#F5F5DC` como `seedColor` y `primary`, y `#8B4513` como `onPrimary` (texto/iconos sobre el color primario) y `secondary` (color de acento).
    *   Define todas las rutas nombradas (`/welcome`, `/pomodoro`, `/settings`, `/statistics`).
    *   Implementa la lógica de primer inicio usando `SharedPreferences`:
        *   `isFirstLaunch` se lee de `SharedPreferences`. Si no existe, se asume `true`.
        *   `initialRoute` se establece condicionalmente a `/welcome` o `/pomodoro`.

2.