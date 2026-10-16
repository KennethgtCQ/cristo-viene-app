import 'package:flutter/material.dart';
import 'app.dart';
import 'config/dependencies.dart';
import 'data/services/preferencias_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferencias = await PreferenciasService.cargar();
  runApp(CristoVieneApp(dependencias: dependencias(preferencias)));
}
