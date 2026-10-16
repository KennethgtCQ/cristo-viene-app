import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_sizes.dart';

/// Icono SVG de assets/icons, teñido con [color].
class AppIcon extends StatelessWidget {
  const AppIcon(this.asset, {super.key, this.size = AppSizes.iconoNav, this.color});

  final String asset;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      colorFilter:
          color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}
