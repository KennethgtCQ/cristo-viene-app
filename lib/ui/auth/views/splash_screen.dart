import 'package:flutter/material.dart';
import '../../../core/widgets/app_logo.dart';

/// Se muestra mientras se resuelve si hay una sesión abierta.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: AppLogo()));
}
