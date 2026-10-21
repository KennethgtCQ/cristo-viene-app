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

/// Nueva contraseña tras validar el código de recuperación.
class CambiarContrasenaScreen extends StatefulWidget {
  const CambiarContrasenaScreen({super.key});

  @override
  State<CambiarContrasenaScreen> createState() => _CambiarContrasenaScreenState();
}

class _CambiarContrasenaScreenState extends State<CambiarContrasenaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nueva = TextEditingController();
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
    _nueva.dispose();
    _confirmar.dispose();
    super.dispose();
  }

  Future<void> _continuar() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final vm = context.read<AuthViewModel>();
    final ok = await vm.cambiarContrasena(_nueva.text);
    if (!ok || !mounted) return;
    messenger.showSnackBar(SnackBar(content: Text(l10n.contrasenaActualizada)));
    context.go('/login');
    vm.cancelarFlujo(FlujoOtp.recuperacion); // borra id y código de memoria
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
                      titulo: l10n.cambiarContrasena,
                      descripcion: l10n.cambiarContrasenaDesc,
                    ),
                    const SizedBox(height: 70),
                    AppTextField(
                      hint: l10n.nuevaContrasena,
                      controller: _nueva,
                      icono: AppIcons.candado,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.newPassword],
                      validator: (v) => esContrasenaSegura(v ?? '') ? null : l10n.errContrasenaDebil,
                    ),
                    const SizedBox(height: 33),
                    AppTextField(
                      hint: l10n.confirmarNuevaContrasena,
                      controller: _confirmar,
                      icono: AppIcons.candado,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.newPassword],
                      onSubmitted: (_) => _continuar(),
                      validator: (v) => v == _nueva.text ? null : l10n.errContrasenasNoCoinciden,
                    ),
                    if (auth.error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(textoErrorAuth(l10n, auth.error!), style: t.errorTexto),
                        ),
                      ),
                    const SizedBox(height: 33),
                    AppButton(
                      texto: l10n.continuar,
                      cargando: auth.cargando,
                      onPressed: _continuar,
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
