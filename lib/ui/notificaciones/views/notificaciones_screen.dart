import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_encabezado.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_tabs.dart';
import '../../../data/models/contenido.dart';
import '../../../data/repositories/contenido_repository.dart';
import '../../../l10n/app_localizations.dart';

class NotificacionesScreen extends StatefulWidget {
  const NotificacionesScreen({super.key});

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  // null = todas; el resto corresponde al índice de cada filtro.
  static const _filtros = <TipoNotificacion?>[null, TipoNotificacion.evento, TipoNotificacion.anuncio, TipoNotificacion.ministerio];
  int _pestana = 0;

  static String _icono(TipoNotificacion tipo) => switch (tipo) {
        TipoNotificacion.evento => AppIcons.campana,
        TipoNotificacion.anuncio => AppIcons.megafono,
        TipoNotificacion.recordatorio => AppIcons.calendario,
        TipoNotificacion.peticion => AppIcons.manos,
        TipoNotificacion.ministerio => AppIcons.grupo,
      };

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
              titulo: l10n.notificacionesTitulo,
              onAtras: () => context.canPop() ? context.pop() : context.go('/inicio'),
            ),
            const SizedBox(height: 8),
            AppTabs(
              etiquetas: [l10n.filtroTodas, l10n.filtroEventos, l10n.filtroAnuncios, l10n.filtroMinisterios],
              seleccionada: _pestana,
              onSeleccion: (i) => setState(() => _pestana = i),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Notificacion>>(
                future: repo.notificaciones(),
                builder: (context, snap) {
                  final filtro = _filtros[_pestana];
                  final lista = (snap.data ?? const <Notificacion>[])
                      .where((n) => filtro == null || n.tipo == filtro)
                      .toList();
                  if (lista.isEmpty) return Center(child: Text(l10n.sinContenido));
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 0, AppSizes.paddingPantalla, 24),
                    itemCount: lista.length,
                    separatorBuilder: (_, __) => Divider(color: t.divisor, height: 24),
                    itemBuilder: (_, i) {
                      final n = lista[i];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(color: t.acento, shape: BoxShape.circle),
                            child: Center(child: AppIcon(_icono(n.tipo), size: 24, color: t.sobreAcento)),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(n.titulo, style: t.cardTitulo.copyWith(fontWeight: FontWeight.w700)),
                                Text(n.subtitulo, style: t.cardTitulo),
                                Text(n.detalle, style: t.cardDetalle),
                              ],
                            ),
                          ),
                          Text(DateFormat.Md(locale).format(n.fecha), style: t.hora),
                        ],
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
