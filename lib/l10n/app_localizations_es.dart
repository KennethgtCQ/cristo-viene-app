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

  @override
  String holaNombre(String nombre) {
    return '¡Hola, $nombre!';
  }

  @override
  String get esUnGustoTenerteAqui => 'Es un gusto tenerte aquí';

  @override
  String get unaIglesiaUnaFamilia => 'Una iglesia, una sola familia';

  @override
  String get heroDescripcion =>
      'Conectando personas, compartiendo el evangelio y sirviendo a nuestra comunidad.';

  @override
  String get accesoBiblia => 'Biblia';

  @override
  String get accesoBoletin => 'Boletín';

  @override
  String get accesoOfrendar => 'Ofrendar';

  @override
  String get accesoOraciones => 'Oraciones';

  @override
  String get proximoEvento => 'Próximo evento';

  @override
  String get noticias => 'Noticias';

  @override
  String get buscar => 'Buscar';

  @override
  String get proximos => 'Próximos';

  @override
  String get pasados => 'Pasados';

  @override
  String get serie => 'Serie';

  @override
  String minutos(int n) {
    return '$n min';
  }

  @override
  String get categoriaDiscipulado => 'Discipulado';

  @override
  String get categoriaNuevasGeneraciones => 'Nuevas generaciones';

  @override
  String get sobreEsteMinisterio => 'Sobre este ministerio';

  @override
  String get ministerioEdades => 'Edades';

  @override
  String get ministerioReuniones => 'Reuniones';

  @override
  String get ministerioLugar => 'Lugar';

  @override
  String get unirme => 'Unirme';

  @override
  String get proximosEventos => 'Próximos eventos';

  @override
  String get loMasReciente => 'Lo más reciente';

  @override
  String get peticionesTitulo => 'Peticiones de oración';

  @override
  String get peticionesDescripcion =>
      'Únete en oración por las necesidades de nuestra comunidad. Dios escucha cada petición.';

  @override
  String get agregarPeticion => '+ Agregar petición';

  @override
  String get misPeticionesTitulo => 'Mis peticiones de oración';

  @override
  String get misPeticionesDescripcion =>
      'Tus peticiones también importan. Dios te escucha.';

  @override
  String get activas => 'Activas';

  @override
  String get inactivas => 'Inactivas';

  @override
  String get solicitudOracion => 'Solicitud de oración';

  @override
  String get solicitudOracionDescripcion =>
      '¿Tienes una petición especial? Nos encantaría orar por ti';

  @override
  String get publicarAnonima => 'Publicar de forma anónima';

  @override
  String get tuPeticion => 'Tu petición de oración';

  @override
  String get anonimo => 'Anónimo';

  @override
  String get enviar => 'Enviar';

  @override
  String get peticionEnviada => 'Tu petición fue enviada.';

  @override
  String get notificacionesTitulo => 'Notificaciones';

  @override
  String get filtroTodas => 'Todas';

  @override
  String get filtroEventos => 'Eventos';

  @override
  String get filtroAnuncios => 'Anuncios';

  @override
  String get filtroMinisterios => 'Ministerios';

  @override
  String get ofrendasTitulo => 'Ofrendas';

  @override
  String get ofrendasApoyar => '¿Qué te gustaría apoyar?';

  @override
  String get ofrendasApoyarDescripcion =>
      'Selecciona una iniciativa de la iglesia.';

  @override
  String get ofrendaBuenSamaritano => 'Buen Samaritano';

  @override
  String get ofrendaBuenSamaritanoDesc =>
      'Apoyando a las familias que más lo necesitan.';

  @override
  String get ofrendaCasaNueva => 'Casa Nueva';

  @override
  String get ofrendaCasaNuevaDesc => 'Ayuda a construir nuestro nuevo templo.';

  @override
  String get ofrendaMisiones => 'Misiones';

  @override
  String get ofrendaMisionesDesc =>
      'Haz que el mensaje de redención llegue más allá de las fronteras.';

  @override
  String get ofrendaOtro => 'Otro';

  @override
  String get ofrendaOtroDesc =>
      'Colaboras con el mantenimiento del templo y/o cualquiera de las otras causas.';

  @override
  String get banco => 'Banco';

  @override
  String get monto => 'Monto';

  @override
  String get otro => 'Otro';

  @override
  String get donarAhora => 'Donar ahora';

  @override
  String get otrasFormasDeOfrendar => 'Otras formas de ofrendar';

  @override
  String get transferencia => 'Transferencia';

  @override
  String get cuentaNumero => 'Cuenta';

  @override
  String get cuentaCliente => 'Cuenta cliente';

  @override
  String get cuentaIban => 'Cuenta IBAN';

  @override
  String get concepto => 'Concepto';

  @override
  String get beneficiario => 'Nombre';

  @override
  String get colones => 'Colones';

  @override
  String get dolares => 'Dólares';

  @override
  String get cerrar => 'Cerrar';

  @override
  String get libros => 'Libros';

  @override
  String get sinContenido => 'Por ahora no hay contenido.';
}
