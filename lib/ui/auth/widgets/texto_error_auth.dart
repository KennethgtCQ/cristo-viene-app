import '../../../core/errors/error_auth.dart';
import '../../../l10n/app_localizations.dart';

String textoErrorAuth(AppLocalizations l10n, ErrorAuth error) => switch (error) {
      ErrorAuth.credencialesInvalidas => l10n.errCredenciales,
      ErrorAuth.codigoInvalido => l10n.errCodigoInvalido,
      ErrorAuth.codigoExpirado => l10n.errCodigoExpirado,
      ErrorAuth.demasiadosIntentos => l10n.errDemasiadosIntentos,
      ErrorAuth.sinConexion => l10n.errSinConexion,
      ErrorAuth.noDisponible => l10n.errNoDisponible,
      ErrorAuth.registroFallido => l10n.errRegistro,
      ErrorAuth.desconocido => l10n.errDesconocido,
    };
