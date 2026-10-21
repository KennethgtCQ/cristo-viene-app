import '../../core/constants/app_colors.dart';
import '../models/preferencias_locales.dart';
import '../services/preferencias_service.dart';

abstract class PreferenciasRepository {
  PreferenciasLocales leer();
  Future<void> guardar(PreferenciasLocales preferencias);
}

class PreferenciasRepositoryImpl implements PreferenciasRepository {
  PreferenciasRepositoryImpl(this._service);

  final PreferenciasService _service;

  static const _claveTema = 'tema';
  static const _claveIdioma = 'idioma';
  static const _claveTamanoTexto = 'tamanoTexto';
  static const _claveColorAcento = 'colorAcento';
  static const _idiomas = ['es', 'en'];

  /// Lee y valida: un valor alterado en disco vuelve al valor por defecto.
  @override
  PreferenciasLocales leer() {
    final tema = ModoTema.values.firstWhere(
      (m) => m.name == _service.leerTexto(_claveTema),
      orElse: () => ModoTema.sistema,
    );
    final tamano = TamanoTexto.values.firstWhere(
      (t) => t.name == _service.leerTexto(_claveTamanoTexto),
      orElse: () => TamanoTexto.normal,
    );
    final idioma = _service.leerTexto(_claveIdioma);
    final acento = _service.leerEntero(_claveColorAcento);

    return PreferenciasLocales(
      tema: tema,
      tamanoTexto: tamano,
      idioma: _idiomas.contains(idioma) ? idioma! : 'es',
      colorAcento: _acentoValido(acento) ? acento : null,
    );
  }

  @override
  Future<void> guardar(PreferenciasLocales p) async {
    await _service.guardarTexto(_claveTema, p.tema.name);
    await _service.guardarTexto(_claveTamanoTexto, p.tamanoTexto.name);
    if (_idiomas.contains(p.idioma)) {
      await _service.guardarTexto(_claveIdioma, p.idioma);
    }
    if (_acentoValido(p.colorAcento)) {
      await _service.guardarEntero(_claveColorAcento, p.colorAcento!);
    }
  }

  bool _acentoValido(int? valor) =>
      valor != null && AppColors.acentos.any((c) => c.toARGB32() == valor);
}
