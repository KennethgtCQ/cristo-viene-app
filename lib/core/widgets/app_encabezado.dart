import 'package:flutter/material.dart';
import '../constants/app_icons.dart';
import '../constants/app_sizes.dart';
import '../theme/app_tokens.dart';
import 'app_icon.dart';

/// Flecha de regreso con área táctil de 48 x 48.
class AppBotonAtras extends StatelessWidget {
  const AppBotonAtras({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: AppIcon(AppIcons.atras, size: 24, color: context.tokens.principal),
    );
  }
}

/// Encabezado de pantalla: flecha + título (24 Bold).
class AppEncabezado extends StatelessWidget {
  const AppEncabezado({super.key, required this.titulo, required this.onAtras});

  final String titulo;
  final VoidCallback onAtras;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla - 12, 4, AppSizes.paddingPantalla, 0),
      child: Row(
        children: [
          AppBotonAtras(onPressed: onAtras),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              titulo,
              style: context.tokens.titulo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
