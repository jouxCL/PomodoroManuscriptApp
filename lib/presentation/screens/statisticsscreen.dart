Aquí tienes el código Dart completo y funcional para la pantalla `StatisticsScreen`, siguiendo todos los requisitos y la estética de "PomodoroManuscriptApp".

Este código se enfoca exclusivamente en la `StatisticsScreen` y no incluye las correcciones o implementaciones mencionadas en la "NOTA ESPECIAL Y ESTRICTA DEL USUARIO" para otras pantallas (`PomodoroScreen`, `WelcomeScreen`, `main.dart`), ya que esas son responsabilidades de sus respectivos archivos y no de `StatisticsScreen`.

// statistics_screen.dart
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo para la demostración de la UI
    final int totalPomodoros = 125;
    final String totalFocusTime = "52h 30m";
    final String totalBreakTime = "17h 15m";
    final double avgPomodorosPerDay = 3.5;
    final int currentStreak = 7; // Días consecutivos usando la app

    // Definición de estilos de texto para simular la estética de manuscrito.
    // Idealmente, estos estilos serían parte del ThemeData global de la aplicación.
    final TextStyle manuscriptBaseTextStyle = TextStyle(
      fontFamily: 'serif', // Usa una fuente genérica serif para simular Times New Roman
      color: Theme.of(context).colorScheme.onSurface, // Color de texto oscuro para contraste
      fontSize: 16,
      height: 1.5, // Altura de línea para mejorar la legibilidad, como en un manuscrito
    );

    final TextStyle manuscriptTitleStyle = manuscriptBaseTextStyle.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.onSurface,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC), // Color principal: papel beige
      appBar: AppBar(
        title: Text(
          'Estadísticas de Productividad',
          style: manuscriptTitleStyle.copyWith(fontSize: 20), // Título del AppBar con estilo manuscrito
        ),
        backgroundColor: const Color(0xFFF5F5DC), // Fondo del AppBar a juego con el papel
        foregroundColor: Theme.of(context).colorScheme.onSurface, // Color del texto del AppBar
        elevation: 0, // Sin sombra para un efecto más plano y de papel
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tarjeta para "Pomodoros Completados"
            _buildStatisticCard(
              context,
              title: 'Pomodoros Completados',
              value: '$totalPomodoros',
              icon: Icons.check_circle_outline,
              manuscriptBaseTextStyle: manuscriptBaseTextStyle,
              manuscriptTitleStyle: manuscriptTitleStyle,
            ),
            const SizedBox(height: 16),
            // Tarjeta para "Tiempo Total de Enfoque"
            _buildStatisticCard(
              context,
              title: 'Tiempo Total de Enfoque',
              value: totalFocusTime,
              icon: Icons.timer,
              manuscriptBaseTextStyle: manuscriptBaseTextStyle,
              manuscriptTitleStyle: manuscriptTitleStyle,
            ),
            const SizedBox(height: 16),
            // Tarjeta para "Tiempo Total de Descanso"
            _buildStatisticCard(
              context,
              title: 'Tiempo Total de Descanso',
              value: totalBreakTime,
              icon: Icons.free_breakfast,
              manuscriptBaseTextStyle: manuscriptBaseTextStyle,
              manuscriptTitleStyle: manuscriptTitleStyle,
            ),
            const SizedBox(height: 16),
            // Tarjeta para "Promedio Diario de Pomodoros"
            _buildStatisticCard(
              context,
              title: 'Promedio Diario de Pomodoros',
              value: avgPomodorosPerDay.toStringAsFixed(1),
              icon: Icons.calendar_today,
              manuscriptBaseTextStyle: manuscriptBaseTextStyle,
              manuscriptTitleStyle: manuscriptTitleStyle,
            ),
            const SizedBox(height: 16),
            // Tarjeta para "Racha Actual"
            _buildStatisticCard(
              context,
              title: 'Racha Actual',
              value: '$currentStreak días',
              icon: Icons.local_fire_department,
              manuscriptBaseTextStyle: manuscriptBaseTextStyle,
              manuscriptTitleStyle: manuscriptTitleStyle,
            ),
            const SizedBox(height: 32),
            // Botón para restablecer estadísticas (funcionalidad de ejemplo)
            ElevatedButton.icon(
              onPressed: () {
                // Lógica para restablecer las estadísticas (no implementada aquí)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Funcionalidad de restablecer estadísticas no implementada.',
                      style: manuscriptBaseTextStyle.copyWith(color: Theme.of(context).colorScheme.onError),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              },
              icon: Icon(Icons.refresh, color: Theme.of(context).colorScheme.onError),
              label: Text(
                'Restablecer Estadísticas',
                style: manuscriptBaseTextStyle.copyWith(color: Theme.of(context).colorScheme.onError, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.errorContainer, // Color de fondo para una acción de advertencia
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Theme.of(context).colorScheme.error, width: 1), // Borde para enfatizar la acción
                ),
                elevation: 2, // Sombra sutil
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para construir cada tarjeta de estadística
  Widget _buildStatisticCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required TextStyle manuscriptBaseTextStyle,
    required TextStyle manuscriptTitleStyle,
  }) {
    return Card(
      color: Theme.of(context).colorScheme.surface, // Fondo de la tarjeta (generalmente blanco o muy claro)
      elevation: 2, // Sombra sutil para un efecto de papel superpuesto
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant, width: 1), // Borde sutil
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 30, color: const Color(0xFF8B4513)), // Icono con el color accent (marrón)
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: manuscriptTitleStyle.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: manuscriptBaseTextStyle.copyWith(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}