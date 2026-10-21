import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/contenido_biblia.dart';
import '../../../core/constants/placeholders.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_encabezado.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_imagen.dart';
import '../../../l10n/app_localizations.dart';

class BibliaScreen extends StatelessWidget {
  const BibliaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppEncabezado(titulo: l10n.accesoBiblia, onAtras: () => context.go('/inicio')),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 8, AppSizes.paddingPantalla, 32),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.radio),
                    child: SizedBox(
                      height: 170,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AppImagen(url: AppPlaceholders.hero),
                          const DecoratedBox(decoration: BoxDecoration(color: Color(0x66000000))),
                          Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('"${ContenidoBiblia.versiculo}"', style: t.titulo.copyWith(color: Colors.white, fontSize: 20)),
                                const SizedBox(height: 4),
                                Text(ContenidoBiblia.referencia, style: t.subtituloTenue.copyWith(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(l10n.libros, style: t.subtitulo),
                  const SizedBox(height: 8),
                  for (final libro in ContenidoBiblia.libros)
                    InkWell(
                      onTap: () => ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(l10n.proximamente))),
                      child: Container(
                        height: 46,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: t.divisor, width: 0.5))),
                        child: Row(
                          children: [
                            Expanded(child: Text(libro, style: t.campo.copyWith(fontSize: 15))),
                            AppIcon(AppIcons.flechaDerecha, size: 16, color: t.secundario),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
