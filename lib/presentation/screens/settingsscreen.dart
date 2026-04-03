Aquí tienes el código Dart completo y funcional para la pantalla `SettingsScreen` de tu aplicación "PomodoroManuscriptApp", siguiendo todas las especificaciones y atendiendo la retroalimentación proporcionada.

Este código asume que ya has configurado tu `main.dart` para usar Material Design 3 con `ColorScheme.fromSeed` y que las rutas nombradas están definidas, así como las correcciones en `pomodoro_screen.dart` y `welcomescreen.dart` han sido aplicadas.

Para la estética de "Times New Roman", se utiliza `fontFamily: 'serif'` como una aproximación, ya que `package:flutter/material.dart` no incluye `google_fonts` por defecto. Para una coincidencia exacta, se necesitaría importar `google_fonts` o añadir una fuente personalizada.

import 'package:flutter/material.dart';

/// La pantalla de configuración permite al usuario ajustar los tiempos del Pomodoro,
/// los descansos y otras preferencias de la aplicación.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Valores por defecto para las configuraciones
  double _pomodoroDuration = 25.0; // minutos
  double _shortBreakDuration = 5.0; // minutos
  double _longBreakDuration = 15.0; // minutos
  int _pomodorosBeforeLongBreak = 4;
  bool _enableNotifications = true;

  // En una aplicación real, estos valores se cargarían desde un almacenamiento persistente
  // (ej. SharedPreferences) al iniciar la pantalla.

  /// Simula el guardado de la configuración.
  /// En una aplicación real, aquí se usaría SharedPreferences o un sistema de gestión de estado.
  void _saveSettings() {
    // Ejemplo de cómo se guardarían los valores usando SharedPreferences:
    // import 'package:shared_preferences/shared_preferences.dart';
    //
    // Future<void> _saveSettings() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   await prefs.setDouble('pomodoroDuration', _pomodoroDuration);
    //   await prefs.setDouble('shortBreakDuration', _shortBreakDuration);
    //   await prefs.setDouble('longBreakDuration', _longBreakDuration);
    //   await prefs.setInt('pomodorosBeforeLongBreak', _pomodorosBeforeLongBreak);
    //   await prefs.setBool('enableNotifications', _enableNotifications);
    //
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         'Configuración guardada',
    //         style: TextStyle(fontFamily: 'serif'),
    //       ),
    //       backgroundColor: Color(0xFF8B4513),
    //     ),
    //   );
    // }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Configuración guardada (simulado)',
          style: TextStyle(fontFamily: 'serif'),
        ),
        backgroundColor: const Color(0xFF8B4513), // Color accent
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFFF5F5DC); // Beige papel
    final Color accentColor = const Color(0xFF8B4513); // Marrón

    // Estilo de texto para simular la estética de manuscrito (Times New Roman)
    // Se usa 'serif' como una fuente genérica serif. Para Times New Roman exacto,
    // se necesitaría importar 'google_fonts' o una fuente personalizada.
    final TextStyle manuscriptTextStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontFamily: 'serif',
          color: accentColor,
        );
    final TextStyle manuscriptTitleStyle = Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontFamily: 'serif',
          color: primaryColor, // Título de AppBar en color primario para contraste
          fontWeight: FontWeight.bold,
        );

    return Scaffold(
      backgroundColor: primaryColor, // Fondo beige papel
      appBar: AppBar(
        title: Text(
          'Ajustes del Manuscrito',
          style: manuscriptTitleStyle,
        ),
        backgroundColor: accentColor, // AppBar marrón
        iconTheme: IconThemeData(color: primaryColor), // Color del icono de retroceso
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // Configuración de la duración del Pomodoro
          _buildSettingCard(
            context,
            title: 'Duración del Pomodoro',
            value: '${_pomodoroDuration.toInt()} minutos',
            control: Slider(
              value: _pomodoroDuration,
              min: 5,
              max: 60,
              divisions: 11, // Pasos de 5 minutos (5, 10, ..., 60)
              activeColor: accentColor,
              inactiveColor: accentColor.withOpacity(0.3),
              thumbColor: accentColor,
              onChanged: (newValue) {
                setState(() {
                  _pomodoroDuration = newValue;
                });
              },
            ),
            manuscriptTextStyle: manuscriptTextStyle,
            accentColor: accentColor,
          ),
          const SizedBox(height: 16),

          // Configuración de la duración del Descanso Corto
          _buildSettingCard(
            context,
            title: 'Duración del Descanso Corto',
            value: '${_shortBreakDuration.toInt()} minutos',
            control: Slider(
              value: _shortBreakDuration,
              min: 1,
              max: 15,
              divisions: 14, // Pasos de 1 minuto (1, 2, ..., 15)
              activeColor: accentColor,
              inactiveColor: accentColor.withOpacity(0.3),
              thumbColor: accentColor,
              onChanged: (newValue) {
                setState(() {
                  _shortBreakDuration = newValue;
                });
              },
            ),
            manuscriptTextStyle: manuscriptTextStyle,
            accentColor: accentColor,
          ),
          const SizedBox(height: 16),

          // Configuración de la duración del Descanso Largo
          _buildSettingCard(
            context,
            title: 'Duración del Descanso Largo',
            value: '${_longBreakDuration.toInt()} minutos',
            control: Slider(
              value: _longBreakDuration,
              min: 10,
              max: 30,
              divisions: 4, // Pasos de 5 minutos (10, 15, 20, 25, 30)
              activeColor: accentColor,
              inactiveColor: accentColor.withOpacity(0.3),
              thumbColor: accentColor,
              onChanged: (newValue) {
                setState(() {
                  _longBreakDuration = newValue;
                });
              },
            ),
            manuscriptTextStyle: manuscriptTextStyle,
            accentColor: accentColor,
          ),
          const SizedBox(height: 16),

          // Configuración de Pomodoros antes del Descanso Largo
          _buildSettingCard(
            context,
            title: 'Pomodoros antes del Descanso Largo',
            value: '${_pomodorosBeforeLongBreak} ciclos',
            control: Slider(
              value: _pomodorosBeforeLongBreak.toDouble(),
              min: 2,
              max: 8,
              divisions: 6, // Pasos de 1 ciclo (2, 3, ..., 8)
              activeColor: accentColor,
              inactiveColor: accentColor.withOpacity(0.3),
              thumbColor: accentColor,
              onChanged: (newValue) {
                setState(() {
                  _pomodorosBeforeLongBreak = newValue.toInt();
                });
              },
            ),
            manuscriptTextStyle: manuscriptTextStyle,
            accentColor: accentColor,
          ),
          const SizedBox(height: 16),

          // Configuración para habilitar notificaciones
          _buildSettingCard(
            context,
            title: 'Habilitar Notificaciones',
            value: _enableNotifications ? 'Activado' : 'Desactivado',
            control: Switch(
              value: _enableNotifications,
              activeColor: accentColor,
              inactiveThumbColor: accentColor.withOpacity(0.5),
              inactiveTrackColor: accentColor.withOpacity(0.2),
              onChanged: (newValue) {
                setState(() {
                  _enableNotifications = newValue;
                });
              },
            ),
            manuscriptTextStyle: manuscriptTextStyle,
            accentColor: accentColor,
          ),
          const SizedBox(height: 24),

          // Botón para guardar la configuración
          ElevatedButton(
            onPressed: _saveSettings,
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor, // Botón marrón
              foregroundColor: primaryColor, // Color del texto del botón
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4,
            ),
            child: Text(
              'Guardar Ajustes',
              style: manuscriptTextStyle.copyWith(
                color: primaryColor, // El texto del botón debe ser de color primario
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget auxiliar para construir una tarjeta de configuración individual.
  Widget _buildSettingCard(
    BuildContext context, {
    required String title,
    required String value,
    required Widget control,
    required TextStyle manuscriptTextStyle,
    required Color accentColor,
  }) {
    return Card(
      color: Theme.of(context).cardColor.withOpacity(0.7), // Tarjeta ligeramente transparente sobre el fondo beige
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: accentColor.withOpacity(0.3), width: 1), // Borde sutil
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: manuscriptTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: manuscriptTextStyle.copyWith(fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 200, // Ancho fijo para alinear los controles
                  child: control,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}