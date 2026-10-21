enum TipoNotificacion { evento, anuncio, recordatorio, peticion, ministerio }

class Evento {
  const Evento({
    required this.id,
    required this.titulo,
    required this.inicio,
    required this.fin,
    required this.lugar,
    this.imagenUrl = '',
  });

  final String id;
  final String titulo;
  final DateTime inicio;
  final DateTime fin;
  final String lugar;
  final String imagenUrl;

  bool get esProximo => fin.isAfter(DateTime.now());
}

class Predica {
  const Predica({
    required this.id,
    required this.serie,
    required this.titulo,
    required this.minutos,
    required this.fecha,
    this.imagenUrl = '',
  });

  final String id;
  final String serie;
  final String titulo;
  final int minutos;
  final DateTime fecha;
  final String imagenUrl;

  bool get esProxima => fecha.isAfter(DateTime.now());
}

class Ministerio {
  const Ministerio({
    required this.id,
    required this.nombre,
    required this.categoriaId,
    required this.descripcion,
    required this.edades,
    required this.reunion,
    required this.lugar,
    required this.imagenUrl,
    this.eventos = const [],
  });

  final String id;
  final String nombre;
  final String categoriaId; // 'discipulado' | 'nuevas'
  final String descripcion;
  final String edades;
  final String reunion;
  final String lugar;
  final String imagenUrl;
  final List<Evento> eventos;
}

class Publicacion {
  const Publicacion({
    required this.id,
    required this.categoria,
    required this.titulo,
    required this.resumen,
    required this.cuerpo,
    required this.fecha,
    required this.autor,
    this.imagenUrl = '',
    this.destacada = false,
    this.meGustas = 0,
    this.comentarios = 0,
  });

  final String id;
  final String categoria;
  final String titulo;
  final String resumen;
  final String cuerpo; // párrafos separados por una línea en blanco
  final DateTime fecha;
  final String autor;
  final String imagenUrl;
  final bool destacada;
  final int meGustas;
  final int comentarios;
}

class Peticion {
  const Peticion({
    required this.id,
    required this.autor,
    required this.anonima,
    required this.texto,
    required this.fecha,
    required this.oraciones,
    required this.comentarios,
    this.titulo = '',
    this.activa = true,
  });

  final String id;
  final String autor;
  final bool anonima;
  final String texto;
  final DateTime fecha;
  final int oraciones;
  final int comentarios;
  final String titulo;
  final bool activa;
}

class Notificacion {
  const Notificacion({
    required this.id,
    required this.tipo,
    required this.titulo,
    required this.subtitulo,
    required this.detalle,
    required this.fecha,
  });

  final String id;
  final TipoNotificacion tipo;
  final String titulo;
  final String subtitulo;
  final String detalle;
  final DateTime fecha;
}
