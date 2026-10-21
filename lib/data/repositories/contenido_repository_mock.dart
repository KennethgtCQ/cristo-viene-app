import '../models/contenido.dart';
import 'contenido_repository.dart';

/// SOLO DEBUG. Datos de prueba basados en el diseño. El contenido real vendrá de Firestore.
class ContenidoRepositoryMock implements ContenidoRepository {
  ContenidoRepositoryMock() {
    _eventos = [
      Evento(id: 'e1', titulo: 'Servicio General', inicio: _dia(2, 17, 30), fin: _dia(2, 19), lugar: 'Templo', imagenUrl: _img('ev1')),
      Evento(id: 'e2', titulo: 'Servicio Dominical', inicio: _dia(3, 10, 15), fin: _dia(3, 12), lugar: 'Templo'),
      Evento(id: 'e3', titulo: 'Reunión Magma', inicio: _dia(4, 19), fin: _dia(4, 21), lugar: 'Templo'),
      Evento(id: 'e4', titulo: 'Campamento', inicio: _dia(30, 16), fin: _dia(30, 18), lugar: 'Templo'),
      Evento(id: 'e5', titulo: 'Servicio General', inicio: _dia(-5, 17, 30), fin: _dia(-5, 19), lugar: 'Templo'),
      Evento(id: 'e6', titulo: 'Campaña recolección de víveres', inicio: _dia(-10, 9), fin: _dia(-10, 12), lugar: 'Templo'),
    ];

    _predicas = [
      Predica(id: 'p1', serie: 'Nombre Serie', titulo: 'Nombre Capítulo', minutos: 10, fecha: _dia(7, 10), imagenUrl: _img('pr1')),
      Predica(id: 'p2', serie: 'Nombre Serie', titulo: 'Nombre Capítulo', minutos: 10, fecha: _dia(14, 10), imagenUrl: _img('pr2')),
      Predica(id: 'p3', serie: 'Nombre Serie', titulo: 'Nombre Capítulo', minutos: 10, fecha: _dia(-7, 10), imagenUrl: _img('pr3')),
      Predica(id: 'p4', serie: 'Nombre Serie', titulo: 'Nombre Capítulo', minutos: 10, fecha: _dia(-14, 10), imagenUrl: _img('pr4')),
    ];

    final nave3Eventos = [_eventos[2]];
    _ministerios = [
      Ministerio(id: 'nave3', nombre: 'Nave 3', categoriaId: 'nuevas', descripcion: 'Una generación que aprende de Dios, descubre sus talentos y crece junto a otros mientras se divierten.', edades: '1.5 - 9 años', reunion: 'Sábados 3:00 pm', lugar: 'Templo', imagenUrl: _img('nave3'), eventos: nave3Eventos),
      Ministerio(id: 'ruta1', nombre: 'Ruta 1', categoriaId: 'nuevas', descripcion: 'Descripción del ministerio.', edades: '10 - 12 años', reunion: 'Sábados 3:00 pm', lugar: 'Templo', imagenUrl: _img('ruta1')),
      Ministerio(id: 'muelle7', nombre: 'Muelle 7', categoriaId: 'nuevas', descripcion: 'Descripción del ministerio.', edades: '13 - 17 años', reunion: 'Sábados 4:00 pm', lugar: 'Templo', imagenUrl: _img('muelle7')),
      Ministerio(id: 'magma', nombre: 'Magma', categoriaId: 'nuevas', descripcion: 'Descripción del ministerio.', edades: '18 - 25 años', reunion: 'Viernes 7:00 pm', lugar: 'Templo', imagenUrl: _img('magma'), eventos: [_eventos[2]]),
      Ministerio(id: 'mujeres', nombre: 'Mujeres', categoriaId: 'discipulado', descripcion: 'Creciendo en La Palabra, en la vida y en el propósito que Dios tiene para ti.', edades: 'Adultas', reunion: 'Miércoles 7:00 pm', lugar: 'Templo', imagenUrl: _img('mujeres')),
      Ministerio(id: 'hombres', nombre: 'Hombres', categoriaId: 'discipulado', descripcion: 'Creciendo en La Palabra, en la vida y en el propósito que Dios tiene para ti.', edades: 'Adultos', reunion: 'Jueves 7:00 pm', lugar: 'Templo', imagenUrl: _img('hombres')),
      Ministerio(id: 'paso4', nombre: 'Paso 4', categoriaId: 'discipulado', descripcion: 'Creciendo en La Palabra, en la vida y en el propósito que Dios tiene para ti.', edades: 'Todas', reunion: 'Sábados 9:00 am', lugar: 'Templo', imagenUrl: _img('paso4')),
      Ministerio(id: 'matrimonios', nombre: 'Matrimonios', categoriaId: 'discipulado', descripcion: 'Creciendo en La Palabra, en la vida y en el propósito que Dios tiene para ti.', edades: 'Parejas', reunion: 'Viernes 6:00 pm', lugar: 'Templo', imagenUrl: _img('matrimonios')),
    ];

    _publicaciones = [
      Publicacion(id: 'b1', categoria: 'IGLESIA', titulo: '20 años sirviendo con fe, amor y propósito en Cristo Viene', resumen: 'Celebramos dos décadas de servicio a nuestra comunidad.', cuerpo: _cuerpo, fecha: DateTime(2025, 4, 5, 17), autor: 'Daniel Hernández', imagenUrl: _img('boletin1'), destacada: true, meGustas: 90, comentarios: 21),
      Publicacion(id: 'b2', categoria: 'SERVICIO', titulo: 'Campaña de recolección de ropa', resumen: '¡Tú ayudas hace la diferencia! Conoce cómo ser parte de esta campaña.', cuerpo: _cuerpo, fecha: DateTime(2025, 4, 5, 17), autor: 'Ministerio de Servicio', imagenUrl: _img('boletin2'), destacada: true),
      Publicacion(id: 'b3', categoria: 'SERVICIO', titulo: 'Campaña de recolección de ropa', resumen: '¡Tú ayudas hace la diferencia! Conoce cómo ser parte de esta campaña.', cuerpo: _cuerpo, fecha: DateTime(2025, 4, 5, 17), autor: 'Ministerio de Servicio', imagenUrl: _img('boletin3')),
      Publicacion(id: 'b4', categoria: 'SERVICIO', titulo: 'Campaña de recolección de ropa', resumen: '¡Tú ayudas hace la diferencia! Conoce cómo ser parte de esta campaña.', cuerpo: _cuerpo, fecha: DateTime(2025, 4, 5, 17), autor: 'Ministerio de Servicio', imagenUrl: _img('boletin4')),
    ];

    _peticiones = [
      Peticion(id: 'o1', autor: 'Daniel Hernández', anonima: false, texto: 'Oren por la salud de mi mamá, que ha tenido complicaciones en su recuperación. Gracias por su apoyo y oraciones.', fecha: _ahoraMenos(const Duration(hours: 2)), oraciones: 9, comentarios: 4, titulo: 'Salud de mi mamá'),
      Peticion(id: 'o2', autor: '', anonima: true, texto: 'Pido por mi familia, para que Dios nos dé sabiduría, unidad y protección en este nuevo proceso.', fecha: _ahoraMenos(const Duration(hours: 10)), oraciones: 14, comentarios: 5, titulo: 'Por mi proceso'),
      Peticion(id: 'o3', autor: 'María González', anonima: false, texto: 'Oren por mi trabajo y por las puertas que Dios quiera abrir. Confío en su tiempo perfecto.', fecha: _ahoraMenos(const Duration(days: 1)), oraciones: 26, comentarios: 8, titulo: 'Por mi trabajo'),
    ];
    _misPeticiones = [
      _peticiones[0],
      _peticiones[1],
      _peticiones[2],
      Peticion(id: 'o4', autor: 'Dev', anonima: false, texto: 'Oren por mi viaje.', fecha: _ahoraMenos(const Duration(days: 9)), oraciones: 3, comentarios: 0, titulo: 'Por mi viaje', activa: false),
    ];

    _notificaciones = [
      Notificacion(id: 'n1', tipo: TipoNotificacion.evento, titulo: 'Nuevo evento', subtitulo: 'Campamento', detalle: 'Sáb, 18 de setiembre - 4:00 pm', fecha: _ahoraMenos(const Duration(hours: 1))),
      Notificacion(id: 'n2', tipo: TipoNotificacion.anuncio, titulo: 'Anuncio', subtitulo: 'Campaña recolección de víveres', detalle: '¡Tu ayuda hace la diferencia!', fecha: _ahoraMenos(const Duration(hours: 3))),
      Notificacion(id: 'n3', tipo: TipoNotificacion.recordatorio, titulo: 'Recordatorio', subtitulo: 'Servicio General', detalle: 'Mañana - 7:00 pm', fecha: _ahoraMenos(const Duration(days: 1))),
      Notificacion(id: 'n4', tipo: TipoNotificacion.peticion, titulo: 'Petición de oración', subtitulo: 'Anónimo', detalle: 'Necesitan de nuestras oraciones', fecha: _ahoraMenos(const Duration(days: 2))),
      Notificacion(id: 'n5', tipo: TipoNotificacion.ministerio, titulo: 'Ministerios', subtitulo: 'Cambio de horario Magma', detalle: 'Ahora los sábados a la 1:00 pm', fecha: _ahoraMenos(const Duration(days: 3))),
    ];
  }

