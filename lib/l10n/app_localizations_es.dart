// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navInicio => 'Inicio';

  @override
  String get navEventos => 'Eventos';

  @override
  String get navPredicas => 'Prédicas';

  @override
  String get navMinisterios => 'Ministerios';

  @override
  String get navMas => 'Más';

  @override
  String get proximamente => 'Próximamente';

  @override
  String get adminPanel => 'Panel de administración';

  @override
  String get bienvenidaTitulo => 'Bienvenido a la comunidad de Cristo Viene';

  @override
  String get bienvenidaSubtitulo =>
      'Conectando personas, compartiendo el evangelio y sirviendo a nuestra comunidad.';

  @override
  String get empezar => 'Empezar';

  @override
  String get iniciarSesion => 'Iniciar Sesión';

  @override
  String get sinCuentaPregunta => '¿Aún no tienes cuenta?';

  @override
  String get crearCuentaLink => 'Crear Cuenta';

  @override
  String get correoElectronico => 'Correo electrónico';

  @override
  String get contrasena => 'Contraseña';

  @override
  String get olvidasteContrasena => '¿Olvidaste tu contraseña?';

  @override
  String get ingresar => 'Ingresar';

  @override
  String get oContinuarCon => 'O Continuar Con';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get crearCuenta => 'Crear Cuenta';

  @override
  String get yaTienesCuenta => '¿Ya tienes cuenta?';

  @override
  String get iniciarSesionLink => 'Iniciar Sesión';

  @override
  String get confirmarContrasena => 'Confirmar contraseña';

  @override
  String get registrar => 'Registrar';

  @override
  String get olvideContrasena => 'Olvidé mi contraseña';

  @override
  String get olvideContrasenaDesc =>
      'Ingresa el correo electrónico asociado a tu cuenta';

  @override
  String get enviarCodigo => 'Enviar Código';

  @override
  String get codigoVerificacion => 'Código de verificación';

  @override
  String get codigoVerificacionDesc =>
      'Ingresa el código que recibiste para verificar tu identidad';

  @override
  String get validar => 'Validar';

  @override
  String get noRecibisteCodigo => '¿No recibiste el código?';

  @override
  String get reenviar => 'Reenviar';

  @override
  String get codigoReenviado => 'Te enviamos un nuevo código.';

  @override
  String get cambiarContrasena => 'Cambiar contraseña';

  @override
  String get cambiarContrasenaDesc =>
      'Crea una contraseña segura que puedas recordar';

  @override
  String get nuevaContrasena => 'Nueva contraseña';

  @override
  String get confirmarNuevaContrasena => 'Confirmar nueva contraseña';

  @override
  String get continuar => 'Continuar';

  @override
  String get contrasenaActualizada =>
      'Tu contraseña fue actualizada. Inicia sesión.';

  @override
  String get completarPerfilTitulo => 'Completa tu perfil';

  @override
  String get completarPerfilDesc =>
      'Necesitamos unos datos para terminar de crear tu cuenta.';

  @override
  String get nombre => 'Nombre';

  @override
  String get primerApellido => 'Primer apellido';

  @override
  String get segundoApellido => 'Segundo apellido (opcional)';

  @override
  String get genero => 'Género';

  @override
  String get hombre => 'Hombre';

  @override
  String get mujer => 'Mujer';

  @override
  String get fechaNacimiento => 'Fecha de nacimiento';

  @override
  String get accesoDenegadoTitulo => 'Acceso restringido';

  @override
  String get accesoDenegadoDesc =>
      'La versión web es solo para administradores. Usa la aplicación móvil.';

  @override
  String get cerrarSesion => 'Cerrar sesión';

  @override
  String get legalTerminosTitulo => 'Términos y condiciones';

  @override
  String get legalPoliticasTitulo => 'Políticas de privacidad';

  @override
  String get legalTerminosEncabezado => 'Nuestros términos';

  @override
  String get legalPoliticasEncabezado => 'Nuestras políticas';

  @override
  String legalUltimaActualizacion(DateTime fecha) {
    final intl.DateFormat fechaDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String fechaString = fechaDateFormat.format(fecha);

    return 'Última actualización: $fechaString';
  }

  @override
  String get errLegal => 'No pudimos cargar el documento.';

  @override
  String get reintentar => 'Reintentar';

  @override
  String get errCampoRequerido => 'Este campo es obligatorio';

  @override
  String get errCorreoInvalido => 'Ingresa un correo válido';

  @override
  String get errContrasenaDebil => 'Mínimo 8 caracteres, con letras y números';

  @override
  String get errContrasenasNoCoinciden => 'Las contraseñas no coinciden';

  @override
  String get errCodigoIncompleto => 'Ingresa los 6 dígitos';

  @override
  String get errGenero => 'Selecciona tu género';

  @override
  String get errFechaNacimiento => 'Selecciona tu fecha de nacimiento';

  @override
  String get errCredenciales => 'Correo o contraseña incorrectos';

  @override
  String get errCodigoInvalido => 'El código es incorrecto';

  @override
  String get errCodigoExpirado => 'El código expiró. Solicita uno nuevo';

  @override
  String get errDemasiadosIntentos => 'Demasiados intentos. Intenta más tarde';

  @override
  String get errSinConexion => 'Sin conexión. Revisa tu internet';

  @override
  String get errNoDisponible => 'No disponible por ahora';

  @override
  String get errRegistro => 'No pudimos completar el registro';

  @override
  String get errDesconocido => 'Ocurrió un error. Intenta de nuevo';
}
