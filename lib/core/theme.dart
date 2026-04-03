import 'package:flutter/material.dart';

// ============================================================================
// TODO: AGENTE OMEGA - Este es un lienzo en blanco para la identidad visual.
// Eres libre de ser creativo. Define los colores, tipografías, y la estructura
// completa del [ThemeData] para hacer una UI espectacular.
// Utiliza estos colores iniciales provistos por el comando como punto de inicio:
// 
// Primary Color: F5F5DC
// Accent Color: 8B4513
// ============================================================================

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      // Define el tema claro aquí...
      primaryColor: const Color(0xFFF5F5DC),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5F5DC)),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      // Define el tema oscuro aquí...
      brightness: Brightness.dark,
    );
  }
}
