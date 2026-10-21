import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/validadores.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_encabezado.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../l10n/app_localizations.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/encabezado_auth.dart';
import '../widgets/texto_error_auth.dart';

class RecuperarContrasenaScreen extends StatefulWidget {
  const RecuperarContrasenaScreen({super.key});

  @override
  State<RecuperarContrasenaScreen> createState() => _RecuperarContrasenaScreenState();
}

class _RecuperarContrasenaScreenState extends State<RecuperarContrasenaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _correo = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<AuthViewModel>().limpiarError(),
    );
  }

  @override
  void dispose() {
    _correo.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await context.read<AuthViewModel>().iniciarRecuperacion(_correo.text);
    if (ok && mounted) context.go('/recuperar/codigo');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    final auth = context.watch<AuthViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(AppSizes.paddingAuth, 43, AppSizes.paddingAuth, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    EncabezadoAuth(
                      titulo: l10n.olvideContrasena,
                      descripcion: l10n.olvideContrasenaDesc,
                    ),
                    const SizedBox(height: 51),
                    AppTextField(
                      hint: l10n.correoElectronico,
                      controller: _correo,
                      icono: AppIcons.correo,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.email],
                      onSubmitted: (_) => _enviar(),
                      validator: (v) => esCorreoValido(v ?? '') ? null : l10n.errCorreoInvalido,
                    ),
                    if (auth.error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(textoErrorAuth(l10n, auth.error!), style: t.errorTexto),
                        ),
                      ),
                    const SizedBox(height: 36),
                    AppButton(
                      texto: l10n.enviarCodigo,
                      cargando: auth.cargando,
                      onPressed: _enviar,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 12,
              child: AppBotonAtras(onPressed: () => context.go('/login')),
            ),
          ],
        ),
      ),
    );
  }
}
