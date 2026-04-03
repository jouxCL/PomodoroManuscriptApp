¡Claro que sí! Aquí tienes el archivo `main.dart` completo para tu "PomodoroManuscriptApp", siguiendo todos los requisitos especificados.

import 'package:flutter/material.dart';

// Importaciones de las pantallas desde la ruta especificada
import 'package:pomodoro_manuscript_app/presentation/screens/welcomescreen.dart';
import 'package:pomodoro_manuscript_app/presentation/screens/pomodoroscreen.dart';
import 'package:pomodoro_manuscript_app/presentation/screens/settingsscreen.dart';
import 'package:pomodoro_manuscript_app/presentation/screens/statisticsscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título de la aplicación, visible en el selector de tareas del dispositivo
      title: 'PomodoroManuscriptApp',

      // Configuración del tema de la aplicación
      theme: ThemeData(
        // Habilita Material 3
        useMaterial3: true,
        // Define el esquema de colores a partir de un color semilla (beige)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF5F5DC), // Color primario: Beige
          // Aquí podrías personalizar más colores si lo deseas,
          // por ejemplo, para incorporar el color accent #8B4513
          // como secondary, tertiary, o para el tema de widgets específicos.
          // Ejemplo: secondary: const Color(0xFF8B4513),
        ),
        // Puedes añadir más personalizaciones de tema aquí,
        // por ejemplo, para el color accent en botones, AppBar, etc.
        // Ejemplo para el color accent en botones elevados:
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B4513), // Color accent: Marrón
            foregroundColor: Colors.white, // Color del texto en el botón
          ),
        ),
        // Ejemplo para el color accent en FloatingActionButton:
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF8B4513), // Color accent: Marrón
          foregroundColor: Colors.white,
        ),
        // Ejemplo para el texto con un estilo de manuscrito (requeriría una fuente personalizada)
        // textTheme: const TextTheme(
        //   bodyLarge: TextStyle(fontFamily: 'ManuscriptFont', color: Colors.black87),
        //   bodyMedium: TextStyle(fontFamily: 'ManuscriptFont', color: Colors.black87),
        //   // ... y otros estilos de texto
        // ),
      ),

      // Define la ruta inicial de la aplicación
      initialRoute: '/',

      // Define las rutas nombradas para las diferentes pantallas
      routes: {
        '/': (context) => const WelcomeScreen(), // Pantalla de bienvenida como ruta raíz
        '/welcome': (context) => const WelcomeScreen(),
        '/pomodoro': (context) => const PomodoroScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/statistics': (context) => const StatisticsScreen(),
      },
    );
  }
}

**Explicación de los puntos clave:**

1.  **`import 'package:flutter/material.dart';`**: La importación estándar para cualquier aplicación Flutter.
2.  **Importaciones de Pantallas**: Se importan todas las pantallas desde la ruta `package:pomodoro_manuscript_app/presentation/screens/` como se solicitó. Asegúrate de que el nombre del paquete (`pomodoro_manuscript_app`) coincida con el `name:` en tu archivo `pubspec.yaml`.
3.  **`void main() => runApp(const MyApp());`**: El punto de entrada de la aplicación, que ejecuta el widget raíz `MyApp`.
4.  **`class MyApp extends StatelessWidget`**: El widget raíz de la aplicación.
5.  **`MaterialApp`**:
    *   **`title`**: Establecido como "PomodoroManuscriptApp".
    *   **`theme`**:
        *   **`useMaterial3: true`**: Habilita el diseño de Material 3.
        *   **`colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5F5DC))`**: Crea un esquema de colores basado en el color beige (`#F5F5DC`) como color semilla. Esto generará automáticamente un conjunto coherente de colores primarios, secundarios, de fondo, etc., derivados del beige.
        *   **Comentarios sobre el `accent color`**: He añadido comentarios y ejemplos de cómo podrías integrar el color accent (`#8B4513`) en el tema para widgets específicos como `ElevatedButton` o `FloatingActionButton`, ya que `ColorScheme.fromSeed` no lo usa directamente como una "semilla" para todo el esquema, sino que lo generaría a partir del beige. Si quieres que el marrón sea un color secundario principal, podrías especificarlo directamente en `ColorScheme` o en temas de widgets.
    *   **`initialRoute: '/'`**: Establece la `WelcomeScreen` como la pantalla que se muestra al iniciar la aplicación.
    *   **`routes`**: Un mapa que asocia nombres de ruta (`String`) con funciones que construyen los widgets de las pantallas (`WidgetBuilder`). Todas las pantallas solicitadas están incluidas con rutas claras y descriptivas.

Este archivo debería compilar sin errores, asumiendo que los archivos de pantalla (`welcomescreen.dart`, etc.) existen en las rutas especificadas y contienen un widget `StatelessWidget` o `StatefulWidget` con el nombre de clase correspondiente.