¡Absolutamente! Aquí tienes el código Dart completo y funcional para la pantalla `StatisticsScreen`, siguiendo todos los requisitos especificados para tu `PomodoroManuscriptApp`.

He incluido una clase `MyApp` y una función `main()` para que puedas ejecutar este código directamente y ver la pantalla en acción, demostrando la implementación de Material Design 3 con `ColorScheme.fromSeed` y la estética de manuscrito.

// statistics_screen.dart
import 'package:flutter/material.dart';

/// La pantalla StatisticsScreen muestra las estadísticas de productividad del usuario.
/// Utiliza un StatefulWidget para simular datos dinámicos, aunque aquí son datos mock.
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  // Datos mock para demostración. En una aplicación real, estos vendrían de un servicio o base de datos.
  final int _totalPomodorosCompleted = 125;
  final int _totalFocusMinutes = 3125; // 125 pomodoros * 25 minutos
  final double _averagePomodoroDurationMinutes = 24.5; // Ligeramente menos de 25 por interrupciones, etc.

  // Datos mock para sesiones recientes
  final List<Map<String, dynamic>> _recentSessions = [
    {'date': '2023-10-26', 'duration': 25, 'completed': true},
    {'date': '2023-10-26', 'duration': 25, 'completed': true},
    {'date': '2023-10-25', 'duration': 15, 'completed': false}, // Sesión interrumpida
    {'date': '2023-10-25', 'duration': 25, 'completed': true},
    {'date': '2023-10-24', 'duration': 25, 'completed': true},
    {'date': '2023-10-24', 'duration': 25, 'completed': true},
    {'date': '2023-10-24', 'duration': 25, 'completed': true},
  ];

  @override
  Widget build(BuildContext context) {
    // Accede a los colores y estilos de texto definidos en el ThemeData de MaterialApp
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.primary, // Fondo beige principal
      appBar: AppBar(
        title: Text(
          'Your Productivity Stats',
          style: textTheme.headlineMedium?.copyWith(color: colorScheme.onPrimary), // Título en color acento
        ),
        backgroundColor: colorScheme.primary, // AppBar coincide con el fondo de la pantalla
        elevation: 0, // Sin sombra para una apariencia más plana, como papel
        iconTheme: IconThemeData(color: colorScheme.onPrimary), // Color del botón de retroceso
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección: Resumen de Estadísticas
            Text(
              'Overview',
              style: textTheme.titleLarge?.copyWith(color: colorScheme.onBackground),
            ),
            const SizedBox(height: 16),
            _buildStatCard(
              context,
              title: 'Total Pomodoros Completed',
              value: '$_totalPomodorosCompleted',
              icon: Icons.check_circle_outline,
            ),
            const SizedBox(height: 12),
            _buildStatCard(
              context,
              title: 'Total Focus Time',
              value: '${_totalFocusMinutes ~/ 60}h ${_totalFocusMinutes % 60}m',
              icon: Icons.timer,
            ),
            const SizedBox(height: 12),
            _buildStatCard(
              context,
              title: 'Average Pomodoro Duration',
              value: '${_averagePomodoroDurationMinutes.toStringAsFixed(1)} min',
              icon: Icons.trending_up,
            ),
            const SizedBox(height: 32),

            // Sección: Sesiones Recientes
            Text(
              'Recent Sessions',
              style: textTheme.titleLarge?.copyWith(color: colorScheme.onBackground),
            ),
            const SizedBox(height: 16),
            Column(
              children: _recentSessions.map((session) {
                final bool completed = session['completed'];
                final Color statusColor = completed ? Colors.green.shade700 : Colors.red.shade700;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Card(
                    color: colorScheme.surface, // Fondo de la tarjeta
                    elevation: 2, // Sombra sutil
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: colorScheme.secondary.withOpacity(0.3), width: 1), // Borde para estética de manuscrito
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            completed ? Icons.check_circle : Icons.cancel,
                            color: statusColor,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${session['date']}',
                                  style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                                ),
                                Text(
                                  'Duration: ${session['duration']} min',
                                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            completed ? 'Completed' : 'Interrupted',
                            style: textTheme.bodyMedium?.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],