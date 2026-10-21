import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_caja_fecha.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/widgets/app_imagen.dart';
import '../../../data/models/contenido.dart';

/// Tarjeta de evento: fecha, título, horario y lugar.
class TarjetaEvento extends StatelessWidget {
  const TarjetaEvento({super.key, required this.evento, this.onTap});

  final Evento evento;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final locale = Localizations.localeOf(context).toString();
    final formato = DateFormat.jm(locale);
    final hora = '${formato.format(evento.inicio)} - ${formato.format(evento.fin)}';

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          if (evento.imagenUrl.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radio),
              child: SizedBox(width: 77, height: 81, child: AppImagen(url: evento.imagenUrl)),
            ),
            const SizedBox(width: 12),
          ],
          AppCajaFecha(fecha: evento.inicio),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(evento.titulo, style: t.eventoTitulo),
                const SizedBox(height: 4),
                Text(hora, style: t.hora),
                const SizedBox(height: 4),
                Text(evento.lugar, style: t.lugar),
              ],
            ),
          ),
          AppIcon(AppIcons.flechaDerecha, size: 18, color: t.secundario),
        ],
      ),
    );
  }
}
