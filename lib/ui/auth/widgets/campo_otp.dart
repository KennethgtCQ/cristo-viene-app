import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';

/// Código de N dígitos. Un TextField invisible recibe el texto (soporta pegar y
/// autocompletar del SMS/correo) y las cajas solo lo muestran.
class CampoOtp extends StatefulWidget {
  const CampoOtp({
    super.key,
    required this.controller,
    this.longitud = 6,
    this.onCompleto,
  });

  final TextEditingController controller;
  final int longitud;
  final ValueChanged<String>? onCompleto;

  @override
  State<CampoOtp> createState() => _CampoOtpState();
}

class _CampoOtpState extends State<CampoOtp> {
  final _foco = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_redibujar);
    _foco.addListener(_redibujar);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_redibujar);
    _foco.dispose();
    super.dispose();
  }

  void _redibujar() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final texto = widget.controller.text;
    final indiceActivo = texto.length.clamp(0, widget.longitud - 1);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _foco.requestFocus,
      child: Stack(
        children: [
          Row(
            children: [
              for (var i = 0; i < widget.longitud; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 0.83,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: t.campoFondo,
                        borderRadius: BorderRadius.circular(AppSizes.radio),
                        border: _foco.hasFocus && i == indiceActivo
                            ? Border.all(color: t.acento)
                            : null,
                      ),
                      child: Text(
                        i < texto.length ? texto[i] : '0',
                        style: i < texto.length ? t.otpDigito : t.otpPlaceholder,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0,
              child: TextField(
                controller: widget.controller,
                focusNode: _foco,
                keyboardType: TextInputType.number,
                autofillHints: const [AutofillHints.oneTimeCode],
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(widget.longitud),
                ],
                onChanged: (v) {
                  if (v.length == widget.longitud) widget.onCompleto?.call(v);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
