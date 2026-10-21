import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../theme/app_tokens.dart';

/// Marcador temporal para pantallas que aún no se construyen.
class PantallaPendiente extends StatelessWidget {
  const PantallaPendiente({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(titulo, style: t.titulo),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context).proximamente, style: t.descripcion),
          ],
        ),
      ),
    );
  }
}
