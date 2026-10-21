import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_tokens.dart';
import 'app_icon.dart';
import 'app_logo.dart';

/// Navegación lateral para web/escritorio (sustituye a la barra inferior).
class AppRail extends StatelessWidget {
  const AppRail({
    super.key,
    required this.destinos,
    required this.indiceActual,
    required this.onSeleccion,
  });

  final List<(String, String)> destinos; // (icono, etiqueta)
  final int indiceActual;
  final ValueChanged<int> onSeleccion;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      width: 240,
      decoration: BoxDecoration(color: t.barraFondo),
      child: SafeArea(
        right: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 28, 24, 32),
              child: AppLogo(ancho: 110),
            ),
            for (var i = 0; i < destinos.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: _ItemRail(
                  icono: destinos[i].$1,
                  etiqueta: destinos[i].$2,
                  activo: i == indiceActual,
                  onTap: () => onSeleccion(i),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ItemRail extends StatelessWidget {
  const _ItemRail({
    required this.icono,
    required this.etiqueta,
    required this.activo,
    required this.onTap,
  });

  final String icono;
  final String etiqueta;
  final bool activo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Material(
      color: activo ? t.acento.withValues(alpha: 0.15) : Colors.transparent,
      borderRadius: BorderRadius.circular(AppSizes.radio),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.radio),
        onTap: onTap,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              AppIcon(icono, size: 22, color: activo ? t.acento : t.iconoInactivo),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  etiqueta,
                  style: t.campo.copyWith(
                    color: activo ? t.acento : t.principal,
                    fontWeight: activo ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
