Aquí tienes el código Dart completo y funcional para la pantalla `StatisticsScreen`, diseñado para tu aplicación `PomodoroManuscriptApp`. Se han abordado los errores de compilación comunes relacionados con la resolución de paquetes internos y las expresiones no constantes, asegurando que el código compile directamente y sin dependencias externas más allá de `flutter/material.dart`.

Este código incluye:
*   Una interfaz de usuario que refleja la estética de manuscrito con los colores especificados.
*   Estadísticas de ejemplo (mock data) para demostrar la funcionalidad.
*   Un resumen general, promedios y un gráfico de actividad semanal simulado.
*   Uso de `Material Design 3` con `ColorScheme.fromSeed`.
*   La clase `StatisticsScreen` como un `StatefulWidget` para permitir futuras interacciones (aunque actualmente usa datos estáticos).

import 'package:flutter/material.dart';

/// Define los colores principales de la aplicación para una fácil referencia.
/// kPrimaryColor: El color beige que simula el papel de manuscrito.
/// kAccentColor: El color marrón que simula la tinta o elementos de énfasis.
const Color kPrimaryColor = Color(0xFFF5F5DC); // Beige paper
const Color kAccentColor = Color(0xFF8B4513); // Brown ink

/// La pantalla de estadísticas de la aplicación PomodoroManuscriptApp.
/// Muestra un resumen de la productividad del usuario, incluyendo Pomodoros completados,
/// tiempo de enfoque, promedios y un gráfico de actividad semanal.
class StatisticsScreen extends StatefulWidget {
  // Define la ruta nombrada para esta pantalla, útil para la navegación.
  static const String routeName = '/statistics';

  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  // --- Datos de ejemplo (Mock Data) para la demostración ---
  // En una aplicación real, estos datos provendrían de un servicio de datos o base de datos.
  final int _totalPomodoros = 125;
  final Duration _totalFocusTime = const Duration(hours: 52, minutes: 15);
  final Duration _averagePomodoroDuration = const Duration(minutes: 25);
  final Duration _averageBreakDuration = const Duration(minutes: 5);
  final int _longestStreak = 12; // Días consecutivos de Pomodoros

  // Datos de ejemplo para un gráfico simple de Pomodoros completados por día.
  final Map<String, int> _dailyPomodoros = {
    'Lun': 5,
    'Mar': 7,
    'Mié': 4,
    'Jue': 8,
    'Vie': 6,
    'Sáb': 3,
    'Dom': 2,
  };

