¡Excelente! Aquí tienes el archivo `main.dart` completo para tu "PomodoroManuscriptApp", siguiendo todos los requisitos.

import 'package:flutter/material.dart';

// Importaciones de las pantallas desde la ruta especificada
import 'package:pomodoro_manuscript_app/presentation/screens/welcomescreen.dart';
import 'package:pomodoro_manuscript_app/presentation/screens/pomodoroscreen.dart';
import 'package:pomodoro_manuscript_app/presentation/screens/settingsscreen.dart';
import 'package:pomodoro_manuscript_app/presentation/screens/statisticsscreen.dart';

void main() {
  runApp(const PomodoroManuscriptApp());
}

class PomodoroManuscriptApp extends StatelessWidget {
  const PomodoroManuscriptApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definición de los colores primario y accent para mayor claridad
    const Color primaryManuscriptColor = Color(0xFFF5F5DC); // Beige
    const Color accentManuscriptColor = Color(0xFF8B4513); // Marrón

    return MaterialApp(
      title: 'Pomodoro Manuscript App',
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de "Debug"
      theme: ThemeData(
        useMaterial3: true,
        // Genera un ColorScheme basado en el color semilla beige
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryManuscriptColor,
          // Puedes personalizar más el esquema de colores aquí si es necesario.
          // Por ejemplo, para asegurar que el color accent se use explícitamente:
          // primary: primaryManuscriptColor,
          // secondary: accentManuscriptColor,
          // tertiary: accentManuscriptColor,
          // onPrimary: accentManuscriptColor, // Texto sobre el color primario
          // onSecondary: primaryManuscriptColor, // Texto sobre el color secundario
        ),
        // Puedes personalizar otros aspectos del tema para reflejar la estética de manuscrito
        // Por ejemplo, para que el color accent se use en FloatingActionButton:
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: accentManuscriptColor,
          foregroundColor: primaryManuscriptColor, // Color del icono/texto en el FAB
        ),
        // Personalización de AppBar para que coincida con la estética
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryManuscriptColor,
          foregroundColor: accentManuscriptColor, // Color del título y iconos
          elevation: 0, // Sin sombra para un look más plano
        ),
        // Personalización de botones, etc.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentManuscriptColor,
            foregroundColor: primaryManuscriptColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Bordes ligeramente redondeados
            ),
          ),
        ),
        // Para un look más "manuscrito", podrías considerar una fuente personalizada
        // Por ejemplo, con google_fonts:
        // textTheme: GoogleFonts.merriweatherTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
      
      // Define la ruta inicial de la aplicación
      initialRoute: '/',

      // Define las rutas nombradas para todas las pantallas
      routes: {
        '/': (context) => const WelcomeScreen(), // Pantalla inicial
        '/pomodoro': (context) => const PomodoroScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/statistics': (context) => const StatisticsScreen(),
      },
    );
  }
}

**Explicación de los puntos clave:**

1.  **`void main()` y `runApp()`**: El punto de entrada estándar de cualquier aplicación Flutter.
2.  **Importaciones**: Se importan `material.dart` y cada una de tus pantallas desde la ruta `package:pomodoro_manuscript_app/presentation/screens/`. Asegúrate de que el nombre del paquete (`pomodoro_manuscript_app`) coincida con el nombre de tu proyecto en `pubspec.yaml`.
3.  **`PomodoroManuscriptApp` (Widget Raíz)**: Un `StatelessWidget` que contiene la configuración principal de la aplicación.
4.  **`MaterialApp`**:
    *   `title`: El título que aparece en el gestor de tareas del dispositivo.
    *   `debugShowCheckedModeBanner: false`: Oculta la pequeña etiqueta "DEBUG" en la esquina superior derecha.
    *   **`theme`**:
        *   `useMaterial3: true`: Habilita el diseño Material 3.
        *   `colorScheme: ColorScheme.fromSeed(seedColor: primaryManuscriptColor)`: Genera un esquema de colores completo basado en el color beige (`#F5F5DC`) que proporcionaste. Esto asegura que todos los widgets de Material 3 tengan colores coherentes derivados de tu color primario.
        *   **Personalizaciones adicionales**: He añadido ejemplos comentados para cómo podrías usar `accentManuscriptColor` (`#8B4513`) en elementos específicos como `FloatingActionButtonThemeData` o `AppBarTheme`, ya que `fromSeed` no lo usa directamente a menos que lo especifiques en los parámetros `primary`, `secondary`, etc., o en los temas de widgets individuales.
    *   **`initialRoute: '/'`**: Establece `WelcomeScreen` como la pantalla que se muestra al iniciar la aplicación.
    *   **`routes`**: Un mapa que asocia nombres de ruta (strings) con constructores de widgets. Esto permite la navegación entre pantallas usando `Navigator.pushNamed()`.

Este `main.dart` debería compilar sin problemas, asumiendo que tus archivos de pantalla (`welcomescreen.dart`, etc.) existen y contienen un `StatelessWidget` o `StatefulWidget` básico.