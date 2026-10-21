import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_cabecera.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_imagen.dart';
import '../../../core/widgets/app_tabs.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/models/contenido.dart';
import '../../../data/repositories/contenido_repository.dart';
import '../../../l10n/app_localizations.dart';

class MinisteriosScreen extends StatefulWidget {
  const MinisteriosScreen({super.key});

  @override
  State<MinisteriosScreen> createState() => _MinisteriosScreenState();
}

class _MinisteriosScreenState extends State<MinisteriosScreen> {
  static const _categorias = ['discipulado', 'nuevas'];
  int _pestana = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final repo = context.read<ContenidoRepository>();
    final etiquetas = [l10n.categoriaDiscipulado, l10n.categoriaNuevasGeneraciones];

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 16, AppSizes.paddingPantalla, 0),
            child: AppCabecera(titulo: l10n.navMinisterios),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingPantalla),
            child: AppTextField(hint: l10n.buscar, icono: AppIcons.buscar),
          ),
          const SizedBox(height: 16),
          AppTabs(
            etiquetas: etiquetas,
            seleccionada: _pestana,
            onSeleccion: (i) => setState(() => _pestana = i),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<Ministerio>>(
              future: repo.ministerios(),
              builder: (context, snap) {
                final lista = (snap.data ?? const <Ministerio>[])
                    .where((m) => m.categoriaId == _categorias[_pestana])
                    .toList();
                if (lista.isEmpty) return Center(child: Text(l10n.sinContenido));
                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 0, AppSizes.paddingPantalla, 24),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 260,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 1.35,
                  ),
                  itemCount: lista.length,
                  itemBuilder: (_, i) => _TarjetaMinisterio(ministerio: lista[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TarjetaMinisterio extends StatelessWidget {
  const _TarjetaMinisterio({required this.ministerio});

  final Ministerio ministerio;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radio),
      child: Material(
        child: InkWell(
          onTap: () => context.push('/ministerios/${ministerio.id}'),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppImagen(url: ministerio.imagenUrl),
              const DecoratedBox(decoration: BoxDecoration(color: Color(0x66000000))),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(ministerio.nombre,
                          style: t.cardTitulo.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                    const AppIcon(AppIcons.flechaDerecha, size: 16, color: Colors.white),
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
