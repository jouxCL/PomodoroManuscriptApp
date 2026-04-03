¡Claro! Aquí tienes el archivo `main.dart` completo para tu "PomodoroManuscriptApp", siguiendo todas tus especificaciones.

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

  // Definición de las rutas nombradas para la aplicación
  static const String welcomeRoute = '/'; // Pantalla inicial
  static const String pomodoroRoute = '/pomodoro';
  static const String settingsRoute = '/settings';
  static const String statisticsRoute = '/statistics';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Manuscript App',
      debugShowCheckedModeBanner: false, // Opcional: para quitar el banner de debug

      // Configuración del tema de la aplicación
      theme: ThemeData(
        // Color primario: #F5F5DC (Beige)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF5F5DC), // Color principal para generar la paleta
          // Puedes personalizar más colores si lo deseas, por ejemplo:
          // primary: const Color(0xFFF5F5DC),
          // secondary: const Color(0xFF8B4513), // Color accent: #8B4513 (Marrón)
          // tertiary: const Color(0xFF8B4513), // Usar el accent como terciario también
          // surface: const Color(0xFFF5F5DC), // Fondo de superficies
          // onPrimary: Colors.black87, // Color del texto sobre el color primario
          // onSecondary: Colors.white, // Color del texto sobre el color secundario
        ),
        useMaterial3: true, // Habilitar Material Design 3
        
        // Puedes añadir más personalizaciones de texto, botones, etc. aquí
        // Por ejemplo, para una estética de manuscrito, podrías definir una fuente específica:
        // textTheme: GoogleFonts.merriweatherTextTheme(Theme.of(context).textTheme),
        // (requeriría importar 'package:google_fonts/google_fonts.dart')
      ),

      // Definición de la ruta inicial y las rutas nombradas
      initialRoute: welcomeRoute,
      routes: {
        welcomeRoute: (context) => const WelcomeScreen(),
        pomodoroRoute: (context) => const PomodoroScreen(),
        settingsRoute: (context) => const SettingsScreen(),
        statisticsRoute: (context) => const StatisticsScreen(),
      },
    );
  }
}

**Explicación de los puntos clave:**

1.  **`import 'package:flutter/material.dart';`**: La importación estándar para cualquier aplicación Flutter.
2.  **Importaciones de pantallas**: Se importan todas las pantallas desde sus respectivas rutas dentro de `lib/presentation/screens/`. Asegúrate de que los nombres de archivo (`welcomescreen.dart`, `pomodoroscreen.dart`, etc.) coincidan exactamente.
3.  **`void main() { runApp(const PomodoroManuscriptApp()); }`**: El punto de entrada de la aplicación, que ejecuta el widget raíz `PomodoroManuscriptApp`.
4.  **`class PomodoroManuscriptApp extends StatelessWidget`**: El widget raíz de tu aplicación.
5.  **Rutas Nombradas**:
    *   Se definen constantes estáticas (`welcomeRoute`, `pomodoroRoute`, etc.) para las rutas. Esto ayuda a evitar errores de escritura y hace el código más legible.
    *   `initialRoute: welcomeRoute,` establece `WelcomeScreen` como la primera pantalla que se muestra al iniciar la app.
    *   El mapa `routes:` asocia cada nombre de ruta con el widget de la pantalla correspondiente.
6.  **Theming (`ThemeData`)**:
    *   `title: 'Pomodoro Manuscript App'`: El título que puede aparecer en el gestor de tareas del dispositivo.
    *   `debugShowCheckedModeBanner: false`: Opcional, para ocultar la etiqueta "DEBUG" en la esquina superior derecha.
    *   `useMaterial3: true`: Habilita las características y el diseño de Material Design 3.
    *   `colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5F5DC))`: Esta es la parte clave para tu estética.
        *   `seedColor` es el color principal (`#F5F5DC` - beige) a partir del cual Material 3 genera una paleta de colores completa y armoniosa (primario, secundario, terciario, de error, de superficie, y sus variantes "on").
        *   Aunque el color accent `#8B4513` se menciona, `ColorScheme.fromSeed` lo incorporará de forma inteligente en la paleta generada. Si quisieras forzarlo a ser, por ejemplo, el `secondary` o `tertiary` color, podrías descomentar las líneas de `primary`, `secondary`, etc., y asignarlos explícitamente. Sin embargo, para empezar, `fromSeed` es suficiente y recomendado.

Este `main.dart` debería compilar sin errores y proporcionar la estructura base y el tema visual que deseas para tu aplicación.