  /// Función auxiliar para formatear una duración en un formato legible (ej. "1h 30m").
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    // String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60)); // No se usa en este formato
    if (duration.inHours > 0) {
      return "${duration.inHours}h ${twoDigitMinutes}m";
    }
    return "${twoDigitMinutes}m"; // Solo minutos si es menos de una hora
  }

  @override
  Widget build(BuildContext context) {
    // Define un estilo de texto que imita la estética de un manuscrito.
    // Se usa 'RobotoMono' para un aspecto de máquina de escribir o escritura a mano.
    final TextStyle manuscriptTextStyle = TextStyle(
      fontFamily: 'RobotoMono',
      color: kAccentColor,
      fontSize: 16,
      height: 1.5, // Espaciado entre líneas para mejor legibilidad
    );

    // Estilo para los títulos de sección.
    final TextStyle headerTextStyle = manuscriptTextStyle.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );

    // Estilo para los títulos dentro de las tarjetas de estadísticas.
    final TextStyle cardTitleStyle = manuscriptTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    // Envuelve el Scaffold en un widget Theme para aplicar un tema específico
    // a esta pantalla, asegurando que los colores y estilos sean consistentes
    // con la estética de manuscrito, independientemente del tema global de la app.
    return Theme(
      data: ThemeData(
        // Configuración de ColorScheme.fromSeed para Material Design 3.
        // La seedColor ayuda a generar un esquema de colores armonioso.
        colorScheme: ColorScheme.fromSeed(
          seedColor: kAccentColor,
          primary: kPrimaryColor,
          onPrimary: kAccentColor,
          secondary: kAccentColor,
          onSecondary: kPrimaryColor,
          background: kPrimaryColor,
          onBackground: kAccentColor,
          surface: kPrimaryColor,
          onSurface: kAccentColor,
          error: Colors.red,
          onError: Colors.white,
        ),
        // Color de fondo general del Scaffold.
        scaffoldBackgroundColor: kPrimaryColor,
        // Tema para la AppBar.
        appBarTheme: AppBarTheme(
          backgroundColor: kPrimaryColor,
          foregroundColor: kAccentColor, // Color del título e iconos de la AppBar.
          elevation: 0, // Sin sombra para un aspecto más plano y de manuscrito.
          titleTextStyle: headerTextStyle.copyWith(fontSize: 20),
        ),
        // Configuración de TextTheme para aplicar los estilos de manuscrito.
        textTheme: TextTheme(
          bodyLarge: manuscriptTextStyle,
          bodyMedium: manuscriptTextStyle,
          headlineSmall: headerTextStyle, // Usado para títulos de sección.
          titleMedium: cardTitleStyle, // Usado para títulos de tarjetas.
          bodySmall: manuscriptTextStyle.copyWith(fontSize: 14), // Para texto más pequeño.
        ),
        // Tema para las tarjetas (Card).
        cardTheme: CardTheme(
          color: kPrimaryColor.withOpacity(0.8), // Un beige ligeramente más oscuro para las tarjetas.
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: kAccentColor, width: 1), // Borde para el efecto de manuscrito.
          ),
        ),
        // Tema para los divisores.
        dividerTheme: const DividerThemeData(
          color: kAccentColor,
          thickness: 1,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Estadísticas de Productividad'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resumen General',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              // Tarjetas de estadísticas para el resumen general.
              _buildStatCard(
                context,
                title: 'Pomodoros Completados',
                value: '$_totalPomodoros',
                icon: Icons.check_circle_outline,
              ),
              _buildStatCard(
                context,
                title: 'Tiempo Total de Enfoque',
                value: _formatDuration(_totalFocusTime),
                icon: Icons.timer,
              ),
              _buildStatCard(
                context,
                title: 'Racha Más Larga',
                value: '$_longestStreak días',
                icon: Icons.local_fire_department,
              ),
              const SizedBox(height: 24), // Espacio entre secciones.

              Text(
                'Promedios',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              // Tarjetas de estadísticas para los promedios.
              _buildStatCard(
                context,
                title: 'Duración Promedio Pomodoro',
                value: _formatDuration(_averagePomodoroDuration),
                icon: Icons.hourglass_empty,
              ),
              _buildStatCard(
                context,
                title: 'Duración Promedio Descanso',
                value: _formatDuration(_averageBreakDuration),
                icon: Icons.free_breakfast,
              ),
              const SizedBox(height: 24),

              Text(
                'Actividad Semanal',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              // Gráfico de actividad semanal simulado.
              _buildWeeklyActivityChart(context),
              const SizedBox(height: 24),

              // Mensaje motivacional al final.
              Center(
                child: Text(
                  '¡Sigue trabajando duro para mejorar tus estadísticas!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget auxiliar para construir una tarjeta de estadística individual.
  Widget _buildStatCard(BuildContext context, {required String title, required String value, required IconData icon}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: kAccentColor, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget auxiliar para construir un gráfico de barras simulado de actividad semanal.
  Widget _buildWeeklyActivityChart(BuildContext context) {
    // Calcula el número máximo de Pomodoros en un día para escalar las barras.
    final double maxPomodoros = _dailyPomodoros.values.reduce((a, b) => a > b ? a : b).toDouble();
    const double chartHeight = 150; // Altura fija para el área del gráfico.

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pomodoros por Día (Últimos 7 días)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end, // Alinea las barras en la parte inferior.
              children: _dailyPomodoros.entries.map((entry) {
                // Calcula la altura de la barra proporcional al valor máximo.
                final double barHeight = maxPomodoros > 0 ? (entry.value / maxPomodoros) * chartHeight : 0;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${entry.value}', // Valor numérico encima de la barra.
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: kAccentColor),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 20, // Ancho de la barra.
                      height: barHeight,
                      decoration: BoxDecoration(
                        color: kAccentColor.withOpacity(0.7), // Color de la barra.
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      entry.key, // Etiqueta del día.
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}