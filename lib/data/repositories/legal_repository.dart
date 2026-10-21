import '../models/documento_legal.dart';

/// Los textos legales viven en Hosting (no en Firestore).
abstract class LegalRepository {
  Future<DocumentoLegal> obtener(TipoLegal tipo);
}
