Aquí tienes el código Dart completo y funcional para la pantalla `SettingsScreen`, diseñado para tu aplicación "PomodoroManuscriptApp". Este archivo (`settings_screen.dart`) está listo para ser importado y utilizado en tu `main.dart` sin generar errores de compilación por definiciones duplicadas.

Este código implementa la interfaz de usuario para configurar los tiempos de Pomodoro, descanso corto y descanso largo, así como el número de ciclos de Pomodoro antes de un descanso largo. Utiliza `StatefulWidget` para gestionar los valores de configuración y `Slider` para una interacción intuitiva, todo ello con la estética de manuscrito y los colores especificados.

---

**`lib/settings_screen.dart`**

import 'package:flutter/material.dart';

/// La pantalla de configuración de la aplicación PomodoroManuscriptApp.
/// Permite al usuario ajustar las duraciones de Pomodoro, descanso corto y largo,
/// así como el número de Pomodoros antes de un descanso largo.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Valores por defecto para las configuraciones.
  // En una aplicación real, estos valores se cargarían desde un almacenamiento persistente
  // (ej. SharedPreferences) y se guardarían al aplicar los cambios.
  double _pomodoroDuration = 25.0; // Duración del Pomodoro en minutos
  double _shortBreakDuration = 5.0; // Duración del descanso corto en minutos
  double _longBreakDuration = 15.0; // Duración del descanso largo en minutos
  int _pomodorosBeforeLongBreak = 4; // Número de Pomodoros antes del descanso largo

  // Colores principales de la aplicación para mantener la estética de manuscrito.
  static const Color _primaryManuscriptColor = Color(0xFFF5F5DC); // Beige papel
  static const Color _accentManuscriptColor = Color(0xFF8B4513); // Marrón tinta

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryManuscriptColor, // Fondo color papel beige
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'RobotoSerif', // Asumiendo una fuente serif para la estética
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: _primaryManuscriptColor,
        foregroundColor: _accentManuscriptColor, // Color de texto y iconos en la AppBar
        elevation: 0, // Sin sombra para un aspecto más plano y de manuscrito
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Tarjeta de configuración para la duración del Pomodoro
          _buildSettingCard(
            context,
            'Pomodoro Duration',
            '${_pomodoroDuration.toInt()} minutes',
            Slider(
              value: _pomodoroDuration,
              min: 5,
              max: 60,
              divisions: 11, // Permite valores de 5, 10, ..., 60
              activeColor: _accentManuscriptColor,
              inactiveColor: _accentManuscriptColor.withOpacity(0.3),
              thumbColor: _accentManuscriptColor,
              onChanged: (value) {
                setState(() {
                  _pomodoroDuration = value;
                });
              },
            ),
          ),
          const SizedBox(height: 20),

          // Tarjeta de configuración para la duración del descanso corto
          _buildSettingCard(
            context,
            'Short Break Duration',
            '${_shortBreakDuration.toInt()} minutes',
            Slider(
              value: _shortBreakDuration,
              min: 1,
              max: 15,
              divisions: 14, // Permite valores de 1, 2, ..., 15
              activeColor: _accentManuscriptColor,
              inactiveColor: _accentManuscriptColor.withOpacity(0.3),
              thumbColor: _accentManuscriptColor,
              onChanged: (value) {
                setState(() {
                  _shortBreakDuration = value;
                });
              },
            ),
          ),
          const SizedBox(height: 20),

          // Tarjeta de configuración para la duración del descanso largo
          _buildSettingCard(
            context,
            'Long Break Duration',
            '${_longBreakDuration.toInt()} minutes',
            Slider(
              value: _longBreakDuration,
              min: 5,
              max: 30,
              divisions: 5, // Permite valores de 5, 10, ..., 30
              activeColor: _accentManuscriptColor,
              inactiveColor: _accentManuscriptColor.withOpacity(0.3),
              thumbColor: _accentManuscriptColor,
              onChanged: (value) {
                setState(() {
                  _longBreakDuration = value;
                });
              },
            ),
          ),
          const SizedBox(height: 20),

          // Tarjeta de configuración para el número de Pomodoros antes del descanso largo
          _buildSettingCard(
            context,
            'Pomodoros before Long Break',
            '$_pomodorosBeforeLongBreak cycles',
            Slider(
              value: _pomodorosBeforeLongBreak.toDouble(),
              min: 2,
              max: 8,
              divisions: 6, // Permite valores de 2, 3, ..., 8
              activeColor: _accentManuscriptColor,
              inactiveColor: _accentManuscriptColor.withOpacity(0.3),
              thumbColor: _accentManuscriptColor,
              onChanged: (value) {
                setState(() {
                  _pomodorosBeforeLongBreak = value.toInt();
                });
              },
            ),
          ),
          const SizedBox(height: 30),

          // Botón para aplicar/guardar las configuraciones
          ElevatedButton(
            onPressed: () {
              // En una aplicación real, aquí se guardarían los valores
              // en un almacenamiento persistente (ej. SharedPreferences).
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Settings applied (not persisted in this demo)!',
                    style: TextStyle(fontFamily: 'RobotoSerif'),
                  ),
                  backgroundColor: _accentManuscriptColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _accentManuscriptColor, // Fondo del botón color tinta
              foregroundColor: _primaryManuscriptColor, // Texto del botón color papel
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Apply Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoSerif',
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget auxiliar para construir una tarjeta de configuración con título, valor actual y un control (Slider).
  Widget _buildSettingCard(BuildContext context, String title, String currentValue, Widget control) {
    return Card(
      color: _primaryManuscriptColor.withOpacity(0.8), // Un beige ligeramente más oscuro para la tarjeta
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _accentManuscriptColor.withOpacity(0.5), width: 1), // Borde sutil
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _accentManuscriptColor,
                fontFamily: 'RobotoSerif',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              currentValue,
              style: TextStyle(
                fontSize: 16,
                color: _accentManuscriptColor.withOpacity(0.8),
                fontFamily: 'RobotoSerif',
              ),
            ),
            control, // El widget de control (ej. Slider)
          ],
        ),
      ),
    );
  }
}