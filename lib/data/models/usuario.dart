enum Genero {
  hombre('hombre'),
  mujer('mujer');

  const Genero(this.id);
  final String id;

  static Genero? fromId(String? id) {
    for (final g in values) {
      if (g.id == id) return g;
    }
    return null;
  }
}

class Usuario {
  const Usuario({
    required this.idUsuario,
    required this.nombre,
    required this.primerApellido,
    required this.correoElectronico,
    required this.idRol,
    this.segundoApellido = '',
    this.telefono = '',
    this.fotoUrl = '',
    this.activo = true,
    this.genero,
    this.fechaNacimiento,
  });

  final String idUsuario;
  final String nombre;
  final String primerApellido;
  final String segundoApellido;
  final String correoElectronico;
  final String telefono;
  final String fotoUrl;
  final String idRol; // 'usuario' | 'lider' | 'editor' | 'admin'
  final bool activo;
  final Genero? genero;
  final DateTime? fechaNacimiento;

  factory Usuario.fromJson(String id, Map<String, dynamic> json) => Usuario(
        idUsuario: id,
        nombre: json['nombre'] ?? '',
        primerApellido: json['primerApellido'] ?? '',
        segundoApellido: json['segundoApellido'] ?? '',
        correoElectronico: json['correoElectronico'] ?? '',
        telefono: json['telefono'] ?? '',
        fotoUrl: json['fotoUrl'] ?? '',
        idRol: json['idRol'] ?? 'usuario',
        activo: json['activo'] ?? true,
        genero: Genero.fromId(json['genero']),
        fechaNacimiento: _aFecha(json['fechaNacimiento']),
      );

  /// Solo campos que el cliente puede enviar. idRol y activo nunca se
  /// escriben desde la app (los controla el backend).
  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'primerApellido': primerApellido,
        'segundoApellido': segundoApellido,
        'genero': genero?.id,
        'fechaNacimiento': fechaNacimiento,
      };

  Usuario copyWith({
    String? nombre,
    String? primerApellido,
    String? segundoApellido,
    String? telefono,
    String? fotoUrl,
    Genero? genero,
    DateTime? fechaNacimiento,
  }) =>
      Usuario(
        idUsuario: idUsuario,
        nombre: nombre ?? this.nombre,
        primerApellido: primerApellido ?? this.primerApellido,
        segundoApellido: segundoApellido ?? this.segundoApellido,
        correoElectronico: correoElectronico,
        telefono: telefono ?? this.telefono,
        fotoUrl: fotoUrl ?? this.fotoUrl,
        idRol: idRol,
        activo: activo,
        genero: genero ?? this.genero,
        fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      );

  String get nombreCompleto => '$nombre $primerApellido'.trim();

  bool get esAdmin => idRol == 'admin';
  bool get esEditor => idRol == 'editor';
  bool get esLider => idRol == 'lider';

  /// El perfil está completo cuando tiene nombre, primer apellido, género y
  /// fecha de nacimiento. Si no, la app obliga a completarlo.
  bool get perfilCompleto =>
      nombre.trim().isNotEmpty &&
      primerApellido.trim().isNotEmpty &&
      genero != null &&
      fechaNacimiento != null;
}

/// Acepta DateTime, texto ISO o un Timestamp de Firestore (que expone toDate()).
DateTime? _aFecha(Object? valor) {
  if (valor == null) return null;
  if (valor is DateTime) return valor;
  if (valor is String) return DateTime.tryParse(valor);
  try {
    return (valor as dynamic).toDate() as DateTime;
  } catch (_) {
    return null;
  }
}
