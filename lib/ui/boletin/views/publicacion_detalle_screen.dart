import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_encabezado.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_imagen.dart';
import '../../../data/models/contenido.dart';
import '../../../data/repositories/contenido_repository.dart';
import '../../../l10n/app_localizations.dart';

class PublicacionDetalleScreen extends StatelessWidget {
  const PublicacionDetalleScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final locale = Localizations.localeOf(context).toString();
    final repo = context.read<ContenidoRepository>();

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Publicacion?>(
          future: repo.publicacion(id),
          builder: (context, snap) {
            final p = snap.data;
            if (p == null) {
              return Column(
                children: [
                  AppEncabezado(titulo: '', onAtras: () => context.canPop() ? context.pop() : context.go('/inicio')),
                  const Expanded(child: SizedBox()),
                ],
              );
            }
            final parrafos = p.cuerpo.split('\n\n');
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppEncabezado(titulo: '', onAtras: () => context.canPop() ? context.pop() : context.go('/inicio')),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 0, AppSizes.paddingPantalla, 32),
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.radio),
                        child: SizedBox(height: 220, width: double.infinity, child: AppImagen(url: p.imagenUrl)),
                      ),
                      const SizedBox(height: 18),
                      Text(p.autor, style: t.lugar),
                      const SizedBox(height: 12),
                      Text(p.categoria, style: t.lugar.copyWith(letterSpacing: 2)),
                      const SizedBox(height: 6),
                      Text(p.titulo, style: t.subtitulo),
                      const SizedBox(height: 4),
                      Text(DateFormat.yMMMd(locale).format(p.fecha), style: t.hora),
                      const SizedBox(height: 16),
                      Divider(color: t.divisor, height: 1),
                      const SizedBox(height: 16),
                      for (final parrafo in parrafos) ...[
                        Text(parrafo, style: t.descripcion),
                        const SizedBox(height: 14),
                      ],
                      Divider(color: t.divisor, height: 1),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          AppIcon(AppIcons.corazon, size: 20, color: t.acento),
                          const SizedBox(width: 6),
                          Text('${p.meGustas}', style: t.cardTitulo),
                          const SizedBox(width: 20),
                          AppIcon(AppIcons.comentario, size: 20, color: t.principal),
                          const SizedBox(width: 6),
                          Text('${p.comentarios}', style: t.cardTitulo),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
