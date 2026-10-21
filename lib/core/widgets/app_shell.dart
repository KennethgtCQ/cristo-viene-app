import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../constants/app_icons.dart';
import 'app_bottom_nav.dart';
import 'app_rail.dart';

/// Contenedor de las 5 pestañas. En móvil usa la barra inferior; en pantallas
/// anchas (web) usa un riel lateral y limita el ancho del contenido.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  static const _puntoWeb = 900.0;
  static const _anchoMaximo = 1100.0;

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final destinos = <(String, String)>[
      (AppIcons.navInicio, l10n.navInicio),
      (AppIcons.navEventos, l10n.navEventos),
      (AppIcons.navPredicas, l10n.navPredicas),
      (AppIcons.navMinisterios, l10n.navMinisterios),
      (AppIcons.navMas, l10n.navMas),
    ];
    final indice = navigationShell.currentIndex;
    void ir(int i) => navigationShell.goBranch(i, initialLocation: i == indice);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < _puntoWeb) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: AppBottomNav(
              indiceActual: indice,
              onSeleccion: ir,
              items: [
                for (final d in destinos) AppBottomNavItem(icono: d.$1, etiqueta: d.$2),
              ],
            ),
          );
        }
        return Scaffold(
          body: Row(
            children: [
              AppRail(destinos: destinos, indiceActual: indice, onSeleccion: ir),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: _anchoMaximo),
                    child: navigationShell,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
