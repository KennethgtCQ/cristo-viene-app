enum TipoLegal { terminos, privacidad }

class SeccionLegal {
  const SeccionLegal({required this.titulo, required this.cuerpo});
  final String titulo;
  final String cuerpo;
}

class DocumentoLegal {
  const DocumentoLegal({required this.ultimaActualizacion, required this.secciones});
  final DateTime ultimaActualizacion;
  final List<SeccionLegal> secciones;
}
