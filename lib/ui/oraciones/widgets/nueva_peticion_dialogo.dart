import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../data/repositories/contenido_repository.dart';
import '../../../l10n/app_localizations.dart';

/// Formulario para enviar una petición. Cierra con true si se envió.
class NuevaPeticionDialogo extends StatefulWidget {
  const NuevaPeticionDialogo({super.key});

  @override
  State<NuevaPeticionDialogo> createState() => _NuevaPeticionDialogoState();
}

class _NuevaPeticionDialogoState extends State<NuevaPeticionDialogo> {
  final _texto = TextEditingController();
  bool _anonima = false;
  bool _enviando = false;

  @override
  void dispose() {
    _texto.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    final texto = _texto.text.trim();
    if (texto.isEmpty || texto.length > 500) return;
    setState(() => _enviando = true);
    await context.read<ContenidoRepository>().crearPeticion(texto: texto, anonima: _anonima);
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;

    return Dialog(
      backgroundColor: t.tarjetaFondo,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radio)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.solicitudOracion, style: t.subtitulo.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(l10n.solicitudOracionDescripcion, style: t.descripcion),
            const SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(color: t.campoFondo, borderRadius: BorderRadius.circular(AppSizes.radio)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Expanded(child: Text(l10n.publicarAnonima, style: t.placeholder)),
                  Switch(
                    value: _anonima,
                    onChanged: (v) => setState(() => _anonima = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(color: t.campoFondo, borderRadius: BorderRadius.circular(AppSizes.radio)),
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _texto,
                maxLines: 6,
                maxLength: 500,
                style: t.campo,
                cursorColor: t.acento,
                decoration: InputDecoration.collapsed(hintText: l10n.tuPeticion, hintStyle: t.placeholder),
              ),
            ),
            const SizedBox(height: 12),
            AppButton(texto: l10n.enviar, cargando: _enviando, onPressed: _enviar),
          ],
        ),
      ),
    );
  }
}
