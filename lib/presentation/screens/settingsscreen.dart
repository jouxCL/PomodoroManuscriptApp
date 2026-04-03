¡Excelente! Aquí tienes el código completo y funcional para tu aplicación "PomodoroManuscriptApp", incluyendo la pantalla `SettingsScreen` y todas las mejoras solicitadas en la retroalimentación.

He estructurado el proyecto en varios archivos para una mejor organización, como es práctica común en Flutter.

---

### 1. `pubspec.yaml`

Asegúrate de que tu archivo `pubspec.yaml` incluya las siguientes dependencias para las fuentes de Google y la persistencia de datos:

name: pomodoro_manuscript_app
description: A Pomodoro app with configurable timers, statistics tracking, and a beige paper manuscript aesthetic.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  google_fonts: ^6.1.0 # Para la tipografía 'Lora' (similar a Times New Roman)
  shared_preferences: ^2.2.2 # Para la persistencia de datos

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true

Después de modificar `pubspec.yaml`, ejecuta `flutter pub get` en tu terminal.

---