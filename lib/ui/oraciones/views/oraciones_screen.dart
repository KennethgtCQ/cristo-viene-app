import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/placeholders.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_encabezado.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_imagen.dart';
import '../../../data/models/contenido.dart';
import '../../../data/repositories/contenido_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/nueva_peticion_dialogo.dart';

class OracionesScreen extends StatefulWidget {
  const OracionesScreen({super.key});

  @override
  State<OracionesScreen> createState() => _OracionesScreenState();
}

class _OracionesScreenState extends State<OracionesScreen> {
  late Future<List<Peticion>> _future = context.read<ContenidoRepository>().peticiones();

  Future<void> _nueva() async {
    final enviada = await showDialog<bool>(
      context: context,
      builder: (_) => const NuevaPeticionDialogo(),
    );
    if (enviada == true && mounted) {
      final l10n = AppLocalizations.of(context);
      setState(() => _future = context.read<ContenidoRepository>().peticiones());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.peticionEnviada)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    final locale = Localizations.localeOf(context).toString();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppEncabezado(
              titulo: l10n.accesoOraciones,
              onAtras: () => context.canPop() ? context.pop() : context.go('/inicio'),
            ),
            Expanded(
              child: FutureBuilder<List<Peticion>>(
                future: _future,
                builder: (context, snap) {
                  final lista = snap.data ?? const <Peticion>[];
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 8, AppSizes.paddingPantalla, 32),
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.radio),
                        child: SizedBox(
                          height: 150,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              AppImagen(url: AppPlaceholders.hero),
                              const DecoratedBox(decoration: BoxDecoration(color: Color(0x66000000))),
                              Padding(
                                padding: const EdgeInsets.all(18),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(l10n.peticionesTitulo, style: t.titulo.copyWith(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(l10n.peticionesDescripcion, style: t.subtituloTenue),
                      const SizedBox(height: 18),
                      AppButton(texto: l10n.agregarPeticion, onPressed: _nueva),
                      const SizedBox(height: 12),
                      AppButton(
                        texto: l10n.misPeticionesTitulo,
                        tipo: AppButtonTipo.cerrar,
                        onPressed: () => context.push('/oraciones/mias'),
                      ),
                      const SizedBox(height: 20),
                      for (final p in lista) ...[
                        _TarjetaPeticion(peticion: p, locale: locale),
                        const SizedBox(height: 14),
                      ],
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

/// Tarjeta de petición: autor (o anónimo), fecha, texto y contadores.
class _TarjetaPeticion extends StatelessWidget {
  const _TarjetaPeticion({required this.peticion, required this.locale});

  final Peticion peticion;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    final nombre = peticion.anonima ? l10n.anonimo : peticion.autor;

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nombre, style: t.cardTitulo),
          Text(DateFormat.yMMMd(locale).format(peticion.fecha), style: t.hora),
          const SizedBox(height: 10),
          Text(peticion.texto, style: t.descripcion),
          const SizedBox(height: 12),
          Divider(color: t.divisor, height: 1),
          const SizedBox(height: 10),
          Row(
            children: [
              AppIcon(AppIcons.manos, size: 18, color: t.principal),
              const SizedBox(width: 6),
              Text('${peticion.oraciones}', style: t.cardDetalle),
              const SizedBox(width: 18),
              AppIcon(AppIcons.comentario, size: 18, color: t.principal),
              const SizedBox(width: 6),
              Text('${peticion.comentarios}', style: t.cardDetalle),
            ],
          ),
        ],
      ),
    );
  }
}
