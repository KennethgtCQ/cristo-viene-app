import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_encabezado.dart';
import '../../../l10n/app_localizations.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/campo_otp.dart';
import '../widgets/encabezado_auth.dart';
import '../widgets/texto_error_auth.dart';

/// Código de verificación de 6 dígitos (registro y recuperación).
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.flujo});

  final FlujoOtp flujo;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const _longitud = 6;
  final _codigo = TextEditingController();
  bool _incompleto = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<AuthViewModel>().limpiarError(),
    );
  }

  @override
  void dispose() {
    _codigo.dispose();
    super.dispose();
  }

  void _atras() {
    context.read<AuthViewModel>().cancelarFlujo(widget.flujo);
    context.go(widget.flujo == FlujoOtp.registro ? '/registro' : '/recuperar');
  }

  Future<void> _validar() async {
    if (_codigo.text.length != _longitud) {
      setState(() => _incompleto = true);
      return;
    }
    setState(() => _incompleto = false);
    final vm = context.read<AuthViewModel>();
    switch (widget.flujo) {
      case FlujoOtp.registro:
        // Si funciona, el router lleva a completar el perfil.
        await vm.confirmarRegistro(_codigo.text);
      case FlujoOtp.recuperacion:
        final ok = await vm.verificarCodigoRecuperacion(_codigo.text);
        if (ok && mounted) context.go('/recuperar/nueva');
    }
  }

  Future<void> _reenviar() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final ok = await context.read<AuthViewModel>().reenviarCodigo(widget.flujo);
    if (!mounted || !ok) return;
    _codigo.clear();
    messenger.showSnackBar(SnackBar(content: Text(l10n.codigoReenviado)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    final auth = context.watch<AuthViewModel>();
    final mensaje = _incompleto
        ? l10n.errCodigoIncompleto
        : (auth.error == null ? null : textoErrorAuth(l10n, auth.error!));

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _atras();
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(AppSizes.paddingAuth, 43, AppSizes.paddingAuth, 24),
                child: Column(
                  children: [
                    EncabezadoAuth(
                      titulo: l10n.codigoVerificacion,
                      descripcion: l10n.codigoVerificacionDesc,
                    ),
                    const SizedBox(height: 51),
                    CampoOtp(
                      controller: _codigo,
                      longitud: _longitud,
                      onCompleto: (_) => _validar(),
                    ),
                    if (mensaje != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(mensaje, style: t.errorTexto, textAlign: TextAlign.center),
                      ),
                    const SizedBox(height: 41),
                    AppButton(
                      texto: l10n.validar,
                      cargando: auth.cargando,
                      onPressed: _validar,
                    ),
                    const SizedBox(height: 14),
                    FraseConEnlace(
                      pregunta: l10n.noRecibisteCodigo,
                      enlace: l10n.reenviar,
                      onTap: auth.cargando ? () {} : _reenviar,
                    ),
                  ],
                ),
              ),
              Positioned(top: 0, left: 12, child: AppBotonAtras(onPressed: _atras)),
            ],
          ),
        ),
      ),
    );
  }
}
