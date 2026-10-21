import 'usuario.dart';

/// Datos que se piden justo después de crear la cuenta.
class DatosPerfil {
  const DatosPerfil({
    required this.nombre,
    required this.primerApellido,
    required this.genero,
    required this.fechaNacimiento,
    this.segundoApellido = '',
  });

  final String nombre;
  final String primerApellido;
  final String segundoApellido;
  final Genero genero;
  final DateTime fechaNacimiento;
}
