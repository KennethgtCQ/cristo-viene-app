import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/app_sizes.dart';
import '../theme/app_tokens.dart';

/// Caja con día de la semana, número y mes (usada en eventos).
class AppCajaFecha extends StatelessWidget {
  const AppCajaFecha({super.key, required this.fecha, this.ancho = 64, this.alto = 81});

  final DateTime fecha;
  final double ancho;
  final double alto;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final locale = Localizations.localeOf(context).toString();
    final dia = DateFormat('E', locale).format(fecha).replaceAll('.', '');
    final mes = DateFormat('MMM', locale).format(fecha).replaceAll('.', '').toUpperCase();

    return Container(
      width: ancho,
      height: alto,
      decoration: BoxDecoration(
        color: t.campoFondo,
        borderRadius: BorderRadius.circular(AppSizes.radio),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(dia, style: t.diaProximo),
          Text('${fecha.day}', style: t.fechaEventos),
          Text(mes, style: t.diaProximo),
        ],
      ),
    );
  }
}
