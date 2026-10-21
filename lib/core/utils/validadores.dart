/// Validaciones de formato en cliente. Son solo ayuda de UX: la validación
/// real ocurre en Cloud Functions y reglas de Firestore.
bool esCorreoValido(String valor) {
  final v = valor.trim();
  return v.length <= 254 && RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v);
}

/// Mínimo 8 caracteres, con al menos una letra y un número.
bool esContrasenaSegura(String valor) =>
    valor.length >= 8 &&
    valor.length <= 128 &&
    RegExp(r'[A-Za-z]').hasMatch(valor) &&
    RegExp(r'\d').hasMatch(valor);

bool esNombreValido(String valor) {
  final v = valor.trim();
  return v.length >= 2 && v.length <= 60;
}
