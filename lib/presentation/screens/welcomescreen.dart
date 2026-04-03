¡Claro! Aquí tienes el código completo y funcional para la `WelcomeScreen` de tu aplicación "PomodoroManuscriptApp", incluyendo un archivo `main.dart` mínimo para que puedas ejecutarlo y ver la pantalla en acción, con la estética de manuscrito y la funcionalidad de saludo personalizado.

---

### `lib/main.dart`

Este archivo configura el tema global de la aplicación, incluyendo los colores y la tipografía "serif" para simular Times New Roman, y define las rutas para la navegación.

import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'pomodoro_screen.dart'; // Importa las pantallas placeholder
import 'settings_screen.dart';
import 'statistics_screen.dart';

// Colores principales de la aplicación
const Color primaryManuscript = Color(0xFFF5F5DC); // Papel beige
const Color accentManuscript = Color(0xFF8B4513); // Tinta marrón oscura

void main() {
  runApp(const PomodoroManuscriptApp());
}

class PomodoroManuscriptApp extends StatelessWidget {
  const PomodoroManuscriptApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Manuscript App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Configuración de Material Design 3 con ColorScheme.fromSeed
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryManuscript,
          primary: primaryManuscript,
          onPrimary: accentManuscript, // Color del texto sobre el fondo primario
          secondary: accentManuscript,
          onSecondary: primaryManuscript, // Color del texto sobre el fondo secundario
          surface: primaryManuscript,
          onSurface: accentManuscript,
          background: primaryManuscript,
          onBackground: accentManuscript,
          error: Colors.red,
          onError: Colors.white,
        ),
        useMaterial3: true,
        // Configuración de la fuente global.
        // Para usar "Times New Roman" real, deberías añadir la fuente a pubspec.yaml
        // y especificar su nombre exacto aquí. 'serif' es una fuente genérica.
        fontFamily: 'serif',
        
        // Tema para la AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryManuscript,
          foregroundColor: accentManuscript,
          elevation: 0, // Sin sombra para un look más plano
          titleTextStyle: TextStyle(
            fontFamily: 'serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accentManuscript,
          ),
        ),
        
        // Tema para el texto
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'serif', color: accentManuscript),
          displayMedium: TextStyle(fontFamily: 'serif', color: accentManuscript),
          displaySmall: TextStyle(fontFamily: 'serif', color: accentManuscript),
          headlineLarge: TextStyle(fontFamily: 'serif', color: accentManuscript),
          headlineMedium: TextStyle(fontFamily: 'serif', color: accentManuscript),
          headlineSmall: TextStyle(fontFamily: 'serif', color: accentManuscript),
          titleLarge: TextStyle(fontFamily: 'serif', color: accentManuscript),
          titleMedium: TextStyle(fontFamily: 'serif', color: accentManuscript),
          titleSmall: TextStyle(fontFamily: 'serif', color: accentManuscript),
          bodyLarge: TextStyle(fontFamily: 'serif', color: accentManuscript),
          bodyMedium: TextStyle(fontFamily: 'serif', color: accentManuscript),
          bodySmall: TextStyle(fontFamily: 'serif', color: accentManuscript),
          labelLarge: TextStyle(fontFamily: 'serif', color: accentManuscript),
          labelMedium: TextStyle(fontFamily: 'serif', color: accentManuscript),
          labelSmall: TextStyle(fontFamily: 'serif', color: accentManuscript),
        ),
        
        // Tema para los botones elevados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentManuscript, // Fondo del botón
            foregroundColor: primaryManuscript, // Color del texto del botón
            textStyle: const TextStyle(fontFamily: 'serif', fontSize: 18),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        
        // Tema para los campos de entrada de texto
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: primaryManuscript.withOpacity(0.7),
          labelStyle: const TextStyle(fontFamily: 'serif', color: accentManusscript),
          hintStyle: TextStyle(fontFamily: 'serif', color: accentManuscript.withOpacity(0.6)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: accentManuscript, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: accentManuscript, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: accentManuscript, width: 2.0),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/pomodoro': (context) => const PomodoroScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/statistics': (context) => const StatisticsScreen(),
      },
    );
  }
}

