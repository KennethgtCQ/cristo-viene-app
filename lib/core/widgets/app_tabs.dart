import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_tokens.dart';

/// Tabs en forma de píldora (Próximos / Pasados, Discipulado / Nuevas generaciones...).
class AppTabs extends StatelessWidget {
  const AppTabs({
    super.key,
    required this.etiquetas,
    required this.seleccionada,
    required this.onSeleccion,
  });

  final List<String> etiquetas;
  final int seleccionada;
  final ValueChanged<int> onSeleccion;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return SizedBox(
      height: AppSizes.alturaTab,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingPantalla),
        itemCount: etiquetas.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (_, i) {
          final activa = i == seleccionada;
          return Material(
            color: activa ? t.acento : t.tabNoSeleccionada,
            borderRadius: BorderRadius.circular(AppSizes.radioPildora),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => onSeleccion(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Center(
                  child: Text(
                    etiquetas[i],
                    style: activa ? t.tab : t.tabNoSeleccionadaTexto,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
