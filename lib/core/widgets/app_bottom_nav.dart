import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_tokens.dart';
import 'app_icon.dart';

class AppBottomNavItem {
  const AppBottomNavItem({required this.icono, required this.etiqueta});
  final String icono;
  final String etiqueta; // solo para accesibilidad
}

/// Barra de navegación inferior solo con iconos (activo: acento, inactivo: #787878).
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.items,
    required this.indiceActual,
    required this.onSeleccion,
  });

  final List<AppBottomNavItem> items;
  final int indiceActual;
  final ValueChanged<int> onSeleccion;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return DecoratedBox(
      decoration: BoxDecoration(color: t.barraFondo, boxShadow: t.sombraBarra),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppSizes.alturaBarraNav,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: Semantics(
                    button: true,
                    selected: i == indiceActual,
                    label: items[i].etiqueta,
                    child: InkWell(
                      onTap: () => onSeleccion(i),
                      child: Center(
                        child: AppIcon(
                          items[i].icono,
                          color: i == indiceActual ? t.acento : t.iconoInactivo,
                        ),
                      ),
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
