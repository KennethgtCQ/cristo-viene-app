import '../models/datos_perfil.dart';
import '../models/usuario.dart';

enum ProveedorAuth { google, apple }

abstract class AuthRepository {
  Stream<Usuario?> get estadoUsuario;

  Future<Usuario> login(String correo, String contrasena);
  Future<Usuario> loginConProveedor(ProveedorAuth proveedor);
  Future<void> logout();

  /// tipo: 'registro' | 'recuperacion'. Devuelve el idOtp.
  Future<String> solicitarOtp(String tipo, String correo);

  /// Comprueba el código sin consumirlo (flujo de recuperación).
  Future<void> verificarOtp(String idOtp, String codigo);

  Future<Usuario> registrarConOtp({
    required String idOtp,
    required String codigo,
    required String correo,
    required String contrasena,
  });

  Future<void> cambiarContrasenaConOtp({
    required String idOtp,
    required String codigo,
    required String correo,
    required String nuevaContrasena,
  });

  Future<Usuario> completarPerfil(DatosPerfil datos);
}
