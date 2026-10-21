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

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _correo = TextEditingController();
  final _contrasena = TextEditingController();
  final _confirmar = TextEditingController();

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
    _confirmar.dispose();
    super.dispose();
  }

  Future<void> _registrar() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await context.read<AuthViewModel>().iniciarRegistro(_correo.text, _contrasena.text);
    if (ok && mounted) context.go('/registro/codigo');
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
                    titulo: l10n.crearCuenta,
                    espacioTrasLogo: 64,
                    subtitulo: FraseConEnlace(
                      pregunta: l10n.yaTienesCuenta,
                      enlace: l10n.iniciarSesionLink,
                      onTap: () => context.go('/login'),
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
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.newPassword],
                    validator: (v) => esContrasenaSegura(v ?? '') ? null : l10n.errContrasenaDebil,
                  ),
                  const SizedBox(height: 26),
                  AppTextField(
                    hint: l10n.confirmarContrasena,
                    controller: _confirmar,
                    icono: AppIcons.candado,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.newPassword],
                    onSubmitted: (_) => _registrar(),
                    validator: (v) => v == _contrasena.text ? null : l10n.errContrasenasNoCoinciden,
                  ),
                  if (auth.error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(textoErrorAuth(l10n, auth.error!), style: t.errorTexto),
                      ),
                    ),
                  const SizedBox(height: 50),
                  AppButton(
                    texto: l10n.registrar,
                    cargando: auth.cargando,
                    onPressed: _registrar,
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
