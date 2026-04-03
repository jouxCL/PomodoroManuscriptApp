¡Claro que sí! Aquí tienes el archivo `main.dart` completo para tu aplicación "PomodoroManuscriptApp", siguiendo todos los requisitos especificados.

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
    // Definimos el color primario como un Color de Dart
    const Color primaryManuscriptColor = Color(0xFFF5F5DC); // #F5F5DC (Beige)
    // El color accent se podría usar para elementos específicos, pero ColorScheme.fromSeed
    // generará una paleta completa basada en el seedColor.
    // const Color accentManuscriptColor = Color(0xFF8B4513); // #8B4513 (Marrón tierra)

    return MaterialApp(
      title: 'PomodoroManuscriptApp',
      debugShowCheckedModeBanner: false, // Opcional: para quitar el banner de "DEBUG"

      theme: ThemeData(
        useMaterial3: true,
        // Generamos un ColorScheme basado en el color beige del manuscrito
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryManuscriptColor,
          // Puedes ajustar otros colores si quieres un control más fino
          // por ejemplo:
          // primary: primaryManuscriptColor,
          // secondary: accentManuscriptColor,
          // tertiary: Colors.brown.shade700,
          // surface: primaryManuscriptColor,
          // background: primaryManuscriptColor,
        ),
        // Aquí podrías añadir más personalizaciones de tema si lo deseas,
        // como fuentes, temas de AppBar, etc., para reforzar la estética de manuscrito.
        // Por ejemplo:
        // textTheme: GoogleFonts.merriweatherTextTheme(Theme.of(context).textTheme),
        // appBarTheme: AppBarTheme(
        //   backgroundColor: primaryManuscriptColor,
        //   foregroundColor: accentManuscriptColor,
        //   elevation: 0,
        // ),
      ),

      // Pantalla inicial de la aplicación
      initialRoute: '/',

      // Rutas nombradas para todas las pantallas
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/pomodoro': (context) => const PomodoroScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/statistics': (context) => const StatisticsScreen(),
      },
    );
  }
}

**Explicación de los puntos clave:**

1.  **`void main()` y `runApp()`**: Configura el punto de entrada de la aplicación.
2.  **`MaterialApp`**: El widget raíz de tu aplicación Flutter, que proporciona la funcionalidad de Material Design.
3.  **`title`**: El título que se muestra en el selector de tareas del sistema operativo.
4.  **`debugShowCheckedModeBanner: false`**: Una opción útil para ocultar el banner de "DEBUG" que aparece en la esquina superior derecha durante el desarrollo.
5.  **`theme: ThemeData(...)`**:
    *   `useMaterial3: true`: Habilita el diseño de Material 3.
    *   `colorScheme: ColorScheme.fromSeed(seedColor: primaryManuscriptColor)`: Genera una paleta de colores completa (incluyendo primario, secundario, de superficie, de fondo, etc.) basada en el `seedColor` proporcionado (`#F5F5DC`). Esto asegura que todos los componentes de Material 3 utilicen colores que armonicen con tu color primario.
6.  **`initialRoute: '/'`**: Establece `WelcomeScreen` como la pantalla que se muestra al iniciar la aplicación.
7.  **`routes: { ... }`**: Define un mapa de rutas nombradas. Cada clave es el nombre de la ruta (un `String`) y cada valor es una función `WidgetBuilder` que construye la pantalla correspondiente.
8.  **Importaciones**: Las importaciones de las pantallas están correctamente definidas asumiendo que el nombre de tu proyecto es `pomodoro_manuscript_app`. Si tu proyecto tiene un nombre diferente, deberás ajustar la primera parte de la ruta del paquete (ej. `package:tu_nombre_de_proyecto/presentation/screens/...`).

Este `main.dart` es un punto de partida sólido y cumple con todos tus requisitos. ¡Ahora puedes empezar a construir el contenido de cada una de tus pantallas!