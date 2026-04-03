¡Excelente! Entendido el requerimiento y la importancia de la corrección de errores de compilación, especialmente los relacionados con la resolución de paquetes y las expresiones no constantes.

Aquí tienes el código Dart completo y funcional para la `SettingsScreen`, adhiriéndome estrictamente a todas las especificaciones, incluyendo la estética de manuscrito y la corrección de `const`.

// settings_screen.dart
import 'package:flutter/material.dart';

/// La pantalla de configuración de la aplicación Pomodoro Manuscript.
/// Permite al usuario ajustar las duraciones de los ciclos de Pomodoro,
/// descanso corto y descanso largo.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Valores predeterminados para las duraciones de los temporizadores en minutos.
  int _pomodoroDuration = 25;
  int _shortBreakDuration = 5;
  int _longBreakDuration = 15;

  // Controladores para los campos de texto, permitiendo una entrada precisa.
  late TextEditingController _pomodoroController;
  late TextEditingController _shortBreakController;
  late TextEditingController _longBreakController;

  // Colores principales de la aplicación para mantener la estética de manuscrito.
  static const Color _primaryColor = Color(0xFFF5F5DC); // Papel beige
  static const Color _accentColor = Color(0xFF8B4513); // Tinta marrón

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con los valores actuales.
    _pomodoroController = TextEditingController(text: _pomodoroDuration.toString());
    _shortBreakController = TextEditingController(text: _shortBreakDuration.toString());
    _longBreakController = TextEditingController(text: _longBreakDuration.toString());

    // Añadir listeners para actualizar el estado cuando el texto cambia.
    // Esto asegura que los sliders y los campos de texto estén sincronizados.
    _pomodoroController.addListener(_updatePomodoroFromText);
    _shortBreakController.addListener(_updateShortBreakFromText);
    _longBreakController.addListener(_updateLongBreakFromText);
  }

  @override
  void dispose() {
    // Limpiar los controladores para evitar fugas de memoria.
    _pomodoroController.removeListener(_updatePomodoroFromText);
    _shortBreakController.removeListener(_updateShortBreakFromText);
    _longBreakController.removeListener(_updateLongBreakFromText);
    _pomodoroController.dispose();
    _shortBreakController.dispose();
    _longBreakController.dispose();
    super.dispose();
  }

  /// Actualiza la duración del Pomodoro desde el campo de texto.
  void _updatePomodoroFromText() {
    final int? value = int.tryParse(_pomodoroController.text);
    // Validar el valor: debe ser un número, mayor que 0, y dentro de un rango razonable.
    if (value != null && value > 0 && value <= 120 && value != _pomodoroDuration) {
      setState(() {
        _pomodoroDuration = value;
      });
    }
  }

  /// Actualiza la duración del descanso corto desde el campo de texto.
  void _updateShortBreakFromText() {
    final int? value = int.tryParse(_shortBreakController.text);
    if (value != null && value > 0 && value <= 60 && value != _shortBreakDuration) {
      setState(() {
        _shortBreakDuration = value;
      });
    }
  }

  /// Actualiza la duración del descanso largo desde el campo de texto.
  void _updateLongBreakFromText() {
    final int? value = int.tryParse(_longBreakController.text);
    if (value != null && value > 0 && value <= 120 && value != _longBreakDuration) {
      setState(() {
        _longBreakDuration = value;
      });
    }
  }

  /// Simula el guardado de la configuración.
  /// En una aplicación real, esto persistiría los datos (ej. SharedPreferences).
  void _saveSettings() {
    // Para esta demostración, simplemente imprimimos los valores.
    // Aquí se integraría la lógica para guardar en SharedPreferences, base de datos, etc.
    debugPrint('Configuración Guardada:');
    debugPrint('Duración Pomodoro: $_pomodoroDuration minutos');
    debugPrint('Duración Descanso Corto: $_shortBreakDuration minutos');
    debugPrint('Duración Descanso Largo: $_longBreakDuration minutos');

    // Mostrar una confirmación al usuario.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Configuración guardada con éxito!', style: TextStyle(color: _primaryColor)),
        backgroundColor: _accentColor,
      ),
    );
  }

  /// Widget auxiliar para construir una fila de configuración con slider y campo de texto.
  Widget _buildSettingRow({
    required String title,
    required int currentValue,
    required ValueChanged<double> onChanged,
    required TextEditingController controller,
    required double min,
    required double max,
    required int divisions,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ${currentValue} min',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _accentColor, // Tinta marrón para el texto
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: currentValue.toDouble(),
                  min: min,
                  max: max,
                  divisions: divisions,
                  onChanged: (double newValue) {
                    setState(() {
                      onChanged(newValue);
                      // Actualizar el campo de texto cuando el slider cambia.
                      controller.text = newValue.round().toString();
                    });
                  },
                  activeColor: _accentColor, // Color activo del slider (tinta marrón)
                  inactiveColor: _accentColor.withOpacity(0.3), // Color inactivo más claro
                  thumbColor: _accentColor, // Pulgar del slider (tinta marrón)
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: _accentColor), // Texto del input en tinta marrón
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: _accentColor), // Borde en tinta marrón
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: _accentColor, width: 2), // Borde enfocado más grueso
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _accentColor.withOpacity(0.5)), // Borde habilitado más suave
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7), // Fondo del input ligeramente transparente
                  ),
                  // No es necesario un onFieldSubmitted explícito aquí,
                  // ya que el listener en initState maneja los cambios.
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryColor, // Fondo de la pantalla en color papel beige
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: _accentColor), // Título en tinta marrón
        ),
        backgroundColor: _primaryColor, // Fondo del AppBar en color papel beige
        iconTheme: const IconThemeData(color: _accentColor), // Icono de retroceso en tinta marrón
        elevation: 1, // Ligera sombra para dar un efecto de capa de papel
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Fila para la duración del Pomodoro
            _buildSettingRow(
              title: 'Pomodoro Duration',
              currentValue: _pomodoroDuration,
              onChanged: (newValue) {
                setState(() {
                  _pomodoroDuration = newValue.round();
                });
              },
              controller: _pomodoroController,
              min: 5,
              max: 120,
              divisions: 23, // (120 - 5) / 5 = 23 divisiones para incrementos de 5 minutos
            ),
            // Fila para la duración del descanso corto
            _buildSettingRow(
              title: 'Short Break Duration',
              currentValue: _shortBreakDuration,
              onChanged: (newValue) {
                setState(() {
                  _shortBreakDuration = newValue.round();
                });
              },
              controller: _shortBreakController,
              min: 1,
              max: 30,
              divisions: 29, // (30 - 1) / 1 = 29 divisiones para incrementos de 1 minuto
            ),
            // Fila para la duración del descanso largo
            _buildSettingRow(
              title: 'Long Break Duration',
              currentValue: _longBreakDuration,
              onChanged: (newValue) {
                setState(() {
                  _longBreakDuration = newValue.round();
                });
              },
              controller: _longBreakController,
              min: 5,
              max: 60,
              divisions: 11, // (60 - 5) / 5 = 11 divisiones para incrementos de 5 minutos
            ),
            const SizedBox(height: 40),
            // Botón para guardar la configuración
            ElevatedButton(
              onPressed: _saveSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: _accentColor, // Fondo del botón en tinta marrón
                foregroundColor: _primaryColor, // Texto del botón en color papel beige
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

// --- EJEMPLO DE INTEGRACIÓN EN UN MATERIALAPP (PARA CONTEXTO) ---
// Este bloque de código NO es parte del archivo SettingsScreen.dart,
// sino que muestra cómo se configuraría el MaterialApp principal
// para que SettingsScreen herede el tema Material Design 3 y los colores.

/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFF5F5DC); // Beige paper
    const Color accentColor = Color(0xFF8B4513); // Brown ink

    return MaterialApp(
      title: 'Pomodoro Manuscript App',
      theme: ThemeData(
        // Configuración de ColorScheme.fromSeed para Material Design 3
        colorScheme: ColorScheme.fromSeed(
          seedColor: accentColor, // Usa el color acento como semilla para la generación de la paleta
          primary: primaryColor,