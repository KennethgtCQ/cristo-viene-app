/// Errores de autenticación que la UI traduce a texto (l10n).
/// Los mensajes no distinguen "correo inexistente" de "clave incorrecta"
/// para no permitir enumeración de usuarios.
enum ErrorAuth {
  credencialesInvalidas,
  codigoInvalido,
  codigoExpirado,
  demasiadosIntentos,
  sinConexion,
  noDisponible,
  registroFallido,
  desconocido,
}

class AuthException implements Exception {
  const AuthException(this.codigo);

  final ErrorAuth codigo;

  @override
  String toString() => 'AuthException($codigo)';
}
