¡Claro! Aquí tienes el archivo `main.dart` completo para tu "PomodoroManuscriptApp", siguiendo todas tus especificaciones.

He añadido algunas mejoras al tema para que la estética de "manuscrito en papel beige" y el color acento se apliquen de forma más consistente, como el color de fondo del `Scaffold` y los colores de la `AppBar` y los botones.

**Suposición importante:** Para que las rutas nombradas funcionen correctamente y sean robustas, he asumido que cada una de tus pantallas (`WelcomeScreen`, `PomodoroScreen`, etc.) tiene una propiedad estática `routeName` definida, por ejemplo:

// En welcomescreen.dart
class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome'; // <-- Esta línea
  // ...
}

Si tus archivos de pantalla no tienen esto, deberías añadirlo o cambiar las rutas en `main.dart` para usar cadenas literales directamente (ej. `'/welcome'`).

---

import 'package:flutter/material.dart';

// Importaciones de las pantallas
import 'package:pomodoro_manuscript_app/presentation/screens/welcomescreen.dart';
import 'package:pomodoro_manuscript_app/presentation/screens/pomodoroscreen.dart';
import 'package:pomodoro_manuscript_app/presentation/screens/settingsscreen.dart';
import 'package:pomodoro_manuscript_app/presentation/screens/statisticsscreen.dart';

void main() {
  runApp(const PomodoroManuscriptApp());
}

class PomodoroManuscriptApp extends StatelessWidget {
  const PomodoroManuscriptApp({super.key});

  // Definición de los colores para fácil acceso y consistencia
  static const Color kPrimaryColor = Color(0xFFF5F5DC); // Papel beige
  static const Color kAccentColor = Color(0xFF8B4513); // Marrón sepia/tinta

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Manuscript App',
      debugShowCheckedModeBanner: false, // Oculta el banner de "Debug"

      theme: ThemeData(
        useMaterial3: true,
        // Configuración del ColorScheme usando el color primario como semilla
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryColor,
          // Puedes ajustar otros colores del esquema si fromSeed no genera lo que esperas
          // Por ejemplo, para asegurar que el acento sea el color secundario:
          // secondary: kAccentColor,
          // tertiary: kAccentColor,
        ).copyWith(
          // Aseguramos que el color de los elementos interactivos (como el FAB) use el acento
          primary: kPrimaryColor, // Mantener el primario beige
          secondary: kAccentColor, // Usar el acento para elementos secundarios
          onSecondary: Colors.white, // Texto blanco sobre el acento
          tertiary: kAccentColor, // Otro nivel de acento si es necesario
          onTertiary: Colors.white,
        ),

        // Color de fondo general para los Scaffolds (el "papel")
        scaffoldBackgroundColor: kPrimaryColor,

        // Tema para la AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor, // Fondo de la AppBar beige
          foregroundColor: kAccentColor, // Color del texto/iconos en la AppBar (tinta)
          elevation: 0, // Sin sombra para un look más plano de manuscrito
          centerTitle: true,
        ),

        // Tema para los botones elevados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kAccentColor, // Fondo del botón con el color acento
            foregroundColor: Colors.white, // Texto del botón blanco
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Bordes ligeramente redondeados
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Tema para los Floating Action Buttons
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kAccentColor,
          foregroundColor: Colors.white,
        ),

        // Tema para el texto (opcional, si quieres usar una fuente específica)
        // Asegúrate de añadir la fuente a tu pubspec.yaml si la usas.
        // Por ejemplo, para una fuente tipo serif:
        // textTheme: const TextTheme(
        //   bodyLarge: TextStyle(fontFamily: 'Merriweather', color: kAccentColor),
        //   bodyMedium: TextStyle(fontFamily: 'Merriweather', color: kAccentColor),
        //   titleLarge: TextStyle(fontFamily: 'Merriweather', color: kAccentColor),
        //   headlineMedium: TextStyle(fontFamily: 'Merriweather', color: kAccentColor),
        // ),
      ),

      // Ruta inicial de la aplicación
      initialRoute: WelcomeScreen.routeName,

      // Definición de todas las rutas nombradas
      routes: {
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        PomodoroScreen.routeName: (context) => const PomodoroScreen(),
        SettingsScreen.routeName: (context) => const SettingsScreen(),
        StatisticsScreen.routeName: (context) => const StatisticsScreen(),
      },
    );
  }
}