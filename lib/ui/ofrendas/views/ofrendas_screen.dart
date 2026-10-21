import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/datos_ofrenda.dart';
import '../../../core/constants/placeholders.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_encabezado.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_imagen.dart';
import '../../../l10n/app_localizations.dart';

class OfrendasScreen extends StatefulWidget {
  const OfrendasScreen({super.key});

  @override
  State<OfrendasScreen> createState() => _OfrendasScreenState();
}

class _OfrendasScreenState extends State<OfrendasScreen> {
  int _iniciativa = 0;
  int _banco = 0;
  int _monto = 0; // índice en DatosOfrenda.montos; == montos.length significa "Otro"

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;

    final iniciativas = [
      (l10n.ofrendaBuenSamaritano, l10n.ofrendaBuenSamaritanoDesc),
      (l10n.ofrendaCasaNueva, l10n.ofrendaCasaNuevaDesc),
      (l10n.ofrendaMisiones, l10n.ofrendaMisionesDesc),
      (l10n.ofrendaOtro, l10n.ofrendaOtroDesc),
    ];
    final montos = [...DatosOfrenda.montos, l10n.otro];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppEncabezado(
              titulo: l10n.ofrendasTitulo,
              onAtras: () => context.canPop() ? context.pop() : context.go('/inicio'),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 8, AppSizes.paddingPantalla, 32),
                children: [
                  Text(l10n.ofrendasApoyar, style: t.subtitulo),
                  const SizedBox(height: 4),
                  Text(l10n.ofrendasApoyarDescripcion, style: t.subtituloTenue),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.05,
                    children: [
                      for (var i = 0; i < iniciativas.length; i++)
                        _Iniciativa(
                          titulo: iniciativas[i].$1,
                          descripcion: iniciativas[i].$2,
                          seleccionada: _iniciativa == i,
                          onTap: () => setState(() => _iniciativa = i),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(l10n.banco, style: t.subtitulo),
                  const SizedBox(height: 10),
                  _Opciones(
                    etiquetas: DatosOfrenda.bancos,
                    seleccionada: _banco,
                    onTap: (i) => setState(() => _banco = i),
                  ),
                  const SizedBox(height: 24),
                  Text(l10n.monto, style: t.subtitulo),
                  const SizedBox(height: 10),
                  _Opciones(
                    etiquetas: montos,
                    seleccionada: _monto,
                    onTap: (i) => setState(() => _monto = i),
                  ),
                  const SizedBox(height: 28),
                  AppButton(
                    texto: l10n.donarAhora,
                    onPressed: () => ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(l10n.proximamente))),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: TextButton(
                      onPressed: () => showDialog<void>(
                        context: context,
                        builder: (_) => const _DialogoTransferencia(),
                      ),
                      child: Text(l10n.otrasFormasDeOfrendar, style: t.enlace),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Iniciativa extends StatelessWidget {
  const _Iniciativa({
    required this.titulo,
    required this.descripcion,
    required this.seleccionada,
    required this.onTap,
  });

  final String titulo;
  final String descripcion;
  final bool seleccionada;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radio),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radio),
              border: seleccionada ? Border.all(color: t.acento, width: 2) : null,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                AppImagen(url: AppPlaceholders.hero),
                const DecoratedBox(decoration: BoxDecoration(color: Color(0x80000000))),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (seleccionada) AppIcon(AppIcons.check, size: 18, color: t.acento),
                      const Spacer(),
                      Text(titulo, style: t.cardTitulo.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(descripcion,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: t.lugar.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Fila de opciones tipo píldora (bancos y montos).
class _Opciones extends StatelessWidget {
  const _Opciones({required this.etiquetas, required this.seleccionada, required this.onTap});

  final List<String> etiquetas;
  final int seleccionada;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (var i = 0; i < etiquetas.length; i++)
          Material(
            color: i == seleccionada ? t.acento : t.tabNoSeleccionada,
            borderRadius: BorderRadius.circular(AppSizes.radioPildora),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSizes.radioPildora),
              onTap: () => onTap(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Text(
                  etiquetas[i],
                  style: i == seleccionada ? t.tab.copyWith(color: t.sobreAcento) : t.tabNoSeleccionadaTexto,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DialogoTransferencia extends StatelessWidget {
  const _DialogoTransferencia();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;

    return Dialog(
      backgroundColor: t.tarjetaFondo,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radio)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.transferencia, style: t.subtitulo.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 14),
              for (final c in DatosOfrenda.cuentas) ...[
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    border: Border.all(color: t.divisor),
                    borderRadius: BorderRadius.circular(AppSizes.radio),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.banco, style: t.cardTitulo),
                      Text(c.moneda == 'colones' ? l10n.colones : l10n.dolares, style: t.lugar),
                      const SizedBox(height: 8),
                      _Fila(etiqueta: l10n.cuentaNumero, valor: c.cuenta),
                      _Fila(etiqueta: l10n.cuentaCliente, valor: c.cuentaCliente),
                      _Fila(etiqueta: l10n.cuentaIban, valor: c.iban),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
              _Fila(etiqueta: l10n.beneficiario, valor: DatosOfrenda.beneficiario),
              _Fila(etiqueta: l10n.concepto, valor: DatosOfrenda.concepto),
              const SizedBox(height: 16),
              AppButton(
                texto: l10n.cerrar,
                tipo: AppButtonTipo.cerrar,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Fila extends StatelessWidget {
  const _Fila({required this.etiqueta, required this.valor});

  final String etiqueta;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(etiqueta, style: t.lugar)),
          Expanded(child: Text(valor, style: t.cardDetalle.copyWith(color: t.principal))),
        ],
      ),
    );
  }
}
