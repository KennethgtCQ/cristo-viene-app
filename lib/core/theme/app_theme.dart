import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import 'app_tokens.dart';

/// ThemeData claro y oscuro. Si el usuario no eligió acento, el oscuro usa
/// amarillo y el claro usa azul.
abstract final class AppTheme {
  static ThemeData oscuro(Color? acento) =>
      _construir(AppTokens.oscuro(acento ?? AppColors.amarillo), Brightness.dark);

  static ThemeData claro(Color? acento) =>
      _construir(AppTokens.claro(acento ?? AppColors.azul), Brightness.light);

  static ThemeData _construir(AppTokens t, Brightness brillo) {
    final radio = BorderRadius.circular(AppSizes.radio);

    return ThemeData(
      useMaterial3: true,
      brightness: brillo,
      fontFamily: 'Aller',
      colorScheme: ColorScheme(
        brightness: brillo,
        primary: t.acento,
        onPrimary: t.sobreAcento,
        secondary: t.acento,
        onSecondary: t.sobreAcento,
        error: const Color(0xFFD64545),
        onError: AppColors.blanco,
        surface: t.fondo,
        onSurface: t.principal,
      ),
      scaffoldBackgroundColor: t.fondo,
      canvasColor: t.fondo,
      dividerColor: t.divisor,
      textTheme: TextTheme(
        displayLarge: t.titulo,
        displayMedium: t.titulo,
        displaySmall: t.titulo,
        headlineLarge: t.titulo,
        headlineMedium: t.titulo,
        headlineSmall: t.titulo,
        titleLarge: t.titulo,
        titleMedium: t.subtitulo,
        titleSmall: t.subtitulo,
        bodyLarge: t.campo,
        bodyMedium: t.descripcion,
        bodySmall: t.cardDetalle,
        labelLarge: t.accionPrincipal,
        labelMedium: t.cardTitulo,
        labelSmall: t.lugar,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: t.fondo,
        foregroundColor: t.principal,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: t.titulo,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: t.campoFondo,
        hintStyle: t.placeholder,
        errorStyle: const TextStyle(fontFamily: 'Aller', fontSize: 12),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
        border: OutlineInputBorder(borderRadius: radio, borderSide: BorderSide.none),
        enabledBorder:
            OutlineInputBorder(borderRadius: radio, borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: radio,
          borderSide: BorderSide(color: t.acento),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: t.acento,
        selectionHandleColor: t.acento,
      ),
      extensions: [t],
    );
  }
}
