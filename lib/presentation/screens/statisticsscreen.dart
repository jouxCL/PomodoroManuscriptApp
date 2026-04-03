Aquí tienes el código Dart completo y funcional para la pantalla `StatisticsScreen`, siguiendo todas tus especificaciones para la aplicación "PomodoroManuscriptApp".

Este código incluye:
*   Una estructura `StatelessWidget`.
*   Uso del color primario `Color(0xFFF5F5DC)` para el fondo y el acento `Color(0xFF8B4513)` para el texto y los iconos, reflejando la estética de manuscrito.
*   Una `AppBar` con el título "Estadísticas".
*   Un `SingleChildScrollView` para asegurar que el contenido sea desplazable.
*   Una cuadrícula de tarjetas (`GridView`) que muestra estadísticas de ejemplo relevantes para una aplicación Pomodoro.
*   Un área de marcador de posición para un gráfico semanal y un consejo de productividad, manteniendo la estética.
*   Uso correcto de `const` para optimización.
*   Importación exclusiva de `package:flutter/material.dart`.
*   El código es completo, sin `TODO`s ni placeholders que impidan la compilación.

// statistics_screen.dart
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definición de los colores principales de la aplicación
    final Color primaryColor = const Color(0xFFF5F5DC); // Beige paper
    final Color accentColor = const Color(0xFF8B4513); // Brown for text/accents

    // Datos de ejemplo para las estadísticas
    final Map<String, String> mockStatistics = {
      'Pomodoros Completados': '125',
      'Tiempo Total de Enfoque': '52h 30min',
      'Descansos Cortos Tomados': '250',
      'Descansos Largos Tomados': '50',
      'Racha Más Larga': '7 días',
      'Promedio Diario de Pomodoros': '5',
      'Última Semana': '25 Pomodoros',
      'Último Mes': '100 Pomodoros',
    };

    return Scaffold(
      backgroundColor: primaryColor, // Fondo de la pantalla con el color beige
      appBar: AppBar(
        title: Text(
          'Estadísticas',
          style: TextStyle(
            color: accentColor, // Texto del título en color marrón
            fontFamily: 'RobotoSerif', // Sugerencia de fuente serif para estética de manuscrito
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor, // El fondo del AppBar coincide con el de la pantalla
        elevation: 0, // Sin sombra para un aspecto de papel plano
        iconTheme: IconThemeData(color: accentColor), // Color del icono de retroceso
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tu Viaje de Productividad',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: accentColor,
                fontFamily: 'RobotoSerif',
              ),
            ),
            const SizedBox(height: 20),
            // Cuadrícula de tarjetas para mostrar las estadísticas clave
            GridView.builder(
              shrinkWrap: true, // Importante para que GridView se ajuste dentro de SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(), // Deshabilita el scroll propio de GridView
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dos tarjetas por fila
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.5, // Relación de aspecto de las tarjetas
              ),
              itemCount: mockStatistics.length,
              itemBuilder: (context, index) {
                final entry = mockStatistics.entries.elementAt(index);
                return Card(
                  color: primaryColor.withOpacity(0.8), // Un beige ligeramente más oscuro para las tarjetas
                  elevation: 2, // Sombra sutil para dar profundidad
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: accentColor.withOpacity(0.3), width: 1), // Borde sutil
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          _getIconForStatistic(entry.key), // Icono dinámico según la estadística
                          color: accentColor,
                          size: 28,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: accentColor.withOpacity(0.9),
                            fontFamily: 'RobotoSerif',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry.value,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                            fontFamily: 'RobotoSerif',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            Text(
              'Resumen Semanal',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: accentColor,
                fontFamily: 'RobotoSerif',
              ),
            ),
            const SizedBox(height: 10),
            // Marcador de posición para un gráfico o lista semanal
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: accentColor.withOpacity(0.3), width: 1),
              ),
              child: Center(
                child: Text(
                  'Gráfico de productividad semanal (próximamente)',
                  style: TextStyle(
                    color: accentColor.withOpacity(0.7),
                    fontFamily: 'RobotoSerif',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Consejo de Productividad:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: accentColor,
                fontFamily: 'RobotoSerif',
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: primaryColor.withOpacity(0.8),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: accentColor.withOpacity(0.3), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Recuerda tomar descansos regulares para mantener tu mente fresca y aumentar tu concentración. ¡Un Pomodoro bien hecho es un paso hacia el éxito!',
                  style: TextStyle(
                    fontSize: 16,
                    color: accentColor.withOpacity(0.9),
                    fontFamily: 'RobotoSerif',
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función auxiliar para obtener un icono basado en la clave de la estadística
  IconData _getIconForStatistic(String key) {
    switch (key) {
      case 'Pomodoros Completados':
        return Icons.check_circle_outline;
      case 'Tiempo Total de Enfoque':
        return Icons.timer;
      case 'Descansos Cortos Tomados':
        return Icons.coffee;
      case 'Descansos Largos Tomados':
        return Icons.king_bed;
      case 'Racha Más Larga':
        return Icons.local_fire_department;
      case 'Promedio Diario de Pomodoros':
        return Icons.trending_up;
      case 'Última Semana':
        return Icons.calendar_view_week;
      case 'Último Mes':
        return Icons.calendar_month;
      default:
        return Icons.bar_chart;
    }
  }
}