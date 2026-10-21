import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';
import 'config/dependencies.dart';
import 'data/services/preferencias_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Necesario para formatear fechas en español e inglés (DateFormat).
  await initializeDateFormatting('es');
  await initializeDateFormatting('en');
  final preferencias = await PreferenciasService.cargar();
  runApp(CristoVieneApp(dependencias: dependencias(preferencias)));
}
