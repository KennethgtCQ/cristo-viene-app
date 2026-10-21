import 'package:flutter/material.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../l10n/app_localizations.dart';

/// Divisor "O Continuar Con" + botones de Google y Apple.
class BotonesSociales extends StatelessWidget {
  const BotonesSociales({
    super.key,
    required this.onGoogle,
    required this.onApple,
    this.espacioSuperior = 26,
  });

  final VoidCallback? onGoogle;
  final VoidCallback? onApple;
  final double espacioSuperior;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        SizedBox(height: espacioSuperior),
        Row(
          children: [
            Expanded(child: Divider(color: t.divisor, thickness: 0.5, height: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(l10n.oContinuarCon, style: t.divisorTexto),
            ),
            Expanded(child: Divider(color: t.divisor, thickness: 0.5, height: 1)),
          ],
        ),
        const SizedBox(height: 32),
        AppButton(
          texto: l10n.google,
          tipo: AppButtonTipo.secundario,
          icono: AppIcons.google,
          tintarIcono: false,
          onPressed: onGoogle,
        ),
        const SizedBox(height: 14),
        AppButton(
          texto: l10n.apple,
          tipo: AppButtonTipo.secundario,
          icono: AppIcons.apple,
          onPressed: onApple,
        ),
      ],
    );
  }
}
