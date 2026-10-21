import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/single_child_widget.dart';
import 'config/routes.dart';
import 'core/theme/app_theme.dart';
import 'data/models/preferencias_locales.dart';
import 'l10n/app_localizations.dart';
import 'ui/auth/view_models/auth_view_model.dart';
import 'ui/perfil/view_models/preferencias_view_model.dart';

class CristoVieneApp extends StatelessWidget {
  const CristoVieneApp({super.key, required this.dependencias});

  final List<SingleChildWidget> dependencias;

  @override
  Widget build(BuildContext context) =>
      MultiProvider(providers: dependencias, child: const _AppRaiz());
}

/// Vive debajo de los providers porque el router necesita el AuthViewModel.
class _AppRaiz extends StatefulWidget {
  const _AppRaiz();

  @override
  State<_AppRaiz> createState() => _AppRaizState();
}

class _AppRaizState extends State<_AppRaiz> {
  late final GoRouter _router = crearRouter(context.read<AuthViewModel>());

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenciasViewModel>(
        builder: (context, vm, _) {
          final p = vm.preferencias;
          final acento = p.colorAcento == null ? null : Color(p.colorAcento!);

          return MaterialApp.router(
            title: 'CristoViene',
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
            theme: AppTheme.claro(acento),
            darkTheme: AppTheme.oscuro(acento),
            themeMode: switch (p.tema) {
              ModoTema.claro => ThemeMode.light,
              ModoTema.oscuro => ThemeMode.dark,
              ModoTema.sistema => ThemeMode.system,
            },
            locale: Locale(p.idioma),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // El tamaño de texto elegido se suma al del sistema.
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(
                  MediaQuery.textScalerOf(context).scale(1) * p.tamanoTexto.factor,
                ),
              ),
              child: child!,
            ),
          );
        },
    );
  }
}
