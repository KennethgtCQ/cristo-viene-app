import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../constants/app_icons.dart';
import 'app_bottom_nav.dart';

/// Contenedor de las 5 pestañas principales con la barra inferior.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNav(
        indiceActual: navigationShell.currentIndex,
        onSeleccion: (i) => navigationShell.goBranch(
          i,
          initialLocation: i == navigationShell.currentIndex,
        ),
        items: [
          AppBottomNavItem(icono: AppIcons.navInicio, etiqueta: l10n.navInicio),
          AppBottomNavItem(icono: AppIcons.navEventos, etiqueta: l10n.navEventos),
          AppBottomNavItem(icono: AppIcons.navPredicas, etiqueta: l10n.navPredicas),
          AppBottomNavItem(
              icono: AppIcons.navMinisterios, etiqueta: l10n.navMinisterios),
          AppBottomNavItem(icono: AppIcons.navMas, etiqueta: l10n.navMas),
        ],
      ),
    );
  }
}
