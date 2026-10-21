import 'package:flutter/foundation.dart';
import '../../../data/models/preferencias_locales.dart';
import '../../../data/repositories/preferencias_repository.dart';

/// Estado de apariencia e idioma (tema, acento, tamaño de texto, idioma).
class PreferenciasViewModel extends ChangeNotifier {
  PreferenciasViewModel(this._repository) : _preferencias = _repository.leer();

  final PreferenciasRepository _repository;
  PreferenciasLocales _preferencias;

  PreferenciasLocales get preferencias => _preferencias;

  Future<void> cambiarTema(ModoTema tema) =>
      _actualizar(_preferencias.copyWith(tema: tema));

  Future<void> cambiarAcento(int colorArgb) =>
      _actualizar(_preferencias.copyWith(colorAcento: colorArgb));

  Future<void> cambiarTamanoTexto(TamanoTexto tamano) =>
      _actualizar(_preferencias.copyWith(tamanoTexto: tamano));

  Future<void> cambiarIdioma(String idioma) =>
      _actualizar(_preferencias.copyWith(idioma: idioma));

  Future<void> _actualizar(PreferenciasLocales nuevas) async {
    await _repository.guardar(nuevas);
    _preferencias = _repository.leer(); // el repositorio descarta valores no válidos
    notifyListeners();
  }
}
