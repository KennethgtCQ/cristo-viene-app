import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Tokens de diseño del tema claro/oscuro (colores, sombras y estilos de texto).
/// Uso: context.tokens.principal, context.tokens.titulo, etc.
@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  const AppTokens({
    required this.esOscuro,
    required this.acento,
    required this.sobreAcento,
    required this.fondo,
    required this.principal,
    required this.secundario,
    required this.terciario,
    required this.opcionFondo,
    required this.opcionTexto,
    required this.accionSecundariaFondo,
    required this.accionSecundariaTexto,
    required this.cerrarFondo,
    required this.cerrarBorde,
    required this.barraFondo,
    required this.iconoInactivo,
    required this.tabNoSeleccionada,
    required this.campoFondo,
    required this.tarjetaFondo,
    required this.divisor,
    required this.diaEventos,
    required this.sombraTarjeta,
    required this.sombraBarra,
  });

  static const _fuente = 'Aller';
  static const _gris787878 = Color(0xFF787878);
  static const _grisA1A1A1 = Color(0xFFA1A1A1);

  final bool esOscuro;
  final Color acento;
  final Color sobreAcento;
  final Color fondo;
  final Color principal;
  final Color secundario;
  final Color terciario;
  final Color opcionFondo;
  final Color opcionTexto;
  final Color accionSecundariaFondo;
  final Color accionSecundariaTexto;
  final Color cerrarFondo;
  final Color cerrarBorde;
  final Color barraFondo;
  final Color iconoInactivo;
  final Color tabNoSeleccionada;
  final Color campoFondo;
  final Color tarjetaFondo;
  final Color divisor;
  final Color diaEventos;
  final List<BoxShadow> sombraTarjeta;
  final List<BoxShadow> sombraBarra;

  /// Texto sobre el acento: oscuro si el acento es claro, blanco si es oscuro.
  static Color _sobre(Color acento) =>
      acento.computeLuminance() > 0.35 ? AppColors.fondoOscuro : AppColors.blanco;

  factory AppTokens.oscuro(Color acento) => AppTokens(
        esOscuro: true,
        acento: acento,
        sobreAcento: _sobre(acento),
        fondo: AppColors.fondoOscuro,
        principal: const Color(0xFFFFFFFF),
        secundario: _grisA1A1A1,
        terciario: _gris787878,
        opcionFondo: const Color(0xFF363636),
        opcionTexto: const Color(0xFFBFBFBF),
        accionSecundariaFondo: const Color(0xFF434343),
        accionSecundariaTexto: const Color(0xFFFFFFFF),
        cerrarFondo: const Color(0xFF262626),
        cerrarBorde: _gris787878,
        barraFondo: const Color(0xFF262626),
        iconoInactivo: _gris787878,
        tabNoSeleccionada: const Color(0xFF363636),
        campoFondo: const Color(0xFF262626),
        tarjetaFondo: AppColors.fondoOscuro,
        divisor: const Color(0xFF363636),
        diaEventos: const Color(0xFFFFFFFF),
        sombraTarjeta: const [
          BoxShadow(
            color: Color(0x80121212), // #121212 al 50%
            offset: Offset(0, 4),
            blurRadius: 20,
            spreadRadius: 0.5,
          ),
        ],
        sombraBarra: const [
          BoxShadow(
            color: Color(0xFF191919),
            offset: Offset(4, 0),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      );

  factory AppTokens.claro(Color acento) => AppTokens(
        esOscuro: false,
        acento: acento,
        sobreAcento: _sobre(acento),
        fondo: const Color(0xFFFFFFFF),
        principal: const Color(0xFF000000),
        secundario: const Color(0xFF1C1C1C),
        terciario: const Color(0xFF4C4C4C),
        opcionFondo: const Color(0xFFF0F0F0),
        opcionTexto: const Color(0xFF606060),
        accionSecundariaFondo: const Color(0xFF000000),
        accionSecundariaTexto: const Color(0xFFFFFFFF),
        cerrarFondo: const Color(0xFFF0F0F0),
        cerrarBorde: _gris787878,
        barraFondo: const Color(0xFFF0F0F0),
        iconoInactivo: _gris787878,
        tabNoSeleccionada: const Color(0xFFF1F2F5),
        campoFondo: const Color(0xFFF0F0F0),
        tarjetaFondo: const Color(0xFFFFFFFF),
        divisor: const Color(0xFFE6E6E6),
        diaEventos: _gris787878,
        sombraTarjeta: const [
          BoxShadow(
            color: Color(0x80DFDEDE), // #DFDEDE al 50%
            offset: Offset(0, 4),
            blurRadius: 20,
            spreadRadius: 0.5,
          ),
        ],
        sombraBarra: const [
          BoxShadow(
            color: Color(0xFFDFDEDE),
            offset: Offset(4, 0),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      );

  TextStyle _estilo(double tamano, FontWeight peso, Color color) => TextStyle(
        fontFamily: _fuente,
        fontSize: tamano,
        fontWeight: peso,
        color: color,
      );

  // ---- Textos generales ----
  TextStyle get titulo => _estilo(24, FontWeight.w700, principal);
  TextStyle get subtitulo => _estilo(16, FontWeight.w300, principal);
  TextStyle get descripcion => _estilo(16, FontWeight.w400, secundario);
  TextStyle get placeholder => _estilo(16, FontWeight.w400, secundario);
  TextStyle get campo => _estilo(16, FontWeight.w400, principal);
  TextStyle get enlace => _estilo(16, FontWeight.w400, acento);

  // ---- Botones y tabs ----
  TextStyle get opcion => _estilo(12, FontWeight.w400, opcionTexto);
  TextStyle get accionPrincipal => _estilo(20, FontWeight.w400, sobreAcento);
  TextStyle get accionSecundaria =>
      _estilo(20, FontWeight.w400, accionSecundariaTexto);
  TextStyle get cerrar => _estilo(20, FontWeight.w400, principal);
  TextStyle get tab => _estilo(12, FontWeight.w400, AppColors.blanco);
  TextStyle get tabNoSeleccionadaTexto => _estilo(12, FontWeight.w400, principal);

  // ---- Cards ----
  TextStyle get cardTitulo => _estilo(12, FontWeight.w400, principal);
  TextStyle get cardDetalle => _estilo(11, FontWeight.w300, secundario);
  TextStyle get eventoTitulo => _estilo(12, FontWeight.w400, principal);
  TextStyle get fechaProximo => _estilo(32, FontWeight.w400, principal);
  TextStyle get diaProximo => _estilo(12, FontWeight.w400, _gris787878);
  TextStyle get fechaEventos => _estilo(24, FontWeight.w400, principal);
  TextStyle get diaEventosTexto => _estilo(12, FontWeight.w400, diaEventos);
  TextStyle get hora => _estilo(10, FontWeight.w300, _grisA1A1A1);
  TextStyle get lugar => _estilo(10, FontWeight.w400, _gris787878);

  @override
  AppTokens copyWith({Color? acento}) {
    if (acento == null) return this;
    return esOscuro ? AppTokens.oscuro(acento) : AppTokens.claro(acento);
  }

  @override
  AppTokens lerp(ThemeExtension<AppTokens>? other, double t) =>
      other is AppTokens && t >= 0.5 ? other : this;
}

extension AppTokensContext on BuildContext {
  AppTokens get tokens => Theme.of(this).extension<AppTokens>()!;
}
