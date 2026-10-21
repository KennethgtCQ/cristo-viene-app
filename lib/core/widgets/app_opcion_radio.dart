import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_tokens.dart';

/// Fila seleccionable con radio a la derecha (género, idioma...).
class AppOpcionRadio extends StatelessWidget {
  const AppOpcionRadio({
    super.key,
    required this.texto,
    required this.seleccionada,
    required this.onTap,
  });

  final String texto;
  final bool seleccionada;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      button: true,
      selected: seleccionada,
      child: Material(
        color: t.campoFondo,
        borderRadius: BorderRadius.circular(AppSizes.radio),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: AppSizes.alturaControl,
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Row(
              children: [
                Expanded(child: Text(texto, style: t.campo.copyWith(fontSize: 14))),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: seleccionada ? t.acento : Colors.transparent,
                    border: seleccionada ? null : Border.all(color: t.terciario),
                  ),
                  child: seleccionada
                      ? Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: t.sobreAcento,
                            ),
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
