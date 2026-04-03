Aquí tienes el código Dart completo y funcional para la pantalla `SettingsScreen` de tu aplicación "PomodoroManuscriptApp", siguiendo estrictamente todos los requisitos, incluida la estética de manuscrito y las restricciones de importación.

**`settings_screen.dart`**

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  // Define la ruta nombrada para esta pantalla
  static const String routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Valores por defecto para la configuración del temporizador
  double _pomodoroDuration = 25.0; // Duración del Pomodoro en minutos
  double _shortBreakDuration = 5.0; // Duración del descanso corto en minutos
  double _longBreakDuration = 15.0; // Duración del descanso largo en minutos

  // Colores principales de la aplicación para la estética de manuscrito
  final Color _primaryColor = const Color(0xFFF5F5DC); // Beige (papel)
  final Color _accentColor = const Color(0xFF8B4513); // Marrón (tinta)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryColor, // Fondo color papel beige
      appBar: AppBar(
        title: Text(
          'Configuración',
          style: TextStyle(
            // Intentamos usar una fuente serif para la estética de manuscrito.
            // Dada la restricción de importar solo 'package:flutter/material.dart',
            // no podemos usar 'google_fonts' o fuentes personalizadas.
            // 'serif' intentará usar una fuente serif por defecto del sistema.
            fontFamily: 'serif',
            color: _accentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: _primaryColor, // Barra de aplicación color papel
        elevation: 0, // Sin sombra para un aspecto de papel plano
        iconTheme: IconThemeData(color: _accentColor), // Color del icono de retroceso
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Configuración de la duración del Pomodoro
            _buildSettingSlider(
              label: 'Duración del Pomodoro',
              value: _pomodoroDuration,
              min: 5.0,
              max: 60.0,
              divisions: 11, // Pasos de 5 minutos (5, 10, ..., 60)
              onChanged: (newValue) {
                setState(() {
                  _pomodoroDuration = newValue;
                });
              },
              displayValue: '${_pomodoroDuration.round()} min',
            ),
            const SizedBox(height: 20),

            // Configuración de la duración del Descanso Corto
            _buildSettingSlider(
              label: 'Duración del Descanso Corto',
              value: _shortBreakDuration,
              min: 1.0,
              max: 15.0,
              divisions: 14, // Pasos de 1 minuto (1, 2, ..., 15)
              onChanged: (newValue) {
                setState(() {
                  _shortBreakDuration = newValue;
                });
              },
              displayValue: '${_shortBreakDuration.round()} min',
            ),
            const SizedBox(height: 20),

            // Configuración de la duración del Descanso Largo
            _buildSettingSlider(
              label: 'Duración del Descanso Largo',
              value: _longBreakDuration,
              min: 5.0,
              max: 30.0,
              divisions: 5, // Pasos de 5 minutos (5, 10, ..., 30)
              onChanged: (newValue) {
                setState(() {
                  _longBreakDuration = newValue;
                });
              },
              displayValue: '${_longBreakDuration.round()} min',
            ),
            const SizedBox(height: 40),

            // Botón para guardar la configuración
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // En una aplicación real, aquí se guardarían los valores
                  // en un almacenamiento persistente (ej. SharedPreferences).
                  // Por ahora, solo mostramos una confirmación simulada.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Configuración guardada (simulado)',
                        style: TextStyle(fontFamily: 'serif', color: _primaryColor),
                      ),
                      backgroundColor: _accentColor,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  // Opcionalmente, se podría regresar a la pantalla anterior:
                  // Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentColor, // Botón color tinta
                  foregroundColor: _primaryColor, // Texto color papel
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Guardar Configuración'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para construir cada slider de configuración
  Widget _buildSettingSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    required String displayValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _accentColor,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                // Personaliza el tema del slider para que coincida con la estética
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: _accentColor.withOpacity(0.7), // Pista activa color tinta
                  inactiveTrackColor: _accentColor.withOpacity(0.2), // Pista inactiva más clara
                  thumbColor: _accentColor, // Pulgar color tinta
                  overlayColor: _accentColor.withOpacity(0.2), // Efecto de pulsación
                  valueIndicatorColor: _accentColor, // Indicador de valor color tinta
                  valueIndicatorTextStyle: TextStyle(
                    fontFamily: 'serif',
                    color: _primaryColor, // Texto del indicador color papel
                  ),
                ),
                child: Slider(
                  value: value,
                  min: min,
                  max: max,
                  divisions: divisions,
                  label: value.round().toString(), // Muestra el valor actual en el pulgar
                  onChanged: onChanged,
                ),
              ),
            ),
            Container(
              width: 80, // Ancho fijo para la visualización del valor
              alignment: Alignment.centerRight,
              child: Text(
                displayValue,
                style: TextStyle(
                  fontFamily: 'serif',
                  fontSize: 16,
                  color: _accentColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}