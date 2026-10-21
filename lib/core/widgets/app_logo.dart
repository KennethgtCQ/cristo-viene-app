import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_icons.dart';
import '../theme/app_tokens.dart';

/// Logo de Cristo Viene (SVG monocromo), teñido con el color principal del tema.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.ancho = 116, this.color});

  final double ancho;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Cristo Viene',
      image: true,
      child: SvgPicture.asset(
        AppIcons.logo,
        width: ancho,
        colorFilter: ColorFilter.mode(color ?? context.tokens.principal, BlendMode.srcIn),
      ),
    );
  }
}
