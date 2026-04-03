Aquí tienes el código Dart completo y funcional para la pantalla `SettingsScreen` de tu aplicación "PomodoroManuscriptApp", que cumple con todos los requisitos, incluyendo la integración con `Provider` para la gestión de estado y las correcciones críticas solicitadas.

**Nota importante sobre las importaciones:**
El requisito de "Importa solo: `package:flutter/material.dart`" entra en conflicto directo con el requisito de "Integra la gestión de estado" usando `Provider`. Para que la gestión de estado sea funcional, es indispensable importar `package:provider/provider.dart` y el archivo de tu proveedor (`pomodoromanuscriptapp_provider.dart`). He priorizado la funcionalidad y la integración de estado, que fue marcada como una "corrección crítica", incluyendo las importaciones necesarias.

---

**`settings_screen.dart`**

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Importa tu archivo de proveedor. Asegúrate de que la ruta sea correcta.
// Se asume que este archivo existe y contiene la clase PomodoroManuscriptAppProvider.
import 'package:pomodoro_manuscript_app/pomodoromanuscriptapp_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Estado local para los Sliders y DropdownButton para proporcionar
  // retroalimentación inmediata durante la interacción del usuario.
  // Los valores finales se guardarán en el proveedor.
  late int _currentPomodoroDuration;
  late int _currentShortBreakDuration;
  late int _currentLongBreakDuration;
  late int _currentPomodorosBeforeLongBreak;

  @override
  void initState() {
    super.initState();
    // Inicializa el estado local con los valores actuales del proveedor.
    // Usamos context.read para obtener el valor sin escuchar cambios.
    final provider = context.read<PomodoroManuscriptAppProvider>();
    _currentPomodoroDuration = provider.pomodoroDuration;
    _currentShortBreakDuration = provider.shortBreakDuration;
    _currentLongBreakDuration = provider.longBreakDuration;
    _currentPomodorosBeforeLongBreak = provider.pomodorosBeforeLongBreak;
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFFF5F5DC); // Beige
    final Color accentColor = const Color(0xFF8B4513); // Marrón

    // Estilos de texto personalizados para la estética de manuscrito
    // Se asume que 'OldStandardTT' está configurado en pubspec.yaml
    final TextStyle manuscriptTextStyle = TextStyle(
      fontFamily: 'OldStandardTT',
      color: accentColor,
      fontSize: 18,
    );

    final TextStyle titleTextStyle = TextStyle(
      fontFamily: 'OldStandardTT',
      color: accentColor,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: titleTextStyle.copyWith(fontSize: 28),
        ),
        backgroundColor: primaryColor,
        foregroundColor: accentColor,
        elevation: 0, // Sin sombra para un look más plano de manuscrito
        centerTitle: true,
      ),
      body: Consumer<PomodoroManuscriptAppProvider>(
        builder: (context, provider, child) {
          // Aunque los sliders usan estado local para el arrastre,
          // los Text que muestran los valores y el DropdownButton
          // se actualizan directamente desde el proveedor, asegurando
          // que la UI refleje el estado global.
          // Si los valores del proveedor cambian externamente mientras
          // esta pantalla está abierta, el Consumer reconstruirá y
          // los sliders se actualizarán a través de su `value` si se
          // sincronizan aquí, pero para evitar saltos visuales durante
          // el arrastre, mantenemos el estado local para el slider `value`.
          // Sin embargo, para el DropdownButton, es más directo actualizar
          // el estado local aquí para que el `value` del Dropdown refleje
          // el proveedor si cambia.
          _currentPomodorosBeforeLongBreak = provider.pomodorosBeforeLongBreak;

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildSettingCard(
                context,
                title: 'Pomodoro Duration',
                value: '${provider.pomodoroDuration} min',
                slider: Slider(
                  value: _currentPomodoroDuration.toDouble(),
                  min: 15,
                  max: 60,
                  divisions: 9, // (60-15) / 5 = 9 divisiones
                  activeColor: accentColor,
                  inactiveColor: accentColor.withOpacity(0.3),
                  thumbColor: accentColor,
                  label: '${_currentPomodoroDuration.round()} min',
                  onChanged: (double value) {
                    setState(() {
                      _currentPomodoroDuration = value.round();
                    });
                  },
                  onChangeEnd: (double value) {
                    // Solo actualiza el proveedor cuando el usuario suelta el slider
                    provider.setPomodoroDuration(value.round());
                  },
                ),
                textStyle: manuscriptTextStyle,
              ),
              const SizedBox(height: 20),
              _buildSettingCard(
                context,
                title: 'Short Break Duration',
                value: '${provider.shortBreakDuration} min',
                slider: Slider(
                  value: _currentShortBreakDuration.toDouble(),
                  min: 3,
                  max: 10,
                  divisions: 7, // (10-3) / 1 = 7 divisiones
                  activeColor: accentColor,
                  inactiveColor: accentColor.withOpacity(0.3),
                  thumbColor: accentColor,
                  label: '${_currentShortBreakDuration.round()} min',
                  onChanged: (double value) {
                    setState(() {
                      _currentShortBreakDuration = value.round();
                    });
                  },
                  onChangeEnd: (double value) {
                    provider.setShortBreakDuration(value.round());
                  },
                ),
                textStyle: manuscriptTextStyle,
              ),
              const SizedBox(height: 20),
              _buildSettingCard(
                context,
                title: 'Long Break Duration',
                value: '${provider.longBreakDuration} min',
                slider: Slider(
                  value: _currentLongBreakDuration.toDouble(),
                  min: 10,
                  max: 30,
                  divisions: 8, // (30-10) / 2.5 = 8 divisiones (aprox)
                  activeColor: accentColor,
                  inactiveColor: accentColor.withOpacity(0.3),
                  thumbColor: accentColor,
                  label: '${_currentLongBreakDuration.round()} min',
                  onChanged: (double value) {
                    setState(() {
                      _currentLongBreakDuration = value.round();
                    });
                  },
                  onChangeEnd: (double value) {
                    provider.setLongBreakDuration(value.round());
                  },
                ),
                textStyle: manuscriptTextStyle,
              ),
              const SizedBox(height: 20),
              _buildSettingCard(
                context,
                title: 'Pomodoros before Long Break',
                value: '${provider.pomodorosBeforeLongBreak} cycles',
                child: DropdownButton<int>(
                  value: _currentPomodorosBeforeLongBreak,
                  icon: Icon(Icons.arrow_drop_down, color: accentColor),
                  dropdownColor: primaryColor.withOpacity(0.9), // Fondo del menú desplegable
                  underline: Container(height: 1, color: accentColor),
                  style: manuscriptTextStyle,
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      // Actualiza el estado local y el proveedor
                      setState(() {
                        _currentPomodorosBeforeLongBreak = newValue;
                      });
                      provider.setPomodorosBeforeLongBreak(newValue);
                    }
                  },
                  items: <int>[2, 3, 4, 5, 6] // Opciones para ciclos
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value', style: manuscriptTextStyle),
                    );
                  }).toList(),
                ),
                textStyle: manuscriptTextStyle,
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget auxiliar para construir cada tarjeta de configuración
  Widget _buildSettingCard(
    BuildContext context, {
    required String title,
    required String value,
    Widget? slider, // Puede ser un Slider
    Widget? child, // O cualquier otro widget (como DropdownButton)
    required TextStyle textStyle,
  }) {
    final Color accentColor = const Color(0xFF8B4513); // Marrón

    return Card(
      color: const Color(0xFFF5F5DC).withOpacity(0.8), // Tarjeta beige ligeramente transparente
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: accentColor.withOpacity(0.5), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: textStyle.copyWith(fontSize: 16),
                  ),
                ),
                if (slider != null) Expanded(flex: 2, child: slider),
                if (child != null) child,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

