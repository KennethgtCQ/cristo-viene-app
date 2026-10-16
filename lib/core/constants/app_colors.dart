import 'package:flutter/painting.dart';

/// Colores fijos de la marca. Los colores por tema viven en AppTokens.
abstract final class AppColors {
  static const amarillo = Color(0xFFD8B24B);
  static const azul = Color(0xFF0071BC);
  static const verde = Color(0xFF55B45A);
  static const morado = Color(0xFF754BC8);
  static const magenta = Color(0xFFB34CA9);

  /// Orden del selector de acento (pantalla Apariencia).
  static const acentos = <Color>[amarillo, azul, verde, morado, magenta];

  static const blanco = Color(0xFFFFFFFF);
  static const negro = Color(0xFF000000);
  static const fondoOscuro = Color(0xFF1C1C1C);
}
