import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/placeholders.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../l10n/app_localizations.dart';
import '../../perfil/view_models/preferencias_view_model.dart';

/// Pantalla de bienvenida: siempre en estilo oscuro, con el acento elegido.
class BienvenidaScreen extends StatelessWidget {
  const BienvenidaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorAcento = context.watch<PreferenciasViewModel>().preferencias.colorAcento;
    final l10n = AppLocalizations.of(context);

    return Theme(
      data: AppTheme.oscuro(colorAcento == null ? null : Color(colorAcento)),
      child: Builder(
        builder: (context) {
          final t = context.tokens;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Scaffold(
              body: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: AppPlaceholders.bienvenida,
                    fit: BoxFit.cover,
                    errorWidget: (_, _, _) => const ColoredBox(color: AppColors.fondoOscuro),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x00000000), Color(0xE6000000)],
                        stops: [0.45, 0.85],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(38, 0, 38, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(flex: 4),
                          const Center(child: AppLogo(ancho: 187, color: AppColors.blanco)),
                          const Spacer(flex: 5),
                          Text(
                            l10n.bienvenidaTitulo,
                            style: t.titulo.copyWith(height: 1.4, color: AppColors.blanco),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.bienvenidaSubtitulo,
                            style: t.subtitulo.copyWith(height: 1.2, color: AppColors.blanco),
                          ),
                          const SizedBox(height: 28),
                          AppButton(texto: l10n.empezar, onPressed: () => context.go('/login')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
