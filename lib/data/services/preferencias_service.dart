import 'package:shared_preferences/shared_preferences.dart';

/// Acceso al almacenamiento local (shared_preferences).
class PreferenciasService {
  PreferenciasService._(this._prefs);

  final SharedPreferences _prefs;

  static Future<PreferenciasService> cargar() async =>
      PreferenciasService._(await SharedPreferences.getInstance());

  String? leerTexto(String clave) => _prefs.getString(clave);
  int? leerEntero(String clave) => _prefs.getInt(clave);

  Future<void> guardarTexto(String clave, String valor) =>
      _prefs.setString(clave, valor);
  Future<void> guardarEntero(String clave, int valor) =>
      _prefs.setInt(clave, valor);
}
