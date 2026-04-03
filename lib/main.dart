¡Claro! Aquí tienes el archivo `main.dart` completo para tu "PomodoroManuscriptApp", siguiendo todos los requisitos especificados.

import 'package:flutter/material.dart';

// Importaciones de las pantallas disponibles
// Asegúrate de que el nombre del paquete 'pomodoro_manuscript_app' coincida con el de tu proyecto.
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
      title: 'Pomodoro Manuscript App', // Título de la aplicación
      
      // Configuración del tema de la aplicación
      theme: ThemeData(
        // Genera un ColorScheme basado en el color semilla #F5F5DC (Beige)
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5F5DC)),
        // Habilita Material 3
        useMaterial3: true,
        
        // Opcional: Puedes personalizar más el tema aquí si es necesario,
        // por ejemplo, para asegurar que el color accent (#8B4513) se use
        // en widgets específicos o para definir un textTheme.
        // Por ejemplo, para un botón flotante con el color accent:
        // floatingActionButtonTheme: FloatingActionButtonThemeData(
        //   backgroundColor: const Color(0xFF8B4513),
        //   foregroundColor: Colors.white,
        // ),
        // appBarTheme: AppBarTheme(
        //   backgroundColor: const Color(0xFFF5F5DC),
        //   foregroundColor: const Color(0xFF8B4513), // Color del texto/iconos de la AppBar
        //   elevation: 0,
        // ),
      ),
      
      // La pantalla inicial de la aplicación
      initialRoute: '/welcome', 
      
      // Definición de rutas nombradas para todas las pantallas
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/pomodoro': (context) => const PomodoroScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/statistics': (context) => const StatisticsScreen(),
      },

      // Opcional: Quitar el banner de "Debug" en la esquina superior derecha
      debugShowCheckedModeBanner: false,
    );
  }
}