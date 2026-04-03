Aquí tienes el código Dart completo y funcional para la pantalla `StatisticsScreen`, siguiendo todos tus requisitos, incluyendo la estética de manuscrito y la estricta adherencia al feedback del auditor sobre la estructura de archivos (implícitamente, al no incluir `main.dart` ni definiciones duplicadas).

Este archivo `statistics_screen.dart` está diseñado para ser importado y utilizado por tu `main.dart` sin conflictos.

// Archivo: lib/statistics_screen.dart

import 'package:flutter/material.dart';

/// La pantalla StatisticsScreen muestra las estadísticas de productividad del usuario
/// con una estética de manuscrito en papel beige.
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definición de los colores principales de la aplicación para la estética de manuscrito.
    // #F5F5DC es el color primario (papel beige).
    // #8B4513 es el color de acento (tinta sepia/marrón).
    final Color primaryManuscriptColor = const Color(0xFFF5F5DC);
    final Color accentManuscriptColor = const Color(0xFF8B4513);

    // Datos de ejemplo (mock data) para la demostración de la UI.
    // En una aplicación real, estos datos provendrían de un servicio o base de datos.
    final Map<String, dynamic> mockStatistics = {
      'totalPomodoros': 125,
      'totalFocusTimeMinutes': 3125, // 125 pomodoros * 25 minutos
      'averagePomodoroDurationMinutes': 25,
      'longestFocusStreakDays': 14,
      'todayPomodoros': 5,
      'thisWeekPomodoros': 30,
      'last7DaysActivity': [
        {'day': 'Mon', 'pomodoros': 4},
        {'day': 'Tue', 'pomodoros': 6},
        {'day': 'Wed', 'pomodoros': 5},
        {'day': 'Thu', 'pomodoros': 7},
        {'day': 'Fri', 'pomodoros': 3},
        {'day': 'Sat', 'pomodoros': 2},
        {'day': 'Sun', 'pomodoros': 0},
      ],
    };

    return Scaffold(
      backgroundColor: primaryManuscriptColor, // Fondo de papel beige
      appBar: AppBar(
        title: Text(
          'Your Productivity Scroll', // Título de la pantalla
          style: TextStyle(
            color: accentManuscriptColor, // Color de tinta sepia para el título
            fontFamily: 'Georgia', // Fuente clásica para la estética de manuscrito
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryManuscriptColor, // AppBar coincide con el fondo
        elevation: 0, // Sin sombra para un aspecto de papel plano
        iconTheme: IconThemeData(color: accentManuscriptColor), // Color del icono de retroceso
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: accentManuscriptColor,
                fontFamily: 'Georgia',
              ),
            ),
            const SizedBox(height: 16),
            // Tarjeta para "Total Pomodoros Completed"
            _buildStatisticCard(
              context,
              icon: Icons.check_circle_outline,
              label: 'Total Pomodoros Completed',
              value: '${mockStatistics['totalPomodoros']}',
              accentColor: accentManuscriptColor,
            ),
            // Tarjeta para "Total Focus Time"
            _buildStatisticCard(
              context,
              icon: Icons.timer,
              label: 'Total Focus Time',
              value: '${mockStatistics['totalFocusTimeMinutes']} minutes',
              accentColor: accentManuscriptColor,
            ),
            // Tarjeta para "Longest Focus Streak"
            _buildStatisticCard(
              context,
              icon: Icons.trending_up,
              label: 'Longest Focus Streak',
              value: '${mockStatistics['longestFocusStreakDays']} days',
              accentColor: accentManuscriptColor,
            ),
            const SizedBox(height: 24),
            Text(
              'Daily & Weekly',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: accentManuscriptColor,
                fontFamily: 'Georgia',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  // Tarjeta pequeña para "Today Pomodoros"
                  child: _buildSmallStatisticCard(
                    context,
                    icon: Icons.today,
                    label: 'Today',
                    value: '${mockStatistics['todayPomodoros']}',
                    unit: 'Pomodoros',
                    accentColor: accentManuscriptColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  // Tarjeta pequeña para "This Week Pomodoros"
                  child: _buildSmallStatisticCard(
                    context,
                    icon: Icons.calendar_view_week,
                    label: 'This Week',
                    value: '${mockStatistics['thisWeekPomodoros']}',
                    unit: 'Pomodoros',
                    accentColor: accentManuscriptColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Last 7 Days Activity',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: accentManuscriptColor,
                fontFamily: 'Georgia',
              ),
            ),
            const SizedBox(height: 16),
            // Representación simple de un gráfico de barras para la actividad de los últimos 7 días
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: primaryManuscriptColor.withOpacity(0.8), // Beige ligeramente transparente
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: accentManuscriptColor.withOpacity(0.3), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // Sombra sutil
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: mockStatistics['last7DaysActivity'].map<Widget>((data) {
                      final int pomodoros = data['pomodoros'];
                      final String day = data['day'];
                      final double barHeight = pomodoros * 10.0; // Factor de escala para las barras
                      return Column(
                        children: [
                          Text(
                            '$pomodoros',
                            style: TextStyle(
                              color: accentManuscriptColor,
                              fontSize: 12,
                              fontFamily: 'Georgia',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 20,
                            height: barHeight > 0 ? barHeight : 5, // Altura mínima para visibilidad
                            decoration: BoxDecoration(
                              color: accentManuscriptColor.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            day,
                            style: TextStyle(
                              color: accentManuscriptColor,
                              fontSize: 12,
                              fontFamily: 'Georgia',
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pomodoros per Day',
                    style: TextStyle(
                      color: accentManuscriptColor,
                      fontSize: 14,
                      fontFamily: 'Georgia',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Keep up the great work!',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: accentManuscriptColor.withOpacity(0.8),
                  fontFamily: 'Georgia',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget auxiliar para construir una tarjeta de estadística principal.
  Widget _buildStatisticCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color accentColor,
  }) {
    final Color primaryManuscriptColor = const Color(0xFFF5F5DC);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: primaryManuscriptColor.withOpacity(0.8), // Fondo de tarjeta beige ligeramente transparente
      elevation: 2, // Sombra sutil
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: accentColor.withOpacity(0.3), width: 1), // Borde fino
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 36, color: accentColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      color: accentColor.withOpacity(0.9),
                      fontFamily: 'Georgia',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                      fontFamily: 'Georgia',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget auxiliar para construir una tarjeta de estadística más pequeña.
  Widget _buildSmallStatisticCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required String unit,
    required Color accentColor,
  }) {
    final Color primaryManuscriptColor = const Color(0xFFF5F5DC);
    return Card(
      color: primaryManuscriptColor.withOpacity(0.8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: accentColor.withOpacity(0.3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: accentColor),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: accentColor.withOpacity(0.9),
                fontFamily: 'Georgia',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: accentColor,
                fontFamily: 'Georgia',
              ),
            ),
            Text(
              unit,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: accentColor.withOpacity(0.7),
                fontFamily: 'Georgia',
              ),
            ),
          ],
        ),
      ),
    );
  }
}