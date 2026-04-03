¡Entendido! Me enfocaré rigurosamente en la "NOTA ESPECIAL Y ESTRICTA DEL USUARIO". Esto significa que no generaré una `StatisticsScreen` completa con UI, sino que me centraré en los puntos solicitados: `WelcomeScreen` completa, `main.dart` con rutas y lógica de primer inicio, y la integración del saludo personalizado en `PomodoroScreen`. Las pantallas `SettingsScreen` y `StatisticsScreen` se proporcionarán con una implementación mínima para que las rutas funcionen.

Para que el código compile y funcione correctamente, necesitarás añadir la dependencia `shared_preferences` en tu archivo `pubspec.yaml`:

dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.0 # Asegúrate de usar la última versión estable

También, para la estética de manuscrito, he usado una fuente genérica `'Cursive'` en el `textTheme` de `main.dart`. Para una experiencia real, deberías añadir una fuente personalizada a tu proyecto (por ejemplo, en la carpeta `assets/fonts/`) y declararla en `pubspec.yaml`.

A continuación, se presenta el código completo y funcional para los archivos solicitados:

---

### 1. `main.dart`

Este archivo inicializa la aplicación, configura el tema Material 3, las rutas nombradas y la lógica para determinar si es el primer inicio de la app.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomodoro_manuscript_app/welcome_screen.dart';
import 'package:pomodoro_manuscript_app/pomodoro_screen.dart';
import 'package:pomodoro_manuscript_app/settings_screen.dart';
import 'package:pomodoro_manuscript_app/statistics_screen.dart';

void main() async {
  // Asegura que los widgets de Flutter estén inicializados antes de usar SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();

  // Obtiene una instancia de SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Verifica si la app ha sido lanzada antes. Por defecto, es false.
  bool hasLaunchedBefore = prefs.getBool('hasLaunchedBefore') ?? false;

  String initialRoute;
  if (hasLaunchedBefore) {
    // Si ya se lanzó antes, va directamente a la pantalla de Pomodoro
    initialRoute = '/pomodoro';
  } else {
    // Si es la primera vez, va a la pantalla de bienvenida
    initialRoute = '/welcome';
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Manuscript App',
      theme: ThemeData(
        // Configuración de ColorScheme.fromSeed para Material Design 3
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF5F5DC), // Color principal: beige
          primary: const Color(0xFFF5F5DC), // Fondo principal (papel beige)
          onPrimary: const Color(0xFF8B4513), // Texto/iconos sobre el color primario (tinta marrón)
          secondary: const Color(0xFF8B4513), // Color de acento (marrón)
          onSecondary: const Color(0xFFF5F5DC), // Texto/iconos sobre el color secundario
          surface: const Color(0xFFF5F5DC), // Superficies de componentes (tarjetas, diálogos)
          onSurface: const Color(0xFF8B4513), // Texto/iconos sobre superficies
          background: const Color(0xFFF5F5DC), // Fondo general de la pantalla
          onBackground: const Color(0xFF8B4513), // Texto/iconos sobre el fondo general
          error: Colors.red.shade700, // Color para errores
          onError: Colors.white, // Texto sobre color de error
        ),
        useMaterial3: true,
        // Tema de texto para la estética de manuscrito
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          displayMedium: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          displaySmall: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          headlineLarge: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          headlineMedium: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          headlineSmall: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          titleLarge: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          titleMedium: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          titleSmall: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          bodyLarge: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          bodyMedium: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          bodySmall: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          labelLarge: TextStyle(fontFamily: 'Cursive', color: Color(0xFFF5F5DC)), // Texto de botones
          labelMedium: TextStyle(fontFamily: 'Cursive', color: Color(0xFFF5F5DC)),
          labelSmall: TextStyle(fontFamily: 'Cursive', color: Color(0xFFF5F5DC)),
        ),
        // Tema para campos de entrada de texto
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xAAFFFFFF), // Blanco ligeramente transparente para el fondo del input
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Color(0xFF8B4513), width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const Border