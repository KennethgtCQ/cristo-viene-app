import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_cabecera.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_imagen.dart';
import '../../../core/widgets/app_tabs.dart';
import '../../../data/models/contenido.dart';
import '../../../data/repositories/contenido_repository.dart';
import '../../../l10n/app_localizations.dart';

class PredicasScreen extends StatefulWidget {
  const PredicasScreen({super.key});

  @override
  State<PredicasScreen> createState() => _PredicasScreenState();
}

class _PredicasScreenState extends State<PredicasScreen> {
  int _pestana = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    final repo = context.read<ContenidoRepository>();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 16, AppSizes.paddingPantalla, 0),
            child: AppCabecera(titulo: l10n.navPredicas),
          ),
          const SizedBox(height: 20),
          AppTabs(
            etiquetas: [l10n.proximos, l10n.pasados],
            seleccionada: _pestana,
            onSeleccion: (i) => setState(() => _pestana = i),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<Predica>>(
              future: repo.predicas(),
              builder: (context, snap) {
                final todas = snap.data ?? const <Predica>[];
                final lista = todas.where((p) => _pestana == 0 ? p.esProxima : !p.esProxima).toList();
                if (lista.isEmpty) return Center(child: Text(l10n.sinContenido));
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 0, AppSizes.paddingPantalla, 24),
                  itemCount: lista.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (_, i) {
                    final p = lista[i];
                    return AppCard(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 110,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppSizes.radio),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  AppImagen(url: p.imagenUrl),
                                  Positioned(
                                    right: 8,
                                    bottom: 8,
                                    child: AppIcon(AppIcons.reproducir, size: 30, color: t.acento),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.serie, style: t.lugar),
                                const SizedBox(height: 2),
                                Text(p.titulo, style: t.eventoTitulo),
                                const SizedBox(height: 8),
                                Text(l10n.minutos(p.minutos), style: t.hora),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
