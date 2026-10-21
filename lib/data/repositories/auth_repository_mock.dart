import 'dart:async';
import '../../core/errors/error_auth.dart';
import '../models/datos_perfil.dart';
import '../models/usuario.dart';
import 'auth_repository.dart';

/// SOLO DEBUG. Simula el backend en memoria para trabajar la UI sin Firebase.
/// dependencies.dart lo usa únicamente con kDebugMode; en release se exige
/// la implementación real.
///
/// Cuentas: usuario@dev.local, lider@dev.local, editor@dev.local, admin@dev.local
/// Clave: Prueba123!   Código OTP: 123456
class AuthRepositoryMock implements AuthRepository {
  AuthRepositoryMock() {
    for (final rol in ['usuario', 'lider', 'editor', 'admin']) {
      final correo = '$rol@dev.local';
      _cuentas[correo] = (
        contrasena: _claveDev,
        usuario: Usuario(
          idUsuario: 'dev-$rol',
          nombre: 'Dev',
          primerApellido: rol,
          correoElectronico: correo,
          idRol: rol,
          genero: Genero.mujer,
          fechaNacimiento: DateTime(2005, 6, 11),
        ),
      );
    }
  }

  static const _claveDev = 'Prueba123!';
  static const _codigoDev = '123456';
  static const _maxIntentos = 5;

  final _cuentas = <String, ({String contrasena, Usuario usuario})>{};
  final _otps = <String, _OtpMock>{};
  final _controller = StreamController<Usuario?>.broadcast();
  Usuario? _actual;

  @override
  Stream<Usuario?> get estadoUsuario async* {
    yield _actual;
    yield* _controller.stream;
  }

  void _emitir(Usuario? usuario) {
    _actual = usuario;
    _controller.add(usuario);
  }

  Future<void> _latencia() => Future<void>.delayed(const Duration(milliseconds: 400));

  @override
  Future<Usuario> login(String correo, String contrasena) async {
    await _latencia();
    final cuenta = _cuentas[correo.trim().toLowerCase()];
    if (cuenta == null || cuenta.contrasena != contrasena) {
      throw const AuthException(ErrorAuth.credencialesInvalidas);
    }
    _emitir(cuenta.usuario);
    return cuenta.usuario;
  }

  @override
  Future<Usuario> loginConProveedor(ProveedorAuth proveedor) async {
    await _latencia();
    throw const AuthException(ErrorAuth.noDisponible);
  }

  @override
  Future<void> logout() async {
    _emitir(null);
  }

  @override
  Future<String> solicitarOtp(String tipo, String correo) async {
    await _latencia();
    if (tipo != 'registro' && tipo != 'recuperacion') {
      throw const AuthException(ErrorAuth.desconocido);
    }
    final id = 'otp-${_otps.length + 1}';
    _otps[id] = _OtpMock(correo.trim().toLowerCase(), tipo);
    return id;
  }

  _OtpMock _comprobar(String idOtp, String codigo) {
    final otp = _otps[idOtp];
    if (otp == null) throw const AuthException(ErrorAuth.codigoInvalido);
    if (otp.intentos >= _maxIntentos) {
      throw const AuthException(ErrorAuth.demasiadosIntentos);
    }
    otp.intentos++;
    if (codigo != _codigoDev) throw const AuthException(ErrorAuth.codigoInvalido);
    return otp;
  }

  @override
  Future<void> verificarOtp(String idOtp, String codigo) async {
    await _latencia();
    _comprobar(idOtp, codigo);
  }

  @override
  Future<Usuario> registrarConOtp({
    required String idOtp,
    required String codigo,
    required String correo,
    required String contrasena,
  }) async {
    await _latencia();
    final otp = _comprobar(idOtp, codigo);
    final correoNorm = correo.trim().toLowerCase();
    if (otp.tipo != 'registro' || otp.correo != correoNorm) {
      throw const AuthException(ErrorAuth.codigoInvalido);
    }
    if (_cuentas.containsKey(correoNorm)) {
      throw const AuthException(ErrorAuth.registroFallido);
    }
    final usuario = Usuario(
      idUsuario: 'dev-${_cuentas.length + 1}',
      nombre: '',
      primerApellido: '',
      correoElectronico: correoNorm,
      idRol: 'usuario',
    );
    _cuentas[correoNorm] = (contrasena: contrasena, usuario: usuario);
    _emitir(usuario);
    return usuario;
  }

  @override
  Future<void> cambiarContrasenaConOtp({
    required String idOtp,
    required String codigo,
    required String correo,
    required String nuevaContrasena,
  }) async {
    await _latencia();
    final otp = _comprobar(idOtp, codigo);
    if (otp.tipo != 'recuperacion' || otp.correo != correo.trim().toLowerCase()) {
      throw const AuthException(ErrorAuth.codigoInvalido);
    }
    final cuenta = _cuentas[otp.correo];
    if (cuenta != null) {
      _cuentas[otp.correo] = (contrasena: nuevaContrasena, usuario: cuenta.usuario);
    }
    _otps.remove(idOtp); // un solo uso
  }

  @override
  Future<Usuario> completarPerfil(DatosPerfil datos) async {
    await _latencia();
    final actual = _actual;
    if (actual == null) throw const AuthException(ErrorAuth.desconocido);
    final nuevo = actual.copyWith(
      nombre: datos.nombre,
      primerApellido: datos.primerApellido,
      segundoApellido: datos.segundoApellido,
      genero: datos.genero,
      fechaNacimiento: datos.fechaNacimiento,
    );
    _cuentas[actual.correoElectronico] = (
      contrasena: _cuentas[actual.correoElectronico]!.contrasena,
      usuario: nuevo,
    );
    _emitir(nuevo);
    return nuevo;
  }
}

class _OtpMock {
  _OtpMock(this.correo, this.tipo);
  final String correo;
  final String tipo;
  int intentos = 0;
}
