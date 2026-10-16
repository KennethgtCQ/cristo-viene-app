import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import '../core/widgets/app_shell.dart';
import '../core/widgets/pantalla_pendiente.dart';
import '../l10n/app_localizations.dart';
import '../ui/dev/views/galeria_componentes_screen.dart';

/// Rutas de la app. Las pestañas son temporales hasta construir cada feature.
GoRouter crearRouter() => GoRouter(
      initialLocation: '/inicio',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, shell) => AppShell(navigationShell: shell),
          branches: [
            _rama('/inicio', (l) => l.navInicio),
            _rama('/eventos', (l) => l.navEventos),
            _rama('/predicas', (l) => l.navPredicas),
            _rama('/ministerios', (l) => l.navMinisterios),
            _rama('/mas', (l) => l.navMas),
          ],
        ),
        // Solo existe en debug: nunca se compila en la ruta de release.
        if (kDebugMode)
          GoRoute(
            path: '/dev/componentes',
            builder: (context, state) => const GaleriaComponentesScreen(),
          ),
      ],
    );

StatefulShellBranch _rama(String ruta, String Function(AppLocalizations) titulo) =>
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: ruta,
          builder: (context, state) => PantallaPendiente(
            titulo: titulo(AppLocalizations.of(context)),
          ),
        ),
      ],
    );
