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
    // Definimos el color primario y el acento
    const Color primaryManuscriptColor = Color(0xFFF5F5DC); // Beige
    const Color accentManuscriptColor = Color(0xFF8B4513); // Marrón sepia

    return MaterialApp(
      title: 'Pomodoro Manuscript App',
      debugShowCheckedModeBanner: false, // Opcional: para quitar el banner de debug
      theme: ThemeData(
        useMaterial3: true,
        // Generamos un ColorScheme a partir del color primario (beige)
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryManuscriptColor,
          // Puedes ajustar otros colores si quieres que el acento sea más prominente
          // Por ejemplo, para que el color de acento influya en el 'secondary' o 'tertiary'
          // o usarlo directamente en widgets específicos.
          // Aquí, el seedColor es el principal generador.
          // Si quieres que el accentManuscriptColor sea el color de acento principal
          // de tu esquema, podrías asignarlo a 'secondary' o 'tertiary'.
          // Por simplicidad y siguiendo el requisito de fromSeed, lo dejamos así.
          // Si necesitas que el accentManuscriptColor sea el 'accent' del tema,
          // tendrías que configurarlo en widgets específicos o en un ThemeExtension.
        ).copyWith(
          // Opcional: Si quieres forzar el color de acento en el esquema
          // Esto sobrescribe el color 'secondary' generado por fromSeed
          secondary: accentManuscriptColor,
          // También puedes considerar primaryContainer, secondaryContainer, etc.
        ),
        // Puedes personalizar más el tema aquí, por ejemplo:
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryManuscriptColor,
          foregroundColor: accentManuscriptColor, // Color del texto y iconos en AppBar
          elevation: 0, // Sin sombra para un look más plano
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: accentManuscriptColor,
          foregroundColor: primaryManuscriptColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentManuscriptColor,
            foregroundColor: primaryManuscriptColor,
          ),
        ),
        // Otros ajustes de texto, etc., para la estética de manuscrito
        textTheme: const TextTheme(
          // Puedes cargar una fuente personalizada aquí si tienes una
          // Por ejemplo, para simular una fuente de máquina de escribir o manuscrita
          // bodyLarge: TextStyle(fontFamily: 'ManuscriptFont'),
          // bodyMedium: TextStyle(fontFamily: 'ManuscriptFont'),
        ),
      ),
      
      initialRoute: '/welcome', // La pantalla inicial es WelcomeScreen

      // Definición de las rutas nombradas para todas las pantallas
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/pomodoro': (context) => const PomodoroScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/statistics': (context) => const StatisticsScreen(),
      },
    );
  }
}

**Explicación y Notas:**

1.  **`void main()` y `runApp()`**: El punto de entrada de la aplicación, ejecutando `PomodoroManuscriptApp`.
2.  **Importaciones**: Todas las pantallas se importan desde `package:pomodoro_manuscript_app/presentation/screens/`. Asegúrate de que el nombre de tu proyecto sea `pomodoro_manuscript_app` en tu `pubspec.yaml` para que estas importaciones funcionen correctamente. Si tu proyecto tiene un nombre diferente, ajusta el prefijo del paquete.
3.  **`MaterialApp`**:
    *   `title`: Establecido como "Pomodoro Manuscript App".
    *   `debugShowCheckedModeBanner: false`: Opcional, pero útil para una apariencia más limpia en desarrollo.
    *   `theme`:
        *   `useMaterial3: true`: Habilitado como se solicitó.
        *   `colorScheme: ColorScheme.fromSeed(seedColor: primaryManuscriptColor)`: Genera un esquema de colores completo basado en el color beige (`#F5F5DC`).
        *   `.copyWith(secondary: accentManuscriptColor)`: Aunque `fromSeed` genera un esquema, a veces el color de acento deseado no se alinea perfectamente con los colores generados. Al usar `copyWith` y asignar `accentManuscriptColor` a `secondary`, nos aseguramos de que este color marrón esté disponible en el `ColorScheme` para widgets que usen `Theme.of(context).colorScheme.secondary`. Puedes ajustar qué propiedad del `ColorScheme` (e.g., `tertiary`, `error`, `surface`) se alinea mejor con tu intención para el color de acento.
        *   **Personalización adicional del tema**: He añadido ejemplos de `appBarTheme`, `floatingActionButtonTheme`, y `elevatedButtonTheme` para que los colores primario y de acento se apliquen directamente a elementos comunes, reforzando la estética de manuscrito. También hay un comentario sobre `textTheme` para fuentes personalizadas.
4.  **`initialRoute: '/welcome'`**: Establece `WelcomeScreen` como la primera pantalla que se muestra al iniciar la aplicación.
5.  **`routes`**: Un mapa que define todas las rutas nombradas. Cada clave es el nombre de la ruta (e.g., `'/pomodoro'`) y cada valor es una función que construye el widget de la pantalla correspondiente.
6.  **`const`**: Se han añadido `const` donde es posible para optimizaciones de rendimiento en Flutter.

Este archivo debería compilar sin errores, asumiendo que los archivos de pantalla (`welcomescreen.dart`, etc.) existen en las rutas especificadas y contienen clases `WelcomeScreen`, `PomodoroScreen`, etc., que extienden `StatelessWidget` o `StatefulWidget`.