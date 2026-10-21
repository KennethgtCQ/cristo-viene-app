// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navInicio => 'Home';

  @override
  String get navEventos => 'Events';

  @override
  String get navPredicas => 'Sermons';

  @override
  String get navMinisterios => 'Ministries';

  @override
  String get navMas => 'More';

  @override
  String get proximamente => 'Coming soon';

  @override
  String get adminPanel => 'Admin panel';

  @override
  String get bienvenidaTitulo => 'Welcome to the Cristo Viene community';

  @override
  String get bienvenidaSubtitulo =>
      'Connecting people, sharing the gospel and serving our community.';

  @override
  String get empezar => 'Get started';

  @override
  String get iniciarSesion => 'Sign In';

  @override
  String get sinCuentaPregunta => 'Don\'t have an account yet?';

  @override
  String get crearCuentaLink => 'Create Account';

  @override
  String get correoElectronico => 'Email';

  @override
  String get contrasena => 'Password';

  @override
  String get olvidasteContrasena => 'Forgot your password?';

  @override
  String get ingresar => 'Sign in';

  @override
  String get oContinuarCon => 'Or continue with';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get crearCuenta => 'Create Account';

  @override
  String get yaTienesCuenta => 'Already have an account?';

  @override
  String get iniciarSesionLink => 'Sign In';

  @override
  String get confirmarContrasena => 'Confirm password';

  @override
  String get registrar => 'Sign up';

  @override
  String get olvideContrasena => 'I forgot my password';

  @override
  String get olvideContrasenaDesc =>
      'Enter the email associated with your account';

  @override
  String get enviarCodigo => 'Send Code';

  @override
  String get codigoVerificacion => 'Verification code';

  @override
  String get codigoVerificacionDesc =>
      'Enter the code you received to verify your identity';

  @override
  String get validar => 'Verify';

  @override
  String get noRecibisteCodigo => 'Didn\'t receive the code?';

  @override
  String get reenviar => 'Resend';

  @override
  String get codigoReenviado => 'We sent you a new code.';

  @override
  String get cambiarContrasena => 'Change password';

  @override
  String get cambiarContrasenaDesc =>
      'Create a secure password you can remember';

  @override
  String get nuevaContrasena => 'New password';

  @override
  String get confirmarNuevaContrasena => 'Confirm new password';

  @override
  String get continuar => 'Continue';

  @override
  String get contrasenaActualizada =>
      'Your password was updated. Please sign in.';

  @override
  String get completarPerfilTitulo => 'Complete your profile';

  @override
  String get completarPerfilDesc =>
      'We need a few details to finish creating your account.';

  @override
  String get nombre => 'First name';

  @override
  String get primerApellido => 'Last name';

  @override
  String get segundoApellido => 'Second last name (optional)';

  @override
  String get genero => 'Gender';

  @override
  String get hombre => 'Male';

  @override
  String get mujer => 'Female';

  @override
  String get fechaNacimiento => 'Date of birth';

  @override
  String get accesoDenegadoTitulo => 'Restricted access';

  @override
  String get accesoDenegadoDesc =>
      'The web version is for administrators only. Please use the mobile app.';

  @override
  String get cerrarSesion => 'Sign out';

  @override
  String get legalTerminosTitulo => 'Terms and conditions';

  @override
  String get legalPoliticasTitulo => 'Privacy policy';

  @override
  String get legalTerminosEncabezado => 'Our terms';

  @override
  String get legalPoliticasEncabezado => 'Our policies';

  @override
  String legalUltimaActualizacion(DateTime fecha) {
    final intl.DateFormat fechaDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String fechaString = fechaDateFormat.format(fecha);

    return 'Last updated: $fechaString';
  }

  @override
  String get errLegal => 'We couldn\'t load the document.';

  @override
  String get reintentar => 'Retry';

  @override
  String get errCampoRequerido => 'This field is required';

  @override
  String get errCorreoInvalido => 'Enter a valid email';

  @override
  String get errContrasenaDebil =>
      'At least 8 characters, with letters and numbers';

  @override
  String get errContrasenasNoCoinciden => 'Passwords don\'t match';

  @override
  String get errCodigoIncompleto => 'Enter all 6 digits';

  @override
  String get errGenero => 'Select your gender';

  @override
  String get errFechaNacimiento => 'Select your date of birth';

  @override
  String get errCredenciales => 'Incorrect email or password';

  @override
  String get errCodigoInvalido => 'The code is incorrect';

  @override
  String get errCodigoExpirado => 'The code expired. Request a new one';

  @override
  String get errDemasiadosIntentos => 'Too many attempts. Try again later';

  @override
  String get errSinConexion => 'No connection. Check your internet';

  @override
  String get errNoDisponible => 'Not available right now';

  @override
  String get errRegistro => 'We couldn\'t complete the registration';

  @override
  String get errDesconocido => 'Something went wrong. Try again';

  @override
  String holaNombre(String nombre) {
    return 'Hi, $nombre!';
  }

  @override
  String get esUnGustoTenerteAqui => 'We\'re glad to have you here';

  @override
  String get unaIglesiaUnaFamilia => 'One church, one family';

  @override
  String get heroDescripcion =>
      'Connecting people, sharing the gospel and serving our community.';

  @override
  String get accesoBiblia => 'Bible';

  @override
  String get accesoBoletin => 'Bulletin';

  @override
  String get accesoOfrendar => 'Give';

  @override
  String get accesoOraciones => 'Prayers';

  @override
  String get proximoEvento => 'Next event';

  @override
  String get noticias => 'News';

  @override
  String get buscar => 'Search';

  @override
  String get proximos => 'Upcoming';

  @override
  String get pasados => 'Past';

  @override
  String get serie => 'Series';

  @override
  String minutos(int n) {
    return '$n min';
  }

  @override
  String get categoriaDiscipulado => 'Discipleship';

  @override
  String get categoriaNuevasGeneraciones => 'New generations';

  @override
  String get sobreEsteMinisterio => 'About this ministry';

  @override
  String get ministerioEdades => 'Ages';

  @override
  String get ministerioReuniones => 'Meetings';

  @override
  String get ministerioLugar => 'Place';

  @override
  String get unirme => 'Join';

  @override
  String get proximosEventos => 'Upcoming events';

  @override
  String get loMasReciente => 'Most recent';

  @override
  String get peticionesTitulo => 'Prayer requests';

  @override
  String get peticionesDescripcion =>
      'Join in prayer for our community\'s needs. God hears every request.';

  @override
  String get agregarPeticion => '+ Add request';

  @override
  String get misPeticionesTitulo => 'My prayer requests';

  @override
  String get misPeticionesDescripcion =>
      'Your requests matter too. God hears you.';

  @override
  String get activas => 'Active';

  @override
  String get inactivas => 'Inactive';

  @override
  String get solicitudOracion => 'Prayer request';

  @override
  String get solicitudOracionDescripcion =>
      'Do you have a special request? We would love to pray for you.';

  @override
  String get publicarAnonima => 'Post anonymously';

  @override
  String get tuPeticion => 'Your prayer request';

  @override
  String get anonimo => 'Anonymous';

  @override
  String get enviar => 'Send';

  @override
  String get peticionEnviada => 'Your request was sent.';

  @override
  String get notificacionesTitulo => 'Notifications';

  @override
  String get filtroTodas => 'All';

  @override
  String get filtroEventos => 'Events';

  @override
  String get filtroAnuncios => 'Announcements';

  @override
  String get filtroMinisterios => 'Ministries';

  @override
  String get ofrendasTitulo => 'Giving';

  @override
  String get ofrendasApoyar => 'What would you like to support?';

  @override
  String get ofrendasApoyarDescripcion => 'Select a church initiative.';

  @override
  String get ofrendaBuenSamaritano => 'Good Samaritan';

  @override
  String get ofrendaBuenSamaritanoDesc =>
      'Supporting the families who need it most.';

  @override
  String get ofrendaCasaNueva => 'New House';

  @override
  String get ofrendaCasaNuevaDesc => 'Help build our new temple.';

  @override
  String get ofrendaMisiones => 'Missions';

  @override
  String get ofrendaMisionesDesc =>
      'Help the message of redemption reach beyond borders.';

  @override
  String get ofrendaOtro => 'Other';

  @override
  String get ofrendaOtroDesc =>
      'Help maintain the temple and/or any other cause.';

  @override
  String get banco => 'Bank';

  @override
  String get monto => 'Amount';

  @override
  String get otro => 'Other';

  @override
  String get donarAhora => 'Donate now';

  @override
  String get otrasFormasDeOfrendar => 'Other ways to give';

  @override
  String get transferencia => 'Transfer';

  @override
  String get cuentaNumero => 'Account';

  @override
  String get cuentaCliente => 'Client account';

  @override
  String get cuentaIban => 'IBAN account';

  @override
  String get concepto => 'Concept';

  @override
  String get beneficiario => 'Name';

  @override
  String get colones => 'Colones';

  @override
  String get dolares => 'Dollars';

  @override
  String get cerrar => 'Close';

  @override
  String get libros => 'Books';

  @override
  String get sinContenido => 'There is no content yet.';
}
