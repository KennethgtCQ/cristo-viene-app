import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../core/errors/error_auth.dart';
import '../../../data/models/datos_perfil.dart';
import '../../../data/models/usuario.dart';
import '../../../data/repositories/auth_repository.dart';

enum FlujoOtp { registro, recuperacion }

/// Un solo ViewModel para login, registro, recuperación, OTP y perfil inicial.
/// Los datos del flujo en curso (clave, código) viven solo en memoria y se
/// borran al terminar o cancelar; nunca viajan por la URL de la ruta.
class AuthViewModel extends ChangeNotifier {
  AuthViewModel(this._repository) {
    _sub = _repository.estadoUsuario.listen(
      (u) {
        _usuario = u;
        _inicializando = false;
        notifyListeners();
      },
      onError: (_) {
        _usuario = null;
        _inicializando = false;
        notifyListeners();
      },
    );
  }

  final AuthRepository _repository;
  StreamSubscription<Usuario?>? _sub;

  Usuario? _usuario;
  bool _inicializando = true;
  bool _cargando = false;
  ErrorAuth? _error;

  String? _correoRegistro;
  String? _contrasenaRegistro;
  String? _idOtpRegistro;

  String? _correoRecuperacion;
  String? _idOtpRecuperacion;
  String? _codigoRecuperacion;

  Usuario? get usuario => _usuario;
  bool get autenticado => _usuario != null;
  bool get inicializando => _inicializando;
  bool get cargando => _cargando;
  ErrorAuth? get error => _error;

  bool get hayRegistroPendiente => _idOtpRegistro != null;
  bool get hayRecuperacionPendiente => _idOtpRecuperacion != null;
  bool get recuperacionVerificada => _codigoRecuperacion != null;

  void limpiarError() {
    if (_error == null) return;
    _error = null;
    notifyListeners();
  }

  Future<bool> _ejecutar(Future<void> Function() accion) async {
    _cargando = true;
    _error = null;
    notifyListeners();
    try {
      await accion();
      return true;
    } on AuthException catch (e) {
      _error = e.codigo;
      return false;
    } catch (_) {
      _error = ErrorAuth.desconocido;
      return false;
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  String _normalizar(String correo) => correo.trim().toLowerCase();

  // ---- Login ----
  Future<bool> login(String correo, String contrasena) => _ejecutar(() async {
        _usuario = await _repository.login(_normalizar(correo), contrasena);
      });

  Future<bool> loginConProveedor(ProveedorAuth proveedor) => _ejecutar(() async {
        _usuario = await _repository.loginConProveedor(proveedor);
      });

  Future<void> logout() async {
    await _repository.logout();
    _usuario = null;
    _limpiarFlujos();
    notifyListeners();
  }

  // ---- Registro ----
  Future<bool> iniciarRegistro(String correo, String contrasena) => _ejecutar(() async {
        final c = _normalizar(correo);
        final idOtp = await _repository.solicitarOtp('registro', c);
        _correoRegistro = c;
        _contrasenaRegistro = contrasena;
        _idOtpRegistro = idOtp;
      });

  Future<bool> confirmarRegistro(String codigo) => _ejecutar(() async {
        final idOtp = _idOtpRegistro;
        final correo = _correoRegistro;
        final contrasena = _contrasenaRegistro;
        if (idOtp == null || correo == null || contrasena == null) {
          throw const AuthException(ErrorAuth.registroFallido);
        }
        _usuario = await _repository.registrarConOtp(
          idOtp: idOtp,
          codigo: codigo,
          correo: correo,
          contrasena: contrasena,
        );
        _limpiarFlujos();
      });

  // ---- Recuperación ----
  Future<bool> iniciarRecuperacion(String correo) => _ejecutar(() async {
        final c = _normalizar(correo);
        final idOtp = await _repository.solicitarOtp('recuperacion', c);
        _correoRecuperacion = c;
        _idOtpRecuperacion = idOtp;
        _codigoRecuperacion = null;
      });

  Future<bool> verificarCodigoRecuperacion(String codigo) => _ejecutar(() async {
        final idOtp = _idOtpRecuperacion;
        if (idOtp == null) throw const AuthException(ErrorAuth.codigoInvalido);
        await _repository.verificarOtp(idOtp, codigo);
        _codigoRecuperacion = codigo;
      });

  Future<bool> cambiarContrasena(String nueva) => _ejecutar(() async {
        final idOtp = _idOtpRecuperacion;
        final correo = _correoRecuperacion;
        final codigo = _codigoRecuperacion;
        if (idOtp == null || correo == null || codigo == null) {
          throw const AuthException(ErrorAuth.codigoInvalido);
        }
        await _repository.cambiarContrasenaConOtp(
          idOtp: idOtp,
          codigo: codigo,
          correo: correo,
          nuevaContrasena: nueva,
        );
        // El flujo se cierra desde la vista con cancelarFlujo, después de navegar:
        // si se limpiara aquí, el router sacaría al usuario de la pantalla antes.
      });

  // ---- OTP compartido ----
  Future<bool> reenviarCodigo(FlujoOtp flujo) => _ejecutar(() async {
        switch (flujo) {
          case FlujoOtp.registro:
            final correoRegistro = _correoRegistro;
            if (correoRegistro == null) {
              throw const AuthException(ErrorAuth.registroFallido);
            }
            _idOtpRegistro = await _repository.solicitarOtp('registro', correoRegistro);
          case FlujoOtp.recuperacion:
            final correoRecuperacion = _correoRecuperacion;
            if (correoRecuperacion == null) {
              throw const AuthException(ErrorAuth.codigoInvalido);
            }
            _idOtpRecuperacion =
                await _repository.solicitarOtp('recuperacion', correoRecuperacion);
            _codigoRecuperacion = null;
        }
      });

  void cancelarFlujo(FlujoOtp flujo) {
    switch (flujo) {
      case FlujoOtp.registro:
        _correoRegistro = null;
        _contrasenaRegistro = null;
        _idOtpRegistro = null;
      case FlujoOtp.recuperacion:
        _correoRecuperacion = null;
        _idOtpRecuperacion = null;
        _codigoRecuperacion = null;
    }
    _error = null;
    notifyListeners();
  }

  // ---- Perfil inicial ----
  Future<bool> completarPerfil(DatosPerfil datos) => _ejecutar(() async {
        _usuario = await _repository.completarPerfil(datos);
      });

  void _limpiarFlujos() {
    _correoRegistro = null;
    _contrasenaRegistro = null;
    _idOtpRegistro = null;
    _correoRecuperacion = null;
    _idOtpRecuperacion = null;
    _codigoRecuperacion = null;
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
