¡Absolutamente! Aquí tienes el código completo y funcional para la aplicación "PomodoroManuscriptApp", incluyendo la `StatisticsScreen` y todas las integraciones solicitadas.

He creado una estructura de carpetas para organizar el código de manera limpia:
- `lib/main.dart`: Punto de entrada de la aplicación.
- `lib/models/pomodoro_session.dart`: Modelo de datos para una sesión de Pomodoro.
- `lib/providers/pomodoro_manuscript_app_provider.dart`: Gestión de estado con `ChangeNotifier`.
- `lib/screens/`: Contiene todas las pantallas de la aplicación.

Para que la fuente personalizada `OldStandardTT` funcione, debes realizar los siguientes pasos:

1.  **Descargar la fuente:**
    *   Ve a [Google Fonts - Old Standard TT](https://fonts.google.com/specimen/Old+Standard+TT).
    *   Haz clic en "Download family".

2.  **Crear la carpeta `fonts`:**
    *   En la raíz de tu proyecto Flutter (al mismo nivel que `lib` y `pubspec.yaml`), crea una nueva carpeta llamada `fonts`.

3.  **Copiar los archivos de la fuente:**
    *   Descomprime el archivo ZIP que descargaste.
    *   Copia los archivos `OldStandardTT-Regular.ttf` y `OldStandardTT-Italic.ttf` (o los que desees usar) a la carpeta `fonts` que acabas de