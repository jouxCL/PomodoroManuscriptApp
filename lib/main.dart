¡Excelente! Aquí tienes el archivo `main.dart` completo para tu "PomodoroManuscriptApp", siguiendo todos los requisitos especificados.

import 'package:flutter/material.dart';

// Importaciones de las pantallas desde 'presentation/screens/'
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
    // Definimos el color primario y el color de acento
    // El color primario se usa como seedColor para generar el ColorScheme completo.
    // El color de acento (#8B4513) será parte de la paleta generada,
    // o se puede usar directamente para widgets específicos si se desea.
    const Color primaryManuscriptColor = Color(0xFFF5F5DC); // Beige
    // const Color accentManuscriptColor = Color(0xFF8B4513); // Marrón oscuro

    return MaterialApp(
      title: 'PomodoroManuscriptApp',
      // Habilitar Material 3 y configurar el tema
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryManuscriptColor,
          // Puedes ajustar otros colores aquí si es necesario,
          // por ejemplo, para asegurar que el acento sea exactamente el deseado.
          // primary: primaryManuscriptColor,
          // secondary: accentManuscriptColor, // Podrías forzar el color de acento aquí
          // tertiary: accentManuscriptColor,
        ),
        // Opcional: Si quieres un color de fondo general para la app que sea el beige
        scaffoldBackgroundColor: primaryManuscriptColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryManuscriptColor, // Fondo de AppBar beige
          foregroundColor: Color(0xFF8B4513), // Texto e iconos de AppBar marrón
        ),
        // Otros ajustes de tema para la estética de manuscrito
        // Por ejemplo, un estilo de texto que simule una fuente de máquina de escribir o manuscrita
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          displayMedium: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          displaySmall: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          headlineLarge: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          headlineMedium: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          headlineSmall: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          titleLarge: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          titleMedium: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          titleSmall: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          bodyLarge: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          bodyMedium: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          bodySmall: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          labelLarge: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          labelMedium: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
          labelSmall: TextStyle(fontFamily: 'Cursive', color: Color(0xFF8B4513)),
        ),
      ),
      
      // La pantalla inicial de la aplicación
      initialRoute: '/', 

      // Definición de las rutas nombradas para todas las pantallas
      routes: {
        '/': (context) => const WelcomeScreen(), // WelcomeScreen como pantalla inicial
        '/pomodoro': (context) => const PomodoroScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/statistics': (context) => const StatisticsScreen(),
      },
    );
  }
}

**Explicación y Notas Adicionales:**

1.  **`void main()` y `runApp()`**: El punto de entrada estándar de cualquier aplicación Flutter.
2.  **`MaterialApp`**: El widget raíz que configura la aplicación, incluyendo el título, el tema y las rutas.
3.  **`title`**: Establecido como "PomodoroManuscriptApp".
4.  **`theme`**:
    *   `useMaterial3: true`: Habilita el diseño de Material 3.
    *   `colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5F5DC))`: Genera un esquema de colores completo basado en el color beige (`#F5F5DC`) que proporcionaste como color primario. Flutter intentará generar una paleta armoniosa a partir de este color.
    *   `scaffoldBackgroundColor: primaryManuscriptColor`: Establece el color de fondo predeterminado para todos los `Scaffold` de la aplicación al beige, reforzando la estética de "papel".
    *   `appBarTheme`: Configura el color de fondo y el color de los elementos (texto, iconos) de la `AppBar` para que coincidan con la estética.
    *   `textTheme`: He añadido un ejemplo de cómo podrías empezar a aplicar una fuente personalizada (`Cursive` es un ejemplo, necesitarías añadir una fuente real a tu `pubspec.yaml` y assets) y el color marrón (`#8B4513`) a todo el texto de la aplicación para simular la tinta.
5.  **`initialRoute: '/'`**: Define que la `WelcomeScreen` será la primera pantalla que se muestre al iniciar la aplicación.
6.  **`routes`**: Un mapa que asocia nombres de ruta (`String`) con funciones `WidgetBuilder` que construyen la pantalla correspondiente.
    *   `'/': (context) => const WelcomeScreen()`: La ruta raíz apunta a `WelcomeScreen`.
    *   `/pomodoro`, `/settings`, `/statistics`: Rutas nombradas para las otras pantallas.
7.  **Importaciones**: Todas las pantallas se importan correctamente desde `package:pomodoro_manuscript_app/presentation/screens/`. Asegúrate de que el nombre de tu paquete sea `pomodoro_manuscript_app` en tu `pubspec.yaml`.
8.  **`const`**: Se ha utilizado `const` donde es posible para optimizaciones de rendimiento.

Para que este código funcione completamente, asegúrate de que:
*   Las pantallas `welcomescreen.dart`, `pomodoroscreen.dart`, `settingsscreen.dart`, `statisticsscreen.dart` existan en `lib/presentation/screens/` y contengan al menos un `StatelessWidget` o `StatefulWidget` con el nombre de clase correspondiente (ej. `WelcomeScreen`).
*   Si deseas usar una fuente personalizada como la sugerida en `textTheme`, debes añadirla a tu proyecto (en `pubspec.yaml` y en la carpeta `assets/fonts`).