import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_encabezado.dart';
import '../../../data/models/documento_legal.dart';
import '../../../l10n/app_localizations.dart';
import '../view_models/legal_view_model.dart';

/// Términos y condiciones / Políticas de privacidad (mismo diseño).
class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key, required this.tipo});

  final TipoLegal tipo;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    final vm = context.watch<LegalViewModel>();
    final esTerminos = tipo == TipoLegal.terminos;
    final documento = vm.documento;

    Widget cuerpo;
    if (vm.error && documento == null) {
      cuerpo = Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.errLegal, style: t.descripcion, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              AppButton(
                texto: l10n.reintentar,
                tipo: AppButtonTipo.cerrar,
                onPressed: () => context.read<LegalViewModel>().cargar(tipo),
              ),
            ],
          ),
        ),
      );
    } else if (documento == null) {
      cuerpo = const Center(child: CircularProgressIndicator());
    } else {
      final linea = Divider(color: t.divisor, thickness: 0.5, height: 1);
      cuerpo = ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSizes.paddingPantalla, 40, AppSizes.paddingPantalla, 32),
        children: [
          Text(
            esTerminos ? l10n.legalTerminosEncabezado : l10n.legalPoliticasEncabezado,
            style: t.legalTitulo,
          ),
          const SizedBox(height: 8),
          Text(l10n.legalUltimaActualizacion(documento.ultimaActualizacion), style: t.legalFecha),
          const SizedBox(height: 16),
          linea,
          for (var i = 0; i < documento.secciones.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${i + 1}. ${documento.secciones[i].titulo}', style: t.legalSeccion),
                  const SizedBox(height: 6),
                  Text(documento.secciones[i].cuerpo, style: t.legalCuerpo),
                ],
              ),
            ),
            linea,
          ],
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppEncabezado(
              titulo: esTerminos ? l10n.legalTerminosTitulo : l10n.legalPoliticasTitulo,
              onAtras: () => context.canPop() ? context.pop() : context.go('/'),
            ),
            Expanded(child: cuerpo),
          ],
        ),
      ),
    );
  }
}
