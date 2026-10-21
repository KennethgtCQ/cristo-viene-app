import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../ui/auth/view_models/auth_view_model.dart';
import '../constants/app_icons.dart';
import '../theme/app_tokens.dart';
import 'app_icon.dart';
import 'app_imagen.dart';

/// Encabezado de las pestañas: título (y subtítulo opcional) con campana y avatar.
class AppCabecera extends StatelessWidget {
  const AppCabecera({super.key, required this.titulo, this.subtitulo});

  final String titulo;
  final String? subtitulo;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo, style: t.titulo),
              if (subtitulo != null) Text(subtitulo!, style: t.subtituloTenue),
            ],
          ),
        ),
        IconButton(
          tooltip: AppLocalizations.of(context).notificacionesTitulo,
          onPressed: () => context.push('/notificaciones'),
          icon: AppIcon(AppIcons.campana, size: 24, color: t.principal),
        ),
        const SizedBox(width: 4),
        _Avatar(onTap: () => context.go('/mas')),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final usuario = context.watch<AuthViewModel>().usuario;
    final inicial = (usuario?.nombre.isNotEmpty ?? false) ? usuario!.nombre[0].toUpperCase() : '';
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: t.acento, width: 2)),
        child: ClipOval(
          child: (usuario?.fotoUrl.isNotEmpty ?? false)
              ? AppImagen(url: usuario!.fotoUrl)
              : ColoredBox(
                  color: t.campoFondo,
                  child: Center(child: Text(inicial, style: t.campo)),
                ),
        ),
      ),
    );
  }
}
