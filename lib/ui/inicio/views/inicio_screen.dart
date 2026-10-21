import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/placeholders.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_cabecera.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_imagen.dart';
import '../../../data/models/contenido.dart';
import '../../../data/repositories/contenido_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../eventos/widgets/tarjeta_evento.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    final nombre = context.watch<AuthViewModel>().usuario?.nombre ?? '';
    final repo = context.read<ContenidoRepository>();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 16, AppSizes.paddingPantalla, 32),
        children: [
          AppCabecera(titulo: l10n.holaNombre(nombre), subtitulo: l10n.esUnGustoTenerteAqui),
          const SizedBox(height: 24),
          const _Hero(),
          const SizedBox(height: 20),
          const _AccesosRapidos(),
          const SizedBox(height: 28),
          Text(l10n.proximoEvento, style: t.subtitulo),
          const SizedBox(height: 12),
          FutureBuilder<List<Evento>>(
            future: repo.eventos(),
            builder: (context, snap) {
              final proximos = (snap.data ?? const <Evento>[]).where((e) => e.esProximo).toList();
              if (proximos.isEmpty) return _Vacio(texto: l10n.sinContenido);
              return TarjetaEvento(evento: proximos.first);
            },
          ),
          const SizedBox(height: 28),
          Text(l10n.noticias, style: t.subtitulo),
          const SizedBox(height: 12),
          FutureBuilder<List<Publicacion>>(
            future: repo.publicaciones(),
            builder: (context, snap) {
              final noticias = (snap.data ?? const <Publicacion>[]).take(2).toList();
              if (noticias.isEmpty) return _Vacio(texto: l10n.sinContenido);
              return Row(
                children: [
                  for (var i = 0; i < noticias.length; i++) ...[
                    if (i > 0) const SizedBox(width: 12),
                    Expanded(
                      child: AppCard(
                        onTap: () => context.push('/boletin/${noticias[i].id}'),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 96,
                              width: double.infinity,
                              child: AppImagen(url: noticias[i].imagenUrl),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(noticias[i].titulo, style: t.cardTitulo, maxLines: 2, overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radio),
      child: SizedBox(
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppImagen(url: AppPlaceholders.hero),
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
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.unaIglesiaUnaFamilia, style: t.titulo.copyWith(color: Colors.white)),
                  const SizedBox(height: 6),
                  Text(l10n.heroDescripcion, style: t.subtitulo.copyWith(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccesosRapidos extends StatelessWidget {
  const _AccesosRapidos();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final accesos = [
      (AppIcons.biblia, l10n.accesoBiblia, '/biblia'),
      (AppIcons.boletin, l10n.accesoBoletin, '/boletin'),
      (AppIcons.ofrendar, l10n.accesoOfrendar, '/ofrendas'),
      (AppIcons.oraciones, l10n.accesoOraciones, '/oraciones'),
    ];
    return Row(
      children: [
        for (var i = 0; i < accesos.length; i++) ...[
          if (i > 0) const SizedBox(width: 10),
          Expanded(child: _Acceso(icono: accesos[i].$1, etiqueta: accesos[i].$2, ruta: accesos[i].$3)),
        ],
      ],
    );
  }
}

class _Acceso extends StatelessWidget {
  const _Acceso({required this.icono, required this.etiqueta, required this.ruta});

  final String icono;
  final String etiqueta;
  final String ruta;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return AppCard(
      onTap: () => context.push(ruta),
      child: AspectRatio(
        aspectRatio: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIcon(icono, size: 28, color: t.principal),
            const SizedBox(height: 8),
            Text(etiqueta, style: t.opcion.copyWith(color: t.principal)),
          ],
        ),
      ),
    );
  }
}

class _Vacio extends StatelessWidget {
  const _Vacio({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(texto, style: context.tokens.descripcion),
      );
}
