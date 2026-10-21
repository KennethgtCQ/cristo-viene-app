import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_tokens.dart';

/// Tarjeta con radio 15 y la sombra de Figma (X0 Y4 blur 20 spread 0.5).
class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.padding, this.onTap});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final radio = BorderRadius.circular(AppSizes.radio);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: t.tarjetaFondo,
        borderRadius: radio,
        boxShadow: t.sombraTarjeta,
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: radio,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
        ),
      ),
    );
  }
}
