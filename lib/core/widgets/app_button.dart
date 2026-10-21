import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_tokens.dart';

enum AppButtonTipo { principal, secundario, cerrar }

/// Botón de ancho completo. Principal (acento), secundario o cerrar (con borde).
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.texto,
    required this.onPressed,
    this.tipo = AppButtonTipo.principal,
  });

  final String texto;
  final VoidCallback? onPressed;
  final AppButtonTipo tipo;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final (Color fondo, TextStyle estilo, BorderSide borde) = switch (tipo) {
      AppButtonTipo.principal => (t.acento, t.accionPrincipal, BorderSide.none),
      AppButtonTipo.secundario => (
          t.accionSecundariaFondo,
          t.accionSecundaria,
          BorderSide.none
        ),
      AppButtonTipo.cerrar => (
          t.cerrarFondo,
          t.cerrar,
          BorderSide(color: t.cerrarBorde, width: 0.5)
        ),
    };
    final forma = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radio),
      side: borde,
    );

    return Opacity(
      opacity: onPressed == null ? 0.5 : 1,
      child: SizedBox(
        height: AppSizes.alturaControl,
        width: double.infinity,
        child: Material(
          color: fondo,
          shape: forma,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: Center(child: Text(texto, style: estilo)),
          ),
        ),
      ),
    );
  }
}
