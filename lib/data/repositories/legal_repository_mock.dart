import '../models/documento_legal.dart';
import 'legal_repository.dart';

/// SOLO DEBUG. Texto de relleno con la estructura del diseño.
class LegalRepositoryMock implements LegalRepository {
  static const _lorem =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu mattis '
      'nulla. Vivamus vitae imperdiet sapien. Quisque elit est, posuere '
      'condimentum imperdiet sit amet, sodales et ipsum. Nulla ac augue eget '
      'lorem convallis gravida.';

  @override
  Future<DocumentoLegal> obtener(TipoLegal tipo) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final titulos = switch (tipo) {
      TipoLegal.terminos => [
          'Aceptación de los términos',
          'Uso de la aplicación',
          'Contenido',
          'Reglas',
          'Propiedad',
        ],
      TipoLegal.privacidad => [
          'Información que recopilamos',
          'Cómo usamos tu información',
          'Compartir tu información',
          'Lorem ipsum',
          'Lorem ipsum',
        ],
    };
    return DocumentoLegal(
      ultimaActualizacion: DateTime(2026, 12, 21),
      secciones: [for (final t in titulos) SeccionLegal(titulo: t, cuerpo: _lorem)],
    );
  }
}