  late final List<Evento> _eventos;
  late final List<Predica> _predicas;
  late final List<Ministerio> _ministerios;
  late final List<Publicacion> _publicaciones;
  late final List<Peticion> _peticiones;
  late final List<Peticion> _misPeticiones;
  late final List<Notificacion> _notificaciones;

  static const _cuerpo =
      'Durante estos años hemos visto cómo Dios ha obrado en cada familia que pasa por nuestras puertas.\n\n'
      'Agradecemos a cada persona que ha servido, orado y dado con generosidad para que este camino siga creciendo.\n\n'
      'Seguimos avanzando con la misma fe y el mismo propósito.';

  static DateTime _dia(int dias, int hora, [int minuto = 0]) {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day + dias, hora, minuto);
  }

  static DateTime _ahoraMenos(Duration d) => DateTime.now().subtract(d);

  static String _img(String semilla) => 'https://picsum.photos/seed/$semilla/800/500';

  @override
  Future<List<Evento>> eventos() async => _eventos;

  @override
  Future<List<Predica>> predicas() async => _predicas;

  @override
  Future<List<Ministerio>> ministerios() async => _ministerios;

  @override
  Future<Ministerio?> ministerio(String id) async {
    for (final m in _ministerios) {
      if (m.id == id) return m;
    }
    return null;
  }

  @override
  Future<List<Publicacion>> publicaciones() async => _publicaciones;

  @override
  Future<Publicacion?> publicacion(String id) async {
    for (final p in _publicaciones) {
      if (p.id == id) return p;
    }
    return null;
  }

  @override
  Future<List<Peticion>> peticiones() async => _peticiones;

  @override
  Future<List<Peticion>> misPeticiones() async => _misPeticiones;

  @override
  Future<void> crearPeticion({required String texto, required bool anonima}) async {
    final nueva = Peticion(
      id: 'o${_misPeticiones.length + 1}',
      autor: anonima ? '' : 'Dev',
      anonima: anonima,
      texto: texto,
      fecha: DateTime.now(),
      oraciones: 0,
      comentarios: 0,
    );
    _peticiones.insert(0, nueva);
    _misPeticiones.insert(0, nueva);
  }

  @override
  Future<List<Notificacion>> notificaciones() async => _notificaciones;
}
