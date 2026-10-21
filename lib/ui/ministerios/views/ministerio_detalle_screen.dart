import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_encabezado.dart';
import '../../../core/widgets/app_imagen.dart';
import '../../../data/models/contenido.dart';
import '../../../data/repositories/contenido_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../../eventos/widgets/tarjeta_evento.dart';

class MinisterioDetalleScreen extends StatelessWidget {
  const MinisterioDetalleScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    final repo = context.read<ContenidoRepository>();

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Ministerio?>(
          future: repo.ministerio(id),
          builder: (context, snap) {
            final m = snap.data;
            if (m == null) {
              return Column(
                children: [
                  AppEncabezado(titulo: '', onAtras: () => context.canPop() ? context.pop() : context.go('/inicio')),
                  Expanded(child: Center(child: Text(l10n.sinContenido))),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppEncabezado(titulo: m.nombre, onAtras: () => context.canPop() ? context.pop() : context.go('/inicio')),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 12, AppSizes.paddingPantalla, 32),
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.radio),
                        child: SizedBox(height: 200, width: double.infinity, child: AppImagen(url: m.imagenUrl)),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _Dato(etiqueta: l10n.ministerioEdades, valor: m.edades),
                          _Dato(etiqueta: l10n.ministerioReuniones, valor: m.reunion),
                          _Dato(etiqueta: l10n.ministerioLugar, valor: m.lugar),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(l10n.sobreEsteMinisterio, style: t.subtitulo),
                      const SizedBox(height: 8),
                      Text(m.descripcion, style: t.descripcion),
                      const SizedBox(height: 28),
                      Text(l10n.proximosEventos, style: t.subtitulo),
                      const SizedBox(height: 12),
                      if (m.eventos.isEmpty)
                        Text(l10n.sinContenido, style: t.descripcion)
                      else
                        for (final e in m.eventos) ...[
                          TarjetaEvento(evento: e),
                          const SizedBox(height: 12),
                        ],
                      const SizedBox(height: 16),
                      AppButton(
                        texto: l10n.unirme,
                        onPressed: () => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(l10n.proximamente))),
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

class _Dato extends StatelessWidget {
  const _Dato({required this.etiqueta, required this.valor});

  final String etiqueta;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(etiqueta, style: t.lugar),
          const SizedBox(height: 4),
          Text(valor, style: t.cardTitulo),
        ],
      ),
    );
  }
}
