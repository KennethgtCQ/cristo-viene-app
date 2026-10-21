import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_tokens.dart';
import 'app_icon.dart';

enum AppButtonTipo { principal, secundario, cerrar }

/// Botón de ancho completo. Principal (acento), secundario o cerrar (con borde).
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.texto,
    required this.onPressed,
    this.tipo = AppButtonTipo.principal,
    this.icono,
    this.tintarIcono = true,
    this.cargando = false,
  });

  final String texto;
  final VoidCallback? onPressed;
  final AppButtonTipo tipo;
  final String? icono;
  final bool tintarIcono; // false para iconos a color (Google)
  final bool cargando; // muestra un indicador y bloquea el toque

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
      opacity: onPressed == null && !cargando ? 0.5 : 1,
      child: SizedBox(
        height: AppSizes.alturaControl,
        width: double.infinity,
        child: Material(
          color: fondo,
          shape: forma,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: cargando ? null : onPressed,
            child: Center(
              child: cargando
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2, color: estilo.color),
                    )
                  : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icono != null) ...[
                    AppIcon(icono!, size: 24, color: tintarIcono ? estilo.color : null),
                    const SizedBox(width: 12),
                  ],
                  Text(texto, style: estilo),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
