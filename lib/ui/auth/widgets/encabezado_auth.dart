import 'package:flutter/material.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_logo.dart';

/// Logo + título + subtítulo (texto o widget) centrados.
class EncabezadoAuth extends StatelessWidget {
  const EncabezadoAuth({
    super.key,
    required this.titulo,
    this.descripcion,
    this.subtitulo,
    this.espacioTrasLogo = 28,
  });

  final String titulo;
  final String? descripcion;
  final Widget? subtitulo;
  final double espacioTrasLogo;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Column(
      children: [
        const AppLogo(),
        SizedBox(height: espacioTrasLogo),
        Text(titulo, style: t.titulo, textAlign: TextAlign.center),
        if (descripcion != null) ...[
          const SizedBox(height: 12),
          Text(descripcion!, style: t.subtituloTenue, textAlign: TextAlign.center),
        ],
        if (subtitulo != null) ...[
          const SizedBox(height: 12),
          subtitulo!,
        ],
      ],
    );
  }
}

/// "¿Ya tienes cuenta?  Iniciar Sesión" (texto tenue + enlace de acento).
class FraseConEnlace extends StatelessWidget {
  const FraseConEnlace({
    super.key,
    required this.pregunta,
    required this.enlace,
    required this.onTap,
  });

  final String pregunta;
  final String enlace;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      children: [
        Text(pregunta, style: t.subtituloTenue),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(enlace, style: t.enlace),
          ),
        ),
      ],
    );
  }
}
