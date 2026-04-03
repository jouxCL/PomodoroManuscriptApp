¡Excelente! Aquí tienes el archivo `main.dart` completo para tu "PomodoroManuscriptApp", siguiendo todos los requisitos.

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
    // Definimos el color primario y el color de acento
    // El color primario se usará como seedColor para generar el ColorScheme.
    // El color de acento (#8B4513 - Saddle Brown) se puede integrar
    // más específicamente en el tema si se desea que afecte a elementos
    // como botones flotantes, texto de acento, etc., más allá de lo que
    // genera automáticamente ColorScheme.fromSeed.
    const Color primaryManuscriptColor = Color(0xFFF5F5DC); // Beige
    const Color accentManuscriptColor = Color(0xFF8B4513); // Saddle Brown

    return MaterialApp(
      title: 'PomodoroManuscriptApp',
      // Habilitar Material 3
      useMaterial3: true,
      theme: ThemeData(
        useMaterial3: true,
        // Generar un ColorScheme a partir del color beige principal.
        // Esto creará una paleta de colores coherente basada en el beige.
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryManuscriptColor,
          // Opcionalmente, puedes ajustar colores específicos si ColorScheme.fromSeed
          // no genera el acento deseado para ciertos elementos.
          // Por ejemplo:
          // primary: primaryManuscriptColor,
          // secondary: accentManuscriptColor, // Podría usarse para elementos secundarios
          // tertiary: accentManuscriptColor, // O para elementos terciarios
          // Puedes personalizar más aquí si es necesario.
        ).copyWith(
          // Si quieres que el color de acento sea explícitamente el 'secondary' o 'tertiary'
          // del ColorScheme, puedes usar copyWith.
          // Por ejemplo, para que el color de acento sea el color secundario:
          secondary: accentManuscriptColor,
          // O para que sea el color de acento para FloatingActionButtons, etc.
          // Puedes ajustar según cómo quieras que se manifieste el acento.
        ),
        // Puedes personalizar más el tema aquí, por ejemplo, para fuentes,
        // estilos de texto, botones, etc., para reforzar la estética de manuscrito.
        // Por ejemplo, para un FloatingActionButton que use el color de acento:
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: accentManuscriptColor,
          foregroundColor: Colors.white, // Color del icono/texto en el FAB
        ),
        // Ejemplo de personalización de texto para una fuente que simule escritura a mano
        // textTheme: const TextTheme(
        //   bodyLarge: TextStyle(fontFamily: 'ManuscriptFont'), // Necesitarías importar una fuente
        //   bodyMedium: TextStyle(fontFamily: 'ManuscriptFont'),
        // ),
      ),

      // Definir la pantalla inicial de la aplicación
      initialRoute: '/',

      // Definir las rutas nombradas para todas las pantallas
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/pomodoro': (context) => const PomodoroScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/statistics': (context) => const StatisticsScreen(),
      },
    );
  }
}

**Explicación y Consideraciones Adicionales:**

1.  **`main()` y `runApp()`**: El punto de entrada estándar de cualquier aplicación Flutter.
2.  **`PomodoroManuscriptApp` (Widget Raíz)**: Un `StatelessWidget` que envuelve toda la aplicación.
3.  **`MaterialApp`**:
    *   `title`: El título de la aplicación que se muestra en el selector de tareas del sistema operativo.
    *   `useMaterial3: true`: Activa el diseño de Material Design 3.
    *   `theme`:
        *   `ThemeData(useMaterial3: true, ...)`: Configura el tema de la aplicación.
        *   `colorScheme: ColorScheme.fromSeed(seedColor: primaryManuscriptColor)`: Esta es la forma recomendada en Material 3 para generar una paleta de colores coherente. Toma tu `primaryManuscriptColor` (beige) como base y genera automáticamente colores para `primary`, `secondary`, `tertiary`, `surface`, `background`, etc.
        *   `.copyWith(secondary: accentManuscriptColor)`: Aunque `fromSeed` genera un `ColorScheme` completo, a veces quieres asegurarte de que un color específico (como tu color de acento `#8B4513`) se use para un rol particular. Aquí, lo asignamos al rol `secondary` del `ColorScheme`. Esto significa que los widgets que por defecto usan el color secundario del tema (como algunos `FloatingActionButton`s o `Switch`es) adoptarán este color.
        *   `floatingActionButtonTheme`: Un ejemplo de cómo podrías personalizar un widget específico para usar tu color de acento, si el `ColorScheme` por sí solo no lo aplica donde deseas.
    *   `initialRoute: '/'`: Establece `WelcomeScreen` como la primera pantalla que se muestra al iniciar la app.
    *   `routes`: Un mapa que asocia nombres de ruta (`String`) con funciones que construyen los widgets de las pantallas (`WidgetBuilder`). Esto permite la navegación usando `Navigator.pushNamed()`.
4.  **Importaciones**: Todas las pantallas se importan correctamente desde `package:pomodoro_manuscript_app/presentation/screens/`. Asegúrate de que la estructura de carpetas sea exactamente `lib/presentation/screens/`.
5.  **`const`**: Se usa `const` donde es posible para optimizaciones de rendimiento en Flutter.

Este `main.dart` te proporciona una base sólida y funcional para tu "PomodoroManuscriptApp" con la estética y requisitos especificados.