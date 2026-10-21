import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../l10n/app_localizations.dart';
import '../view_models/auth_view_model.dart';

/// La versión web es solo para administradores.
class AccesoDenegadoScreen extends StatelessWidget {
  const AccesoDenegadoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingAuth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppLogo(),
                  const SizedBox(height: 40),
                  Text(l10n.accesoDenegadoTitulo, style: t.titulo, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  Text(l10n.accesoDenegadoDesc, style: t.subtituloTenue, textAlign: TextAlign.center),
                  const SizedBox(height: 32),
                  AppButton(
                    texto: l10n.cerrarSesion,
                    tipo: AppButtonTipo.cerrar,
                    onPressed: () => context.read<AuthViewModel>().logout(),
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
