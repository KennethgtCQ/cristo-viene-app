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
import '../ui/biblia/views/biblia_screen.dart';
import '../ui/boletin/views/boletin_screen.dart';
import '../ui/boletin/views/publicacion_detalle_screen.dart';
import '../ui/dev/views/galeria_componentes_screen.dart';
import '../ui/eventos/views/eventos_screen.dart';
import '../ui/inicio/views/inicio_screen.dart';
import '../ui/legal/view_models/legal_view_model.dart';
import '../ui/legal/views/legal_screen.dart';
import '../ui/ministerios/views/ministerio_detalle_screen.dart';
import '../ui/ministerios/views/ministerios_screen.dart';
import '../ui/notificaciones/views/notificaciones_screen.dart';
import '../ui/ofrendas/views/ofrendas_screen.dart';
import '../ui/oraciones/views/mis_peticiones_screen.dart';
import '../ui/oraciones/views/oraciones_screen.dart';
import '../ui/predicas/views/predicas_screen.dart';

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

/// Reglas de acceso (solo experiencia de usuario). La seguridad real está en
/// Firestore Rules y Cloud Functions, nunca en el cliente.
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
  if (kIsWeb && !usuario.esAdmin) {
    return ruta == '/acceso-denegado' ? null : '/acceso-denegado';
  }

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

        // ---- Panel admin (web; pendiente de construir) ----
        GoRoute(
          path: '/admin',
          builder: (context, _) => Scaffold(
            body: PantallaPendiente(titulo: AppLocalizations.of(context).adminPanel),
          ),
        ),

        // ---- Pestañas principales (con barra inferior en móvil y riel en web) ----
        StatefulShellRoute.indexedStack(
          builder: (context, state, shell) => AppShell(navigationShell: shell),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(path: '/inicio', builder: (_, __) => const InicioScreen()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: '/eventos', builder: (_, __) => const EventosScreen()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: '/predicas', builder: (_, __) => const PredicasScreen()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: '/ministerios', builder: (_, __) => const MinisteriosScreen()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: '/mas', builder: (context, __) => _marcador(context, (l) => l.navMas)),
            ]),
          ],
        ),

        // ---- Pantallas de detalle y secundarias (cubren la navegación) ----
        GoRoute(path: '/ministerios/:id', builder: (_, s) => MinisterioDetalleScreen(id: s.pathParameters['id']!)),
        GoRoute(path: '/boletin', builder: (_, __) => const BoletinScreen()),
        GoRoute(path: '/boletin/:id', builder: (_, s) => PublicacionDetalleScreen(id: s.pathParameters['id']!)),
        GoRoute(path: '/biblia', builder: (_, __) => const BibliaScreen()),
        GoRoute(path: '/oraciones', builder: (_, __) => const OracionesScreen()),
        GoRoute(path: '/oraciones/mias', builder: (_, __) => const MisPeticionesScreen()),
        GoRoute(path: '/ofrendas', builder: (_, __) => const OfrendasScreen()),
        GoRoute(path: '/notificaciones', builder: (_, __) => const NotificacionesScreen()),

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

Widget _marcador(BuildContext context, String Function(AppLocalizations) titulo) =>
    PantallaPendiente(titulo: titulo(AppLocalizations.of(context)));
