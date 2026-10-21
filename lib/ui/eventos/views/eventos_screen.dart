import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/app_cabecera.dart';
import '../../../core/widgets/app_tabs.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/models/contenido.dart';
import '../../../data/repositories/contenido_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/tarjeta_evento.dart';

class EventosScreen extends StatefulWidget {
  const EventosScreen({super.key});

  @override
  State<EventosScreen> createState() => _EventosScreenState();
}

class _EventosScreenState extends State<EventosScreen> {
  int _pestana = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final repo = context.read<ContenidoRepository>();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 16, AppSizes.paddingPantalla, 0),
            child: AppCabecera(titulo: l10n.navEventos),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingPantalla),
            child: AppTextField(hint: l10n.buscar, icono: AppIcons.buscar),
          ),
          const SizedBox(height: 16),
          AppTabs(
            etiquetas: [l10n.proximos, l10n.pasados],
            seleccionada: _pestana,
            onSeleccion: (i) => setState(() => _pestana = i),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<Evento>>(
              future: repo.eventos(),
              builder: (context, snap) {
                final todos = snap.data ?? const <Evento>[];
                final lista = todos.where((e) => _pestana == 0 ? e.esProximo : !e.esProximo).toList();
                if (lista.isEmpty) {
                  return Center(child: Text(l10n.sinContenido));
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 0, AppSizes.paddingPantalla, 24),
                  itemCount: lista.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (_, i) => TarjetaEvento(evento: lista[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
