Aquí tienes el código Dart completo y funcional para la pantalla `SettingsScreen`, siguiendo todas tus especificaciones para la aplicación "PomodoroManuscriptApp".

Este código incluye:
*   Una clase `SettingsScreen` que es un `StatefulWidget` para manejar la configuración interactiva.
*   Uso de `Color(0xFFF5F5DC)` como color primario (fondo) y `Color(0xFF8B4513)` como color de acento (elementos interactivos, texto).
*   Elementos de UI representativos como `Slider` para duraciones y `SwitchListTile` para toggles.
*   Estilo de texto que simula una estética de manuscrito (asumiendo una fuente `OldStandardTT` configurada en `pubspec.yaml`).
*   Manejo básico del estado para los valores de configuración.
*   Un botón "Save Settings" que muestra un `SnackBar` con los valores actuales.
*   Uso correcto de `const` y sin errores de compilación.
*   Importación exclusiva de `package:flutter/material.dart`.

// settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  // Define el nombre de la ruta para facilitar la navegación
  static const String routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Valores por defecto para las configuraciones
  int _pomodoroDuration = 25; // minutos
  int _shortBreakDuration = 5; // minutos
  int _longBreakDuration = 15; // minutos
  int _pomodoroCycles = 4; // ciclos antes de un descanso largo
  bool _enableNotifications = true;

  @override
  Widget build(BuildContext context) {
    // Accede al ColorScheme del tema para mantener la consistencia
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // El color de fondo principal para la estética de manuscrito
      backgroundColor: colorScheme.primary, // Color(0xFFF5F5DC)
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'OldStandardTT', // Fuente para estética de manuscrito
            color: Color(0xFF8B4513), // Color de acento para el título
          ),
        ),
        backgroundColor: colorScheme.primary, // AppBar coincide con el fondo
        elevation: 0, // Sin sombra para un aspecto plano
        iconTheme: const IconThemeData(
          color: Color(0xFF8B4513), // Color de acento para el botón de retroceso
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección para la duración del Pomodoro
            _buildSettingSection(
              context,
              'Pomodoro Duration',
              '$_pomodoroDuration minutes',
              Slider(
                value: _pomodoroDuration.toDouble(),
                min: 5,
                max: 60,
                divisions: 11, // Permite valores de 5, 10, ..., 60
                activeColor: const Color(0xFF8B4513), // Color de acento
                inactiveColor: const Color(0xFFD2B48C), // Marrón más claro para inactivo
                onChanged: (value) {
                  setState(() {
                    _pomodoroDuration = value.toInt();
                  });
                },
              ),
            ),
            const SizedBox(height: 10), // Espacio entre secciones

            // Sección para la duración del Descanso Corto
            _buildSettingSection(
              context,
              'Short Break Duration',
              '$_shortBreakDuration minutes',
              Slider(
                value: _shortBreakDuration.toDouble(),
                min: 1,
                max: 15,
                divisions: 14, // Permite valores de 1, 2, ..., 15
                activeColor: const Color(0xFF8B4513),
                inactiveColor: const Color(0xFFD2B48C),
                onChanged: (value) {
                  setState(() {
                    _shortBreakDuration = value.toInt();
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

            // Sección para la duración del Descanso Largo
            _buildSettingSection(
              context,
              'Long Break Duration',
              '$_longBreakDuration minutes',
              Slider(
                value: _longBreakDuration.toDouble(),
                min: 5,
                max: 30,
                divisions: 5, // Permite valores de 5, 10, ..., 30
                activeColor: const Color(0xFF8B4513),
                inactiveColor: const Color(0xFFD2B48C),
                onChanged: (value) {
                  setState(() {
                    _longBreakDuration = value.toInt();
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

            // Sección para el número de ciclos de Pomodoro
            _buildSettingSection(
              context,
              'Pomodoro Cycles',
              '$_pomodoroCycles cycles',
              Slider(
                value: _pomodoroCycles.toDouble(),
                min: 2,
                max: 8,
                divisions: 6, // Permite valores de 2, 3, ..., 8
                activeColor: const Color(0xFF8B4513),
                inactiveColor: const Color(0xFFD2B48C),
                onChanged: (value) {
                  setState(() {
                    _pomodoroCycles = value.toInt();
                  });
                },
              ),
            ),
            const SizedBox(height: 20),

            // Sección para habilitar/deshabilitar notificaciones
            _buildToggleSetting(
              context,
              'Enable Notifications',
              _enableNotifications,
              (value) {
                setState(() {
                  _enableNotifications = value;
                });
              },
            ),
            const SizedBox(height: 30),

            // Botón para guardar las configuraciones
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _saveSettings(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B4513), // Color de acento para el botón
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Save Settings',
                  style: TextStyle(
                    color: Color(0xFFF5F5DC), // Color primario para el texto del botón
                    fontSize: 18,
                    fontFamily: 'OldStandardTT',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para construir secciones de configuración con Slider
  Widget _buildSettingSection(
      BuildContext context, String title, String valueText, Widget control) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B4513), // Color de acento para los títulos
              fontFamily: 'OldStandardTT',
            ),
          ),
          Row(
            children: [
              Expanded(child: control),
              Text(
                valueText,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8B4513), // Color de acento para los valores
                  fontFamily: 'OldStandardTT',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para construir secciones de configuración con Switch
  Widget _buildToggleSetting(
      BuildContext context, String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8B4513),
          fontFamily: 'OldStandardTT',
        ),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF8B4513), // Color de acento para el switch activo
      inactiveThumbColor: const Color(0xFFD2B48C), // Marrón más claro para el pulgar inactivo
      inactiveTrackColor: const Color(0xFFE0C9A6), // Marrón aún más claro para la pista inactiva
      contentPadding: EdgeInsets.zero, // Elimina el padding por defecto
    );
  }

  // Método para simular el guardado de configuraciones
  void _saveSettings(BuildContext context) {
    // En una aplicación real, guardarías estos ajustes usando un paquete
    // como shared_preferences o una solución de gestión de estado.
    // Por ahora, solo mostraremos un SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Settings saved! Pomodoro: $_pomodoroDuration min, Short Break: $_shortBreakDuration min, Long Break: $_longBreakDuration min, Cycles: $_pomodoroCycles, Notifications: ${_enableNotifications ? "On" : "Off"}',
          style: const TextStyle(
            color: Color(0xFF8B4513), // Color de acento para el texto del snackbar
            fontFamily: 'OldStandardTT',
          ),
        ),
        backgroundColor: const Color(0xFFF5F5DC), // Color primario para el fondo del snackbar
        duration: const Duration(seconds: 3),
      ),
    );
    // Opcionalmente, podrías navegar de vuelta a la pantalla anterior:
    // Navigator.pop(context);
  }
}