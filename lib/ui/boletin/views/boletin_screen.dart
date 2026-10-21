import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_encabezado.dart';
import '../../../core/widgets/app_imagen.dart';
import '../../../data/models/contenido.dart';
import '../../../data/repositories/contenido_repository.dart';
import '../../../l10n/app_localizations.dart';

class BoletinScreen extends StatelessWidget {
  const BoletinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    final repo = context.read<ContenidoRepository>();
    final locale = Localizations.localeOf(context).toString();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppEncabezado(titulo: l10n.accesoBoletin, onAtras: () => context.go('/inicio')),
            Expanded(
              child: FutureBuilder<List<Publicacion>>(
                future: repo.publicaciones(),
                builder: (context, snap) {
                  final todas = snap.data ?? const <Publicacion>[];
                  if (todas.isEmpty) return Center(child: Text(l10n.sinContenido));
                  final destacadas = todas.where((p) => p.destacada).toList();
                  return ListView(
                    padding: const EdgeInsets.only(bottom: 32),
                    children: [
                      if (destacadas.isNotEmpty)
                        SizedBox(
                          height: 240,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingPantalla),
                            itemCount: destacadas.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 14),
                            itemBuilder: (_, i) => _Destacada(publicacion: destacadas[i]),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 24, AppSizes.paddingPantalla, 12),
                        child: Text(l10n.loMasReciente, style: t.subtitulo),
                      ),
                      for (final p in todas)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 0, AppSizes.paddingPantalla, 14),
                          child: AppCard(
                            onTap: () => context.push('/boletin/${p.id}'),
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(AppSizes.radio),
                                  child: SizedBox(width: 110, height: 96, child: AppImagen(url: p.imagenUrl)),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(DateFormat.yMMMd(locale).format(p.fecha), style: t.hora),
                                      const SizedBox(height: 4),
                                      Text(p.titulo, style: t.cardTitulo, maxLines: 2, overflow: TextOverflow.ellipsis),
                                      const SizedBox(height: 4),
                                      Text(p.resumen, style: t.cardDetalle, maxLines: 2, overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Destacada extends StatelessWidget {
  const _Destacada({required this.publicacion});

  final Publicacion publicacion;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return SizedBox(
      width: 300,
      child: AppCard(
        onTap: () => context.push('/boletin/${publicacion.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radio),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppImagen(url: publicacion.imagenUrl),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x00000000), Color(0xCC000000)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(publicacion.categoria, style: t.lugar.copyWith(color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(publicacion.titulo, style: t.cardTitulo.copyWith(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
