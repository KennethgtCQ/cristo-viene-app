import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/auth_repository_mock.dart';
import '../data/repositories/contenido_repository.dart';
import '../data/repositories/contenido_repository_mock.dart';
import '../data/repositories/legal_repository.dart';
import '../data/repositories/legal_repository_mock.dart';
import '../data/repositories/preferencias_repository.dart';
import '../data/services/preferencias_service.dart';
import '../ui/auth/view_models/auth_view_model.dart';
import '../ui/perfil/view_models/preferencias_view_model.dart';

/// Los mocks existen solo para trabajar la UI en debug. Una compilación
/// profile/release falla a propósito hasta conectar la implementación real.
AuthRepository _crearAuthRepository() {
  if (kDebugMode) return AuthRepositoryMock();
  throw UnimplementedError('Conectar AuthRepositoryImpl (Firebase) antes de compilar release.');
}

LegalRepository _crearLegalRepository() {
  if (kDebugMode) return LegalRepositoryMock();
  throw UnimplementedError('Conectar LegalRepositoryImpl (Hosting) antes de compilar release.');
}

ContenidoRepository _crearContenidoRepository() {
  if (kDebugMode) return ContenidoRepositoryMock();
  throw UnimplementedError('Conectar ContenidoRepositoryImpl (Firestore) antes de compilar release.');
}

/// Providers globales: Services -> Repositories -> ViewModels.
List<SingleChildWidget> dependencias(PreferenciasService preferenciasService) => [
      // Services
      Provider<PreferenciasService>.value(value: preferenciasService),

      // Repositories
      Provider<PreferenciasRepository>(
        create: (ctx) => PreferenciasRepositoryImpl(ctx.read<PreferenciasService>()),
      ),
      Provider<AuthRepository>(create: (_) => _crearAuthRepository()),
      Provider<LegalRepository>(create: (_) => _crearLegalRepository()),
      Provider<ContenidoRepository>(create: (_) => _crearContenidoRepository()),

      // ViewModels
      ChangeNotifierProvider(
        create: (ctx) => PreferenciasViewModel(ctx.read<PreferenciasRepository>()),
      ),
      ChangeNotifierProvider(
        create: (ctx) => AuthViewModel(ctx.read<AuthRepository>()),
      ),
    ];