// --- Pantallas Placeholder para la navegación ---
// En una aplicación real, estas tendrían su propia lógica y UI.

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temporizador Pomodoro')),
      backgroundColor: primaryManuscript,
      body: Center(
        child: Text(
          'Pantalla de Pomodoro',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: accentManuscript),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      backgroundColor: primaryManuscript,
      body: Center(
        child: Text(
          'Pantalla de Configuración',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: accentManuscript),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas')),
      backgroundColor: primaryManuscript,
      body: Center(
        child: Text(
          'Pantalla de Estadísticas',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: accentManuscript),
        ),
      ),
    );
  }
}

---

### `lib/welcome_screen.dart`

Este archivo contiene la implementación de la `WelcomeScreen` con la lógica para pedir el nombre del usuario y mostrar un saludo personalizado, además de los botones de navegación.

import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? _userName; // Almacena el nombre del usuario
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  // En una aplicación real, esta función cargaría el nombre del usuario
  // desde un almacenamiento persistente como `shared_preferences` o `hive`.
  // Para este ejemplo, simulamos que el nombre no está establecido al inicio.
  void _loadUserName() {
    // Ejemplo:
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   _userName = prefs.getString('userName');
    // });
    setState(() {
      _userName = null; // Simula que el nombre no ha sido guardado aún
    });
  }

  // En una aplicación real, esta función guardaría el nombre del usuario
  // en un almacenamiento persistente.
  void _saveUserName(String name) {
    if (name.trim().isEmpty) return; // No guardar nombres vacíos
    setState(() {
      __userName = name.trim();
    });
    // Ejemplo:
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('userName', name.trim());
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    // Determinar el prefijo del saludo según la hora actual
    String greetingPrefix;
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greetingPrefix = 'Buenos días';
    } else if (hour < 18) {
      greetingPrefix = 'Buenas tardes';
    } else {
      greetingPrefix = 'Buenas noches';
    }

    return Scaffold(
      backgroundColor: colorScheme.primary, // Fondo de papel beige
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Título de la aplicación
              Text(
                'Pomodoro Manuscript',
                style: textTheme.displaySmall?.copyWith(
                  color: colorScheme.onPrimary, // Color de la tinta
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Muestra el campo de entrada de nombre o el saludo personalizado
              _userName == null || _userName!.isEmpty
                  ? _buildNameInput(context, colorScheme, textTheme)
                  : _buildGreeting(context, greetingPrefix, colorScheme, textTheme),

              const SizedBox(height: 60),

              // Botones de navegación
              _buildNavigationButton(
                context,
                'Iniciar Pomodoro',
                '/pomodoro',
                colorScheme,
                textTheme,
              ),
              const SizedBox(height: 20),
              _buildNavigationButton(
                context,
                'Configuración',
                '/settings',
                colorScheme,
                textTheme,
              ),
              const SizedBox(height: 20),
              _buildNavigationButton(
                context,
                'Estadísticas',
                '/statistics',
                colorScheme,
                textTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para solicitar el nombre del usuario
  Widget _buildNameInput(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      children: [
        Text(
          '¡Bienvenido! ¿Cuál es tu nombre?',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300, // Ancho fijo para el campo de entrada
          child: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Tu nombre',
              hintText: 'Ej. Juan Pérez',
              labelStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
              hintStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary.withOpacity(0.6)),
              // Los bordes y colores de relleno se configuran en main.dart en InputDecorationTheme
            ),
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
            cursorColor: colorScheme.secondary,
            onSubmitted: (value) {
              _saveUserName(value);
            },
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _saveUserName(_nameController.text);
          },
          child: Text(
            'Guardar Nombre',
            style: textTheme.labelLarge?.copyWith(color: colorScheme.onSecondary),
          ),
        ),
      ],
    );
  }

  // Widget para mostrar el saludo personalizado
  Widget _buildGreeting(BuildContext context, String greetingPrefix, ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      children: [
        Text(
          '$greetingPrefix $_userName, bienvenido a tu sesión de Pomodoro.',
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.onPrimary,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          '¡Concentración y productividad te esperan!',
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onPrimary.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Widget genérico para los botones de navegación
  Widget _buildNavigationButton(
    BuildContext context,
    String text,
    String routeName,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return SizedBox(
      width: 250, // Ancho fijo para consistencia de los botones
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context,