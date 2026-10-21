import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../core/widgets/app_shell.dart';
import '../core/widgets/pantalla_pendiente.dart';
import '../data/models/documento_legal.dart';
import '../data/repositories/legal_repository.dart';
import '../l10n/app_localizations.dart';
import '../ui/auth/view_models/auth_view_model.dart';
import '../ui/auth/views/acceso_denegado_screen.dart';
import '../ui/auth/views/bienvenida_screen.dart';
import '../ui/auth/views/cambiar_contrasena_screen.dart';
import '../ui/auth/views/completar_perfil_screen.dart';
import '../ui/auth/views/login_screen.dart';
import '../ui/auth/views/otp_screen.dart';
import '../ui/auth/views/recuperar_contrasena_screen.dart';
import '../ui/auth/views/registro_screen.dart';
import '../ui/auth/views/splash_screen.dart';
import '../ui/dev/views/galeria_componentes_screen.dart';
import '../ui/legal/view_models/legal_view_model.dart';
import '../ui/legal/views/legal_screen.dart';

/// Rutas sin sesión.
const _publicas = {
  '/bienvenida',
  '/login',
  '/registro',
  '/recuperar',
  '/legal/terminos',
  '/legal/privacidad',
};

/// Rutas que solo tienen sentido sin sesión: con sesión se va al inicio.
const _soloSinSesion = {
  '/splash',
  '/bienvenida',
  '/login',
  '/registro',
  '/registro/codigo',
  '/recuperar',
  '/recuperar/codigo',
  '/recuperar/nueva',
  '/completar-perfil',
  '/acceso-denegado',
};

/// Reglas de acceso (solo de experiencia de usuario). La seguridad real
/// está en Firestore Rules y Cloud Functions, nunca en el cliente.
String? _redireccion(AuthViewModel auth, String ruta) {
  if (auth.inicializando) return ruta == '/splash' ? null : '/splash';
  if (kDebugMode && ruta == '/dev/componentes') return null;

  final usuario = auth.usuario;

  // ---- Sin sesión ----
  if (usuario == null) {
    if (_publicas.contains(ruta)) return null;
    if (ruta == '/registro/codigo') return auth.hayRegistroPendiente ? null : '/registro';
    if (ruta == '/recuperar/codigo') return auth.hayRecuperacionPendiente ? null : '/recuperar';
    if (ruta == '/recuperar/nueva') return auth.recuperacionVerificada ? null : '/recuperar';
    return '/bienvenida';
  }

  // ---- Con sesión: perfil incompleto ----
  if (!usuario.perfilCompleto) {
    final permitida = ruta == '/completar-perfil' || ruta.startsWith('/legal/');
    return permitida ? null : '/completar-perfil';
  }

  // ---- Web: solo administradores ----
  if (kIsWeb) {
    if (!usuario.esAdmin) return ruta == '/acceso-denegado' ? null : '/acceso-denegado';
    return ruta.startsWith('/admin') ? null : '/admin';
  }

  // ---- Móvil ----
  if (ruta.startsWith('/admin')) return '/inicio'; // el panel admin es solo web
  if (_soloSinSesion.contains(ruta)) return '/inicio';
  return null;
}

GoRouter crearRouter(AuthViewModel auth) => GoRouter(
      initialLocation: '/splash',
      refreshListenable: auth,
      redirect: (context, state) => _redireccion(auth, state.matchedLocation),
      routes: [
        // ---- Auth ----
        GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
        GoRoute(path: '/bienvenida', builder: (_, __) => const BienvenidaScreen()),
        GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
        GoRoute(path: '/registro', builder: (_, __) => const RegistroScreen()),
        GoRoute(
          path: '/registro/codigo',
          builder: (_, __) => const OtpScreen(flujo: FlujoOtp.registro),
        ),
        GoRoute(path: '/recuperar', builder: (_, __) => const RecuperarContrasenaScreen()),
        GoRoute(
          path: '/recuperar/codigo',
          builder: (_, __) => const OtpScreen(flujo: FlujoOtp.recuperacion),
        ),
        GoRoute(path: '/recuperar/nueva', builder: (_, __) => const CambiarContrasenaScreen()),
        GoRoute(path: '/completar-perfil', builder: (_, __) => const CompletarPerfilScreen()),
        GoRoute(path: '/acceso-denegado', builder: (_, __) => const AccesoDenegadoScreen()),

        // ---- Legal ----
        GoRoute(path: '/legal/terminos', builder: (_, __) => _legal(TipoLegal.terminos)),
        GoRoute(path: '/legal/privacidad', builder: (_, __) => _legal(TipoLegal.privacidad)),

        // ---- Panel admin (solo web; por ahora marcador) ----
        GoRoute(
          path: '/admin',
          builder: (context, _) => Scaffold(
            body: PantallaPendiente(titulo: AppLocalizations.of(context).adminPanel),
          ),
        ),

        // ---- Pestañas principales (marcadores hasta la fase 3) ----
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

        // Solo existe en debug.
        if (kDebugMode)
          GoRoute(
            path: '/dev/componentes',
            builder: (_, __) => const GaleriaComponentesScreen(),
          ),
      ],
    );

Widget _legal(TipoLegal tipo) => ChangeNotifierProvider(
      create: (ctx) => LegalViewModel(ctx.read<LegalRepository>())..cargar(tipo),
      child: LegalScreen(tipo: tipo),
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
