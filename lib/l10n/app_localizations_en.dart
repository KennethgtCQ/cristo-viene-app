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
}