---

**Asunción para `pomodoromanuscriptapp_provider.dart`:**

Para que el código anterior funcione, necesitas un archivo `pomodoromanuscriptapp_provider.dart` en la ruta `lib/pomodoromanuscriptapp_provider.dart` (o la ruta que hayas configurado en tu `pubspec.yaml` para el paquete `pomodoro_manuscript_app`). Aquí tienes una estructura básica de cómo debería ser ese archivo:

// lib/pomodoromanuscriptapp_provider.dart
import 'package:flutter/foundation.dart'; // Para ChangeNotifier

class PomodoroManuscriptAppProvider extends ChangeNotifier {
  // Valores predeterminados de las configuraciones
  int _pomodoroDuration = 25; // minutos
  int _shortBreakDuration = 5; // minutos
  int _longBreakDuration = 15; // minutos
  int _pomodorosBeforeLongBreak = 4;

  // Getters para acceder a las configuraciones
  int get pomodoroDuration => _pomodoroDuration;
  int get shortBreakDuration => _shortBreakDuration;
  int get longBreakDuration => _longBreakDuration;
  int get pomodorosBeforeLongBreak => _pomodorosBeforeLongBreak;

  // Setters para modificar las configuraciones y notificar a los listeners
  void setPomodoroDuration(int duration) {
    if (_pomodoroDuration != duration) {
      _pomodoroDuration = duration;
      notifyListeners();
    }
  }

  void setShortBreakDuration(int duration) {
    if (_shortBreakDuration != duration) {
      _shortBreakDuration = duration;
      notifyListeners();
    }
  }

  void setLongBreakDuration(int duration) {
    if (_longBreakDuration != duration) {
      _longBreakDuration = duration;
      notifyListeners();
    }
  }

  void setPomodorosBeforeLongBreak(int count) {
    if (_pomodorosBeforeLongBreak != count) {
      _pomodorosBeforeLongBreak = count;
      notifyListeners();
    }
  }
}

---

**Configuración en `main.dart` (Ejemplo):**

Para usar `SettingsScreen` y el `PomodoroManuscriptAppProvider`, tu `main.dart` debería lucir algo así:

// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_manuscript_app/pomodoromanuscriptapp_provider.dart';
import 'package:pomodoro_manuscript_app/screens/welcome_screen.dart'; // Asume que existe
import 'package:pomodoro_manuscript_app/screens/pomodoro_screen.dart'; // Asume que existe
import 'package:pomodoro_manuscript_app/screens/settings_screen.dart';
import 'package:pomodoro_manuscript_app/screens/statistics_screen.dart'; // Asume que existe

void main() {
  runApp(const MyApp());
}

class MyApp extends