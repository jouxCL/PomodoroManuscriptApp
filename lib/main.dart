¡Claro! Aquí tienes el archivo `main.dart` completo para tu "PomodoroManuscriptApp", siguiendo todos los requisitos especificados.

import 'package:flutter/material.dart';

// Importaciones de las pantallas desde 'presentation/screens/'
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
    // Definición del color primario y acento
    const Color primaryManuscriptColor = Color(0xFFF5F5DC); // Beige
    const Color accentManuscriptColor = Color(0xFF8B4513); // Marrón Silla

    return MaterialApp(
      title: 'Pomodoro Manuscript App',
      debugShowCheckedModeBanner: false, // Oculta la etiqueta "DEBUG" en la esquina superior derecha

      theme: ThemeData(
        // Configuración del ColorScheme usando el color primario como semilla
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryManuscriptColor,
          // Puedes personalizar más colores si lo deseas, por ejemplo:
          primary: primaryManuscriptColor,
          onPrimary: Colors.black87, // Texto sobre el color primario
          secondary: accentManuscriptColor,
          onSecondary: Colors.white, // Texto sobre el color acento
          surface: primaryManuscriptColor, // Color de las superficies de los componentes
          onSurface: Colors.black87, // Texto sobre las superficies
          background: primaryManuscriptColor, // Color de fondo general
          onBackground: Colors.black87, // Texto sobre el fondo
          error: Colors.red.shade700, // Color para errores
          onError: Colors.white, // Texto sobre errores
        ),
        useMaterial3: true, // Habilita Material Design 3
        // Puedes añadir más personalizaciones al tema aquí, por ejemplo:
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryManuscriptColor,
          foregroundColor: accentManuscriptColor, // Color del texto y iconos en el AppBar
          elevation: 0, // Sin sombra para un look más plano
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: accentManuscriptColor,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentManuscriptColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: accentManuscriptColor,
          ),
        ),
        // Otros temas de componentes si es necesario
      ),

      // Definición de las rutas nombradas para la navegación
      initialRoute: '/', // La pantalla inicial de la aplicación

      routes: {
        '/': (context) => const WelcomeScreen(),
        '/pomodoro': (context) => const PomodoroScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/statistics': (context) => const StatisticsScreen(),
      },
    );
  }
}

**Explicación de los elementos clave:**

1.  **`import 'package:flutter/material.dart';`**: Importa el paquete fundamental de Flutter para construir interfaces de usuario.
2.  **Importaciones de Pantallas**: Cada pantalla se importa desde su ubicación especificada (`lib/presentation/screens/`). Asegúrate de que el nombre del paquete (`pomodoro_manuscript_app`) coincida con el `name` en tu archivo `pubspec.yaml`.
3.  **`void main() { runApp(const PomodoroManuscriptApp()); }`**: El punto de entrada de la aplicación. `runApp` toma un widget raíz, en este caso, `PomodoroManuscriptApp`.
4.  **`class PomodoroManuscriptApp extends StatelessWidget`**: El widget raíz de tu aplicación. Es `StatelessWidget` porque el estado principal de la aplicación (como el tema y las rutas) no cambia durante la vida útil de este widget.
5.  **`MaterialApp`**: El widget que envuelve toda tu aplicación Flutter, proporcionando funcionalidades de Material Design.
    *   **`title`**: Un título descriptivo para la aplicación (usado por el sistema operativo, no visible en la UI).
    *   **`debugShowCheckedModeBanner: false`**: Oculta la pequeña etiqueta "DEBUG" que aparece en modo de desarrollo.
    *   **`theme: ThemeData(...)`**: Define el tema visual de tu aplicación.
        *   **`colorScheme: ColorScheme.fromSeed(...)`**: Genera un esquema de colores completo basado en un `seedColor`. Hemos usado `primaryManuscriptColor` (`#F5F5DC`) como semilla. He añadido algunas personalizaciones adicionales para `primary`, `secondary`, `onPrimary`, etc., para asegurar que el color acento (`#8B4513`) se use explícitamente y que los colores de texto sean legibles.
        *   **`useMaterial3: true`**: Activa el sistema de diseño Material 3.
        *   **`appBarTheme`, `floatingActionButtonTheme`, `elevatedButtonTheme`, `textButtonTheme`**: Ejemplos de cómo puedes personalizar el tema de componentes específicos para que coincidan con tu estética de manuscrito.
    *   **`initialRoute: '/'`**: Especifica la ruta que se cargará cuando la aplicación se inicie. En este caso, es la ruta raíz que mapea a `WelcomeScreen`.
    *   **`routes: { ... }`**: Un mapa que asocia nombres de ruta (strings) con funciones que construyen los widgets de las pantallas correspondientes.
        *   `'/': (context) => const WelcomeScreen()`: La ruta raíz.
        *   `'/pomodoro': (context) => const PomodoroScreen()`: Ruta para la pantalla del temporizador.
        *   `'/settings': (context) => const SettingsScreen()`: Ruta para la pantalla de configuración.
        *   `'/statistics': (context) => const StatisticsScreen()`: Ruta para la pantalla de estadísticas.

Este archivo `main.dart` debería compilar sin errores y proporcionar la estructura base y el tema para tu "PomodoroManuscriptApp".