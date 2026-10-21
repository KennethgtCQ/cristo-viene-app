import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/app_tokens.dart';

/// Imagen de red con relleno del color de campo mientras carga o si falla.
class AppImagen extends StatelessWidget {
  const AppImagen({super.key, required this.url, this.fit = BoxFit.cover});

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final relleno = ColoredBox(color: context.tokens.campoFondo);
    if (url.isEmpty) return relleno;
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      placeholder: (_, __) => relleno,
      errorWidget: (_, __, ___) => relleno,
    );
  }
}
