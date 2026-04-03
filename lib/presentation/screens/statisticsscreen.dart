Aquí tienes el código Dart completo y funcional para la pantalla `StatisticsScreen`, diseñado con la estética de manuscrito en papel beige y tipografía que simula Times New Roman, siguiendo todos tus requisitos.

import 'package:flutter/material.dart';

/// La pantalla StatisticsScreen muestra las estadísticas de productividad del usuario.
/// Adopta una estética de manuscrito en papel beige con texto que simula tinta.
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  // --- Datos de ejemplo para las estadísticas ---
  // En una aplicación real, estos datos provendrían de un sistema de gestión de estado
  // (como Provider, Riverpod, BLoC) o de una base de datos/preferencias compartidas.
  // Se inicializarían en 0 y se actualizarían a medida que el usuario usa la app.
  final int completedPomodoros = 25;
  final int shortBreaksTaken = 18;
  final int longBreaksTaken = 6;
  final Duration totalFocusTime = const Duration(hours: 10, minutes: 25);

  @override
  Widget build(BuildContext context) {
    // --- Definición de colores principales de la aplicación ---
    final Color primaryColor = const Color(0xFFF5F5DC); // Color beige del papel
    final Color accentColor = const Color(0xFF8B4513); // Color marrón oscuro, como tinta

    // --- Estilos de texto para la estética de manuscrito ---
    // Para usar la tipografía "Times New Roman" de forma nativa y consistente,
    // se debería integrar un archivo de fuente personalizado (.ttf) en el proyecto.
    // Pasos de ejemplo:
    // 1. Colocar el archivo de fuente (ej. 'times_new_roman.ttf') en 'assets/fonts/'.
    // 2. Declarar la fuente en el archivo 'pubspec.yaml' bajo la sección 'flutter':
    //    flutter:
    //      fonts:
    //        - family: Times New Roman
    //          fonts:
    //            - asset: assets/fonts/times_new_roman.ttf
    // 3. Luego, usar: TextStyle(fontFamily: 'Times New Roman', ...)
    //
    // Para este ejemplo, usamos 'serif' como un marcador de posición que intentará
    // usar una fuente serif del sistema o la definida en el tema principal de MaterialApp.
    final TextStyle manuscriptBaseStyle = TextStyle(
      fontFamily: 'serif', // Placeholder para Times New Roman o una fuente serif similar
      color: accentColor,
      fontSize: 16,
      height: 1.5, // Altura de línea para mejorar la legibilidad, como en un manuscrito
    );

    final TextStyle titleTextStyle = manuscriptBaseStyle.copyWith(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: accentColor,
    );

    final TextStyle subTitleStyle = manuscriptBaseStyle.copyWith(
      fontSize: 18,
      fontStyle: FontStyle.italic,
      color: accentColor.withOpacity(0.8),
    );

    final TextStyle statLabelStyle = manuscriptBaseStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: accentColor.withOpacity(0.9),
    );

    final TextStyle statValueStyle = manuscriptBaseStyle.copyWith(
      fontSize: 28, // Tamaño más grande para enfatizar el valor
      fontWeight: FontWeight.bold,
      color: accentColor,
    );
    // --- Fin de Estilos de Texto ---

    return Scaffold(
      backgroundColor: primaryColor, // Fondo color beige del papel
      appBar: AppBar(
        title: Text(
          'Tus Estadísticas',
          style: titleTextStyle,
        ),
        backgroundColor: primaryColor,
        foregroundColor: accentColor, // Color de tinta para iconos y texto de la AppBar
        elevation: 0, // AppBar plana para integrarse con la estética del papel
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Un vistazo a tu progreso en el Pomodoro',
              textAlign: TextAlign.center,
              style: subTitleStyle,
            ),
            const SizedBox(height: 30),
            // Tarjeta para "Pomodoros Completados"
            _buildStatCard(
              context,
              label: 'Pomodoros Completados',
              value: '$completedPomodoros',
              labelStyle: statLabelStyle,
              valueStyle: statValueStyle,
              accentColor: accentColor,
            ),
            const SizedBox(height: 20),
            // Tarjeta para "Descansos Cortos Tomados"
            _buildStatCard(
              context,
              label: 'Descansos Cortos Tomados',
              value: '$shortBreaksTaken',
              labelStyle: statLabelStyle,
              valueStyle: statValueStyle,
              accentColor: accentColor,
            ),
            const SizedBox(height: 20),
            // Tarjeta para "Descansos Largos Tomados"
            _buildStatCard(
              context,
              label: 'Descansos Largos Tomados',
              value: '$longBreaksTaken',
              labelStyle: statLabelStyle,
              valueStyle: statValueStyle,
              accentColor: accentColor,
            ),
            const SizedBox(height: 20),
            // Tarjeta para "Tiempo Total Enfocado"
            _buildStatCard(
              context,
              label: 'Tiempo Total Enfocado',
              value: '${totalFocusTime.inHours}h ${totalFocusTime.inMinutes.remainder(60)}m',
              labelStyle: statLabelStyle,
              valueStyle: statValueStyle,
              accentColor: accentColor,
            ),
            const SizedBox(height: 40),
            // Botón para reiniciar estadísticas
            ElevatedButton(
              onPressed: () {
                // En una aplicación real, esta acción dispararía una lógica
                // para reiniciar las estadísticas en el almacenamiento de datos subyacente.
                // Para este ejemplo, solo mostraremos un mensaje de confirmación.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Estadísticas reiniciadas (simulado).',
                      style: manuscriptBaseStyle.copyWith(color: primaryColor), // Texto en color papel
                    ),
                    backgroundColor: accentColor, // Fondo del SnackBar en color tinta
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor, // Fondo del botón en color tinta
                foregroundColor: primaryColor, // Color del texto del botón en color papel
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: accentColor.withOpacity(0.7), width: 2), // Borde sutil de tinta
                ),
                textStyle: manuscriptBaseStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor, // Asegurar que el color del texto se aplique correctamente
                ),
              ),
              child: const Text('Reiniciar Estadísticas'),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget auxiliar para construir tarjetas individuales de estadísticas.
  Widget _buildStatCard(
    BuildContext context, {
    required String label,
    required String value,
    required TextStyle labelStyle,
    required TextStyle valueStyle,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6), // "Papel" ligeramente más claro para el fondo de la tarjeta
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accentColor.withOpacity(0.3), width: 1), // Borde sutil tipo tinta
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // Sombra sutil para dar profundidad, imitando papel en capas
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: labelStyle,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: valueStyle,
            ),
          ),
        ],
      ),
    );
  }
}