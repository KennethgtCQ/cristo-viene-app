import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_encabezado.dart';
import '../../../core/widgets/app_tabs.dart';
import '../../../data/models/contenido.dart';
import '../../../data/repositories/contenido_repository.dart';
import '../../../l10n/app_localizations.dart';

class MisPeticionesScreen extends StatefulWidget {
  const MisPeticionesScreen({super.key});

  @override
  State<MisPeticionesScreen> createState() => _MisPeticionesScreenState();
}

class _MisPeticionesScreenState extends State<MisPeticionesScreen> {
  int _pestana = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    final locale = Localizations.localeOf(context).toString();
    final repo = context.read<ContenidoRepository>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppEncabezado(
              titulo: l10n.misPeticionesTitulo,
              onAtras: () => context.canPop() ? context.pop() : context.go('/oraciones'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 8, AppSizes.paddingPantalla, 12),
              child: Text(l10n.misPeticionesDescripcion, style: t.subtituloTenue),
            ),
            AppTabs(
              etiquetas: [l10n.activas, l10n.inactivas],
              seleccionada: _pestana,
              onSeleccion: (i) => setState(() => _pestana = i),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Peticion>>(
                future: repo.misPeticiones(),
                builder: (context, snap) {
                  final lista = (snap.data ?? const <Peticion>[])
                      .where((p) => p.activa == (_pestana == 0))
                      .toList();
                  if (lista.isEmpty) return Center(child: Text(l10n.sinContenido));
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 0, AppSizes.paddingPantalla, 24),
                    itemCount: lista.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (_, i) {
                      final p = lista[i];
                      return AppCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.titulo, style: t.cardTitulo),
                            Text(DateFormat.yMMMd(locale).format(p.fecha), style: t.hora),
                            const SizedBox(height: 10),
                            Text(p.texto, style: t.descripcion),
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
      ),
    );
  }
}
