import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/validadores.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/botones_sociales.dart';
import '../widgets/encabezado_auth.dart';
import '../widgets/texto_error_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _correo = TextEditingController();
  final _contrasena = TextEditingController();

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
    _contrasena.dispose();
    super.dispose();
  }

  Future<void> _ingresar() async {
    if (!_formKey.currentState!.validate()) return;
    // Si el login funciona, el router redirige solo.
    await context.read<AuthViewModel>().login(_correo.text, _contrasena.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    final auth = context.watch<AuthViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(AppSizes.paddingAuth, 43, AppSizes.paddingAuth, 24),
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: Column(
                children: [
                  EncabezadoAuth(
                    titulo: l10n.iniciarSesion,
                    espacioTrasLogo: 64,
                    subtitulo: FraseConEnlace(
                      pregunta: l10n.sinCuentaPregunta,
                      enlace: l10n.crearCuentaLink,
                      onTap: () => context.go('/registro'),
                    ),
                  ),
                  const SizedBox(height: 26),
                  AppTextField(
                    hint: l10n.correoElectronico,
                    controller: _correo,
                    icono: AppIcons.correo,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    validator: (v) => esCorreoValido(v ?? '') ? null : l10n.errCorreoInvalido,
                  ),
                  const SizedBox(height: 26),
                  AppTextField(
                    hint: l10n.contrasena,
                    controller: _contrasena,
                    icono: AppIcons.candado,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.password],
                    onSubmitted: (_) => _ingresar(),
                    validator: (v) => (v == null || v.isEmpty) ? l10n.errCampoRequerido : null,
                  ),
                  if (auth.error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(textoErrorAuth(l10n, auth.error!), style: t.errorTexto),
                      ),
                    ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => context.go('/recuperar'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(l10n.olvidasteContrasena, style: t.enlaceChico),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  AppButton(
                    texto: l10n.ingresar,
                    cargando: auth.cargando,
                    onPressed: _ingresar,
                  ),
                  BotonesSociales(
                    onGoogle: auth.cargando
                        ? null
                        : () => context.read<AuthViewModel>().loginConProveedor(ProveedorAuth.google),
                    onApple: auth.cargando
                        ? null
                        : () => context.read<AuthViewModel>().loginConProveedor(ProveedorAuth.apple),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
