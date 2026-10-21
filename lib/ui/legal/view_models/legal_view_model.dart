import 'package:flutter/foundation.dart';
import '../../../data/models/documento_legal.dart';
import '../../../data/repositories/legal_repository.dart';

class LegalViewModel extends ChangeNotifier {
  LegalViewModel(this._repository);

  final LegalRepository _repository;

  DocumentoLegal? _documento;
  bool _cargando = false;
  bool _error = false;

  DocumentoLegal? get documento => _documento;
  bool get cargando => _cargando;
  bool get error => _error;

  Future<void> cargar(TipoLegal tipo) async {
    _cargando = true;
    _error = false;
    notifyListeners();
    try {
      _documento = await _repository.obtener(tipo);
    } catch (_) {
      _error = true;
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
}
