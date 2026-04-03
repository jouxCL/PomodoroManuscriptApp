¡Excelente! Aquí tienes el archivo `main.dart` completo para tu "PomodoroManuscriptApp", siguiendo todos los requisitos especificados.

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

  // Definición de las rutas nombradas como constantes estáticas
  static const String welcomeRoute = '/'; // La pantalla de bienvenida será la ruta inicial
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
        useMaterial3: true,
        // Color primario: #F5F5DC (Beige)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF5F5DC), // Color primario beige
          // Puedes ajustar otros colores del esquema si es necesario,
          // por ejemplo, para incorporar el color accent #8B4513 (Marrón)
          // como secondary o tertiary.
          // Por defecto, fromSeed generará un esquema completo basado en el seed.
          // Si quieres forzar el accent, podrías hacer algo como:
          // secondary: const Color(0xFF8B4513),
          // tertiary: const Color(0xFF8B4513),
        ),
        // Puedes definir un color de acento explícito si no quieres depender
        // completamente de ColorScheme.fromSeed para el accent.
        // Por ejemplo, para usarlo en botones o iconos específicos.
        // accentColor: const Color(0xFF8B4513), // Nota: accentColor está deprecado en Material 3,
                                             // se prefiere usar colorScheme.secondary/tertiary.
                                             // Lo dejo comentado para referencia si lo necesitas.
      ),

      // Configuración de las rutas nombradas
      initialRoute: welcomeRoute, // Establece WelcomeScreen como la pantalla inicial
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

1.  **`void main()` y `runApp()`**: El punto de entrada estándar de cualquier aplicación Flutter, que inicia la ejecución de `PomodoroManuscriptApp`.
2.  **Importaciones**: Se importan todas las pantallas desde la ruta `lib/presentation/screens/` como se solicitó. Asegúrate de que los nombres de archivo (`welcomescreen.dart`, etc.) coincidan exactamente con los nombres de las clases y archivos reales.
3.  **`PomodoroManuscriptApp` (StatelessWidget)**: La clase principal de la aplicación que extiende `StatelessWidget`, ya que el estado principal de la aplicación (rutas, tema) no cambia.
4.  **Rutas Nombradas Estáticas**: Se definen constantes estáticas para los nombres de las rutas (`welcomeRoute`, `pomodoroRoute`, etc.). Esto ayuda a evitar errores tipográficos y hace que el código sea más legible y fácil de mantener.
5.  **`MaterialApp`**: El widget raíz de la aplicación que proporciona la estructura de Material Design.
    *   `title`: El título de la aplicación que se muestra en el selector de tareas del dispositivo.
    *   `debugShowCheckedModeBanner: false`: Opcional, pero comúnmente usado para ocultar la etiqueta "DEBUG" en la esquina superior derecha.
    *   **`theme`**:
        *   `useMaterial3: true`: Habilita las características de Material Design 3.
        *   `colorScheme: ColorScheme.fromSeed(...)`: Genera un esquema de colores completo basado en un `seedColor`. Se usa `Color(0xFFF5F5DC)` (beige) como el color semilla, que es el color primario solicitado. `ColorScheme.fromSeed` es la forma recomendada en Material 3 para definir la paleta de colores.
        *   **Nota sobre `accentColor`**: En Material 3, `accentColor` está deprecado. Se espera que uses los colores generados por `ColorScheme` (como `colorScheme.primary`, `colorScheme.secondary`, `colorScheme.tertiary`, etc.) para tus widgets. Si necesitas usar el color `#8B4513` (marrón) como un color de acento específico, podrías asignarlo directamente a `secondary` o `tertiary` en `ColorScheme.fromSeed` o usarlo directamente en los estilos de tus widgets (ej. `ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary)`).
    *   **`initialRoute`**: Se establece `welcomeRoute` (que es '/') como la ruta inicial, asegurando que `WelcomeScreen` sea la primera pantalla que se muestre.
    *   **`routes`**: Un mapa que asocia los nombres de las rutas con las funciones que construyen los widgets de cada pantalla.

Este `main.dart` debería compilar sin problemas y proporcionar la estructura base para tu "PomodoroManuscriptApp".