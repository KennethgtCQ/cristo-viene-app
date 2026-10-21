import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../data/repositories/preferencias_repository.dart';
import '../data/services/preferencias_service.dart';
import '../ui/perfil/view_models/preferencias_view_model.dart';

/// Providers globales: Services -> Repositories -> ViewModels.
List<SingleChildWidget> dependencias(PreferenciasService preferenciasService) => [
      // Services
      Provider<PreferenciasService>.value(value: preferenciasService),

      // Repositories
      Provider<PreferenciasRepository>(
        create: (ctx) => PreferenciasRepositoryImpl(ctx.read<PreferenciasService>()),
      ),

      // ViewModels
      ChangeNotifierProvider(
        create: (ctx) => PreferenciasViewModel(ctx.read<PreferenciasRepository>()),
      ),
    ];
