¡Claro que sí! Aquí tienes el archivo `main.dart` completo para tu "PomodoroManuscriptApp", siguiendo todos los requisitos especificados.

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
    // Definimos el color primario y el acento
    const Color primaryManuscriptColor = Color(0xFFF5F5DC); // Beige
    // const Color accentManuscriptColor = Color(0xFF8B4513); // Marrón (no se usa directamente en fromSeed, pero se puede usar en el tema)

    return MaterialApp(
      title: 'Pomodoro Manuscript App',
      // Habilitar Material 3
      useMaterial3: true,
      theme: ThemeData(
        useMaterial3: true,
        // Generar un ColorScheme basado en el color primario beige
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryManuscriptColor,
          // Puedes personalizar más el esquema si lo deseas, por ejemplo:
          // primary: primaryManuscriptColor,
          // secondary: accentManuscriptColor,
          // tertiary: accentManuscriptColor,
          // surface: primaryManuscriptColor,
          // background: primaryManuscriptColor,
        ),
        // Opcional: Puedes ajustar otras propiedades del tema aquí
        // Por ejemplo, para un estilo más "manuscrito":
        fontFamily: 'RobotoSerif', // Asumiendo que tienes una fuente serif en tu pubspec.yaml
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryManuscriptColor,
          foregroundColor: Color(0xFF8B4513), // Color del texto del AppBar
          elevation: 0, // Sin sombra para un look más plano
        ),
        scaffoldBackgroundColor: primaryManuscriptColor, // Fondo de todas las pantallas
        // Otros ajustes de tema como textTheme, buttonTheme, etc.
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

1.  **`void main()` y `runApp()`**: El punto de entrada estándar de cualquier aplicación Flutter, que ejecuta el widget raíz `PomodoroManuscriptApp`.
2.  **Importaciones**: Se importan `material.dart` y cada una de las pantallas desde la ruta `package:pomodoro_manuscript_app/presentation/screens/`. Asegúrate de que `pomodoro_manuscript_app` sea el nombre de tu paquete definido en `pubspec.yaml`.
3.  **`PomodoroManuscriptApp` (Widget Raíz)**: Es un `StatelessWidget` que contiene la configuración principal de la aplicación.
4.  **`MaterialApp`**:
    *   `title`: El título que se muestra en el selector de tareas del sistema operativo.
    *   `useMaterial3: true`: Habilita el diseño de Material 3, como se solicitó.
    *   `theme`:
        *   `ThemeData(useMaterial3: true, ...)`: Define el tema visual de la aplicación.
        *   `colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5F5DC))`: Genera un esquema de colores completo basado en el color beige (`#F5F5DC`) como color semilla. Esto asegura que todos los colores del Material Design (primario, secundario, de superficie, de error, etc.) estén armonizados con tu color principal.
        *   **Nota sobre el color accent**: El color `#8B4513` (marrón) se menciona como "accent". `ColorScheme.fromSeed` no toma un color de acento directamente. Sin embargo, el esquema generado por `fromSeed` incluirá colores secundarios y terciarios que puedes usar. Si quisieras forzar el color marrón como `secondary` o `tertiary`, tendrías que sobrescribir esas propiedades en el `ColorScheme` después de `fromSeed`, o directamente en los widgets. He añadido algunos comentarios en el código para mostrar cómo podrías empezar a personalizar más el tema para la estética de manuscrito.
    *   `initialRoute: '/'`: Establece la ruta inicial de la aplicación, que en este caso es la `WelcomeScreen`.
    *   `routes`: Un mapa que asocia nombres de ruta (`String`) con funciones `WidgetBuilder` que construyen la pantalla correspondiente. Cada pantalla se instancia con `const` para optimizar el rendimiento, asumiendo que son widgets `const`.

Este archivo `main.dart` debería compilar sin errores y proporcionar la estructura base y el tema de tu aplicación Pomodoro.