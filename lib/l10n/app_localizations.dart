import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @navInicio.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navInicio;

  /// No description provided for @navEventos.
  ///
  /// In es, this message translates to:
  /// **'Eventos'**
  String get navEventos;

  /// No description provided for @navPredicas.
  ///
  /// In es, this message translates to:
  /// **'Prédicas'**
  String get navPredicas;

  /// No description provided for @navMinisterios.
  ///
  /// In es, this message translates to:
  /// **'Ministerios'**
  String get navMinisterios;

  /// No description provided for @navMas.
  ///
  /// In es, this message translates to:
  /// **'Más'**
  String get navMas;

  /// No description provided for @proximamente.
  ///
  /// In es, this message translates to:
  /// **'Próximamente'**
  String get proximamente;

  /// No description provided for @adminPanel.
  ///
  /// In es, this message translates to:
  /// **'Panel de administración'**
  String get adminPanel;

  /// No description provided for @bienvenidaTitulo.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido a la comunidad de Cristo Viene'**
  String get bienvenidaTitulo;

  /// No description provided for @bienvenidaSubtitulo.
  ///
  /// In es, this message translates to:
  /// **'Conectando personas, compartiendo el evangelio y sirviendo a nuestra comunidad.'**
  String get bienvenidaSubtitulo;

  /// No description provided for @empezar.
  ///
  /// In es, this message translates to:
  /// **'Empezar'**
  String get empezar;

  /// No description provided for @iniciarSesion.
  ///
  /// In es, this message translates to:
  /// **'Iniciar Sesión'**
  String get iniciarSesion;

  /// No description provided for @sinCuentaPregunta.
  ///
  /// In es, this message translates to:
  /// **'¿Aún no tienes cuenta?'**
  String get sinCuentaPregunta;

  /// No description provided for @crearCuentaLink.
  ///
  /// In es, this message translates to:
  /// **'Crear Cuenta'**
  String get crearCuentaLink;

  /// No description provided for @correoElectronico.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get correoElectronico;

  /// No description provided for @contrasena.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get contrasena;

  /// No description provided for @olvidasteContrasena.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get olvidasteContrasena;

  /// No description provided for @ingresar.
  ///
  /// In es, this message translates to:
  /// **'Ingresar'**
  String get ingresar;

  /// No description provided for @oContinuarCon.
  ///
  /// In es, this message translates to:
  /// **'O Continuar Con'**
  String get oContinuarCon;

  /// No description provided for @google.
  ///
  /// In es, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @apple.
  ///
  /// In es, this message translates to:
  /// **'Apple'**
  String get apple;

  /// No description provided for @crearCuenta.
  ///
  /// In es, this message translates to:
  /// **'Crear Cuenta'**
  String get crearCuenta;

  /// No description provided for @yaTienesCuenta.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes cuenta?'**
  String get yaTienesCuenta;

  /// No description provided for @iniciarSesionLink.
  ///
  /// In es, this message translates to:
  /// **'Iniciar Sesión'**
  String get iniciarSesionLink;

  /// No description provided for @confirmarContrasena.
  ///
  /// In es, this message translates to:
  /// **'Confirmar contraseña'**
  String get confirmarContrasena;

  /// No description provided for @registrar.
  ///
  /// In es, this message translates to:
  /// **'Registrar'**
  String get registrar;

  /// No description provided for @olvideContrasena.
  ///
  /// In es, this message translates to:
  /// **'Olvidé mi contraseña'**
  String get olvideContrasena;

  /// No description provided for @olvideContrasenaDesc.
  ///
  /// In es, this message translates to:
  /// **'Ingresa el correo electrónico asociado a tu cuenta'**
  String get olvideContrasenaDesc;

  /// No description provided for @enviarCodigo.
  ///
  /// In es, this message translates to:
  /// **'Enviar Código'**
  String get enviarCodigo;

  /// No description provided for @codigoVerificacion.
  ///
  /// In es, this message translates to:
  /// **'Código de verificación'**
  String get codigoVerificacion;

  /// No description provided for @codigoVerificacionDesc.
  ///
  /// In es, this message translates to:
  /// **'Ingresa el código que recibiste para verificar tu identidad'**
  String get codigoVerificacionDesc;

  /// No description provided for @validar.
  ///
  /// In es, this message translates to:
  /// **'Validar'**
  String get validar;

  /// No description provided for @noRecibisteCodigo.
  ///
  /// In es, this message translates to:
  /// **'¿No recibiste el código?'**
  String get noRecibisteCodigo;

  /// No description provided for @reenviar.
  ///
  /// In es, this message translates to:
  /// **'Reenviar'**
  String get reenviar;

  /// No description provided for @codigoReenviado.
  ///
  /// In es, this message translates to:
  /// **'Te enviamos un nuevo código.'**
  String get codigoReenviado;

  /// No description provided for @cambiarContrasena.
  ///
  /// In es, this message translates to:
  /// **'Cambiar contraseña'**
  String get cambiarContrasena;

  /// No description provided for @cambiarContrasenaDesc.
  ///
  /// In es, this message translates to:
  /// **'Crea una contraseña segura que puedas recordar'**
  String get cambiarContrasenaDesc;

  /// No description provided for @nuevaContrasena.
  ///
  /// In es, this message translates to:
  /// **'Nueva contraseña'**
  String get nuevaContrasena;

  /// No description provided for @confirmarNuevaContrasena.
  ///
  /// In es, this message translates to:
  /// **'Confirmar nueva contraseña'**
  String get confirmarNuevaContrasena;

  /// No description provided for @continuar.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get continuar;

  /// No description provided for @contrasenaActualizada.
  ///
  /// In es, this message translates to:
  /// **'Tu contraseña fue actualizada. Inicia sesión.'**
  String get contrasenaActualizada;

  /// No description provided for @completarPerfilTitulo.
  ///
  /// In es, this message translates to:
  /// **'Completa tu perfil'**
  String get completarPerfilTitulo;

  /// No description provided for @completarPerfilDesc.
  ///
  /// In es, this message translates to:
  /// **'Necesitamos unos datos para terminar de crear tu cuenta.'**
  String get completarPerfilDesc;

  /// No description provided for @nombre.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get nombre;

  /// No description provided for @primerApellido.
  ///
  /// In es, this message translates to:
  /// **'Primer apellido'**
  String get primerApellido;

  /// No description provided for @segundoApellido.
  ///
  /// In es, this message translates to:
  /// **'Segundo apellido (opcional)'**
  String get segundoApellido;

  /// No description provided for @genero.
  ///
  /// In es, this message translates to:
  /// **'Género'**
  String get genero;

  /// No description provided for @hombre.
  ///
  /// In es, this message translates to:
  /// **'Hombre'**
  String get hombre;

  /// No description provided for @mujer.
  ///
  /// In es, this message translates to:
  /// **'Mujer'**
  String get mujer;

  /// No description provided for @fechaNacimiento.
  ///
  /// In es, this message translates to:
  /// **'Fecha de nacimiento'**
  String get fechaNacimiento;

  /// No description provided for @accesoDenegadoTitulo.
  ///
  /// In es, this message translates to:
  /// **'Acceso restringido'**
  String get accesoDenegadoTitulo;

  /// No description provided for @accesoDenegadoDesc.
  ///
  /// In es, this message translates to:
  /// **'La versión web es solo para administradores. Usa la aplicación móvil.'**
  String get accesoDenegadoDesc;

  /// No description provided for @cerrarSesion.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get cerrarSesion;

  /// No description provided for @legalTerminosTitulo.
  ///
  /// In es, this message translates to:
  /// **'Términos y condiciones'**
  String get legalTerminosTitulo;

  /// No description provided for @legalPoliticasTitulo.
  ///
  /// In es, this message translates to:
  /// **'Políticas de privacidad'**
  String get legalPoliticasTitulo;

  /// No description provided for @legalTerminosEncabezado.
  ///
  /// In es, this message translates to:
  /// **'Nuestros términos'**
  String get legalTerminosEncabezado;

  /// No description provided for @legalPoliticasEncabezado.
  ///
  /// In es, this message translates to:
  /// **'Nuestras políticas'**
  String get legalPoliticasEncabezado;

  /// No description provided for @legalUltimaActualizacion.
  ///
  /// In es, this message translates to:
  /// **'Última actualización: {fecha}'**
  String legalUltimaActualizacion(DateTime fecha);

  /// No description provided for @errLegal.
  ///
  /// In es, this message translates to:
  /// **'No pudimos cargar el documento.'**
  String get errLegal;

  /// No description provided for @reintentar.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get reintentar;

  /// No description provided for @errCampoRequerido.
  ///
  /// In es, this message translates to:
  /// **'Este campo es obligatorio'**
  String get errCampoRequerido;

  /// No description provided for @errCorreoInvalido.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un correo válido'**
  String get errCorreoInvalido;

  /// No description provided for @errContrasenaDebil.
  ///
  /// In es, this message translates to:
  /// **'Mínimo 8 caracteres, con letras y números'**
  String get errContrasenaDebil;

  /// No description provided for @errContrasenasNoCoinciden.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get errContrasenasNoCoinciden;

  /// No description provided for @errCodigoIncompleto.
  ///
  /// In es, this message translates to:
  /// **'Ingresa los 6 dígitos'**
  String get errCodigoIncompleto;

  /// No description provided for @errGenero.
  ///
  /// In es, this message translates to:
  /// **'Selecciona tu género'**
  String get errGenero;

  /// No description provided for @errFechaNacimiento.
  ///
  /// In es, this message translates to:
  /// **'Selecciona tu fecha de nacimiento'**
  String get errFechaNacimiento;

  /// No description provided for @errCredenciales.
  ///
  /// In es, this message translates to:
  /// **'Correo o contraseña incorrectos'**
  String get errCredenciales;

  /// No description provided for @errCodigoInvalido.
  ///
  /// In es, this message translates to:
  /// **'El código es incorrecto'**
  String get errCodigoInvalido;

  /// No description provided for @errCodigoExpirado.
  ///
  /// In es, this message translates to:
  /// **'El código expiró. Solicita uno nuevo'**
  String get errCodigoExpirado;

  /// No description provided for @errDemasiadosIntentos.
  ///
  /// In es, this message translates to:
  /// **'Demasiados intentos. Intenta más tarde'**
  String get errDemasiadosIntentos;

  /// No description provided for @errSinConexion.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión. Revisa tu internet'**
  String get errSinConexion;

  /// No description provided for @errNoDisponible.
  ///
  /// In es, this message translates to:
  /// **'No disponible por ahora'**
  String get errNoDisponible;

  /// No description provided for @errRegistro.
  ///
  /// In es, this message translates to:
  /// **'No pudimos completar el registro'**
  String get errRegistro;

  /// No description provided for @errDesconocido.
  ///
  /// In es, this message translates to:
  /// **'Ocurrió un error. Intenta de nuevo'**
  String get errDesconocido;

  /// No description provided for @holaNombre.
  ///
  /// In es, this message translates to:
  /// **'¡Hola, {nombre}!'**
  String holaNombre(String nombre);

  /// No description provided for @esUnGustoTenerteAqui.
  ///
  /// In es, this message translates to:
  /// **'Es un gusto tenerte aquí'**
  String get esUnGustoTenerteAqui;

  /// No description provided for @unaIglesiaUnaFamilia.
  ///
  /// In es, this message translates to:
  /// **'Una iglesia, una sola familia'**
  String get unaIglesiaUnaFamilia;

  /// No description provided for @heroDescripcion.
  ///
  /// In es, this message translates to:
  /// **'Conectando personas, compartiendo el evangelio y sirviendo a nuestra comunidad.'**
  String get heroDescripcion;

  /// No description provided for @accesoBiblia.
  ///
  /// In es, this message translates to:
  /// **'Biblia'**
  String get accesoBiblia;

  /// No description provided for @accesoBoletin.
  ///
  /// In es, this message translates to:
  /// **'Boletín'**
  String get accesoBoletin;

  /// No description provided for @accesoOfrendar.
  ///
  /// In es, this message translates to:
  /// **'Ofrendar'**
  String get accesoOfrendar;

  /// No description provided for @accesoOraciones.
  ///
  /// In es, this message translates to:
  /// **'Oraciones'**
  String get accesoOraciones;

  /// No description provided for @proximoEvento.
  ///
  /// In es, this message translates to:
  /// **'Próximo evento'**
  String get proximoEvento;

  /// No description provided for @noticias.
  ///
  /// In es, this message translates to:
  /// **'Noticias'**
  String get noticias;

  /// No description provided for @buscar.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get buscar;

  /// No description provided for @proximos.
  ///
  /// In es, this message translates to:
  /// **'Próximos'**
  String get proximos;

  /// No description provided for @pasados.
  ///
  /// In es, this message translates to:
  /// **'Pasados'**
  String get pasados;

  /// No description provided for @serie.
  ///
  /// In es, this message translates to:
  /// **'Serie'**
  String get serie;

  /// No description provided for @minutos.
  ///
  /// In es, this message translates to:
  /// **'{n} min'**
  String minutos(int n);

  /// No description provided for @categoriaDiscipulado.
  ///
  /// In es, this message translates to:
  /// **'Discipulado'**
  String get categoriaDiscipulado;

  /// No description provided for @categoriaNuevasGeneraciones.
  ///
  /// In es, this message translates to:
  /// **'Nuevas generaciones'**
  String get categoriaNuevasGeneraciones;

  /// No description provided for @sobreEsteMinisterio.
  ///
  /// In es, this message translates to:
  /// **'Sobre este ministerio'**
  String get sobreEsteMinisterio;

  /// No description provided for @ministerioEdades.
  ///
  /// In es, this message translates to:
  /// **'Edades'**
  String get ministerioEdades;

  /// No description provided for @ministerioReuniones.
  ///
  /// In es, this message translates to:
  /// **'Reuniones'**
  String get ministerioReuniones;

  /// No description provided for @ministerioLugar.
  ///
  /// In es, this message translates to:
  /// **'Lugar'**
  String get ministerioLugar;

  /// No description provided for @unirme.
  ///
  /// In es, this message translates to:
  /// **'Unirme'**
  String get unirme;

  /// No description provided for @proximosEventos.
  ///
  /// In es, this message translates to:
  /// **'Próximos eventos'**
  String get proximosEventos;

  /// No description provided for @loMasReciente.
  ///
  /// In es, this message translates to:
  /// **'Lo más reciente'**
  String get loMasReciente;

  /// No description provided for @peticionesTitulo.
  ///
  /// In es, this message translates to:
  /// **'Peticiones de oración'**
  String get peticionesTitulo;

  /// No description provided for @peticionesDescripcion.
  ///
  /// In es, this message translates to:
  /// **'Únete en oración por las necesidades de nuestra comunidad. Dios escucha cada petición.'**
  String get peticionesDescripcion;

  /// No description provided for @agregarPeticion.
  ///
  /// In es, this message translates to:
  /// **'+ Agregar petición'**
  String get agregarPeticion;

  /// No description provided for @misPeticionesTitulo.
  ///
  /// In es, this message translates to:
  /// **'Mis peticiones de oración'**
  String get misPeticionesTitulo;

  /// No description provided for @misPeticionesDescripcion.
  ///
  /// In es, this message translates to:
  /// **'Tus peticiones también importan. Dios te escucha.'**
  String get misPeticionesDescripcion;

  /// No description provided for @activas.
  ///
  /// In es, this message translates to:
  /// **'Activas'**
  String get activas;

  /// No description provided for @inactivas.
  ///
  /// In es, this message translates to:
  /// **'Inactivas'**
  String get inactivas;

  /// No description provided for @solicitudOracion.
  ///
  /// In es, this message translates to:
  /// **'Solicitud de oración'**
  String get solicitudOracion;

  /// No description provided for @solicitudOracionDescripcion.
  ///
  /// In es, this message translates to:
  /// **'¿Tienes una petición especial? Nos encantaría orar por ti'**
  String get solicitudOracionDescripcion;

  /// No description provided for @publicarAnonima.
  ///
  /// In es, this message translates to:
  /// **'Publicar de forma anónima'**
  String get publicarAnonima;

  /// No description provided for @tuPeticion.
  ///
  /// In es, this message translates to:
  /// **'Tu petición de oración'**
  String get tuPeticion;

  /// No description provided for @anonimo.
  ///
  /// In es, this message translates to:
  /// **'Anónimo'**
  String get anonimo;

  /// No description provided for @enviar.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get enviar;

  /// No description provided for @peticionEnviada.
  ///
  /// In es, this message translates to:
  /// **'Tu petición fue enviada.'**
  String get peticionEnviada;

  /// No description provided for @notificacionesTitulo.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get notificacionesTitulo;

  /// No description provided for @filtroTodas.
  ///
  /// In es, this message translates to:
  /// **'Todas'**
  String get filtroTodas;

  /// No description provided for @filtroEventos.
  ///
  /// In es, this message translates to:
  /// **'Eventos'**
  String get filtroEventos;

  /// No description provided for @filtroAnuncios.
  ///
  /// In es, this message translates to:
  /// **'Anuncios'**
  String get filtroAnuncios;

  /// No description provided for @filtroMinisterios.
  ///
  /// In es, this message translates to:
  /// **'Ministerios'**
  String get filtroMinisterios;

  /// No description provided for @ofrendasTitulo.
  ///
  /// In es, this message translates to:
  /// **'Ofrendas'**
  String get ofrendasTitulo;

  /// No description provided for @ofrendasApoyar.
  ///
  /// In es, this message translates to:
  /// **'¿Qué te gustaría apoyar?'**
  String get ofrendasApoyar;

  /// No description provided for @ofrendasApoyarDescripcion.
  ///
  /// In es, this message translates to:
  /// **'Selecciona una iniciativa de la iglesia.'**
  String get ofrendasApoyarDescripcion;

  /// No description provided for @ofrendaBuenSamaritano.
  ///
  /// In es, this message translates to:
  /// **'Buen Samaritano'**
  String get ofrendaBuenSamaritano;

  /// No description provided for @ofrendaBuenSamaritanoDesc.
  ///
  /// In es, this message translates to:
  /// **'Apoyando a las familias que más lo necesitan.'**
  String get ofrendaBuenSamaritanoDesc;

  /// No description provided for @ofrendaCasaNueva.
  ///
  /// In es, this message translates to:
  /// **'Casa Nueva'**
  String get ofrendaCasaNueva;

  /// No description provided for @ofrendaCasaNuevaDesc.
  ///
  /// In es, this message translates to:
  /// **'Ayuda a construir nuestro nuevo templo.'**
  String get ofrendaCasaNuevaDesc;

  /// No description provided for @ofrendaMisiones.
  ///
  /// In es, this message translates to:
  /// **'Misiones'**
  String get ofrendaMisiones;

  /// No description provided for @ofrendaMisionesDesc.
  ///
  /// In es, this message translates to:
  /// **'Haz que el mensaje de redención llegue más allá de las fronteras.'**
  String get ofrendaMisionesDesc;

  /// No description provided for @ofrendaOtro.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get ofrendaOtro;

  /// No description provided for @ofrendaOtroDesc.
  ///
  /// In es, this message translates to:
  /// **'Colaboras con el mantenimiento del templo y/o cualquiera de las otras causas.'**
  String get ofrendaOtroDesc;

  /// No description provided for @banco.
  ///
  /// In es, this message translates to:
  /// **'Banco'**
  String get banco;

  /// No description provided for @monto.
  ///
  /// In es, this message translates to:
  /// **'Monto'**
  String get monto;

  /// No description provided for @otro.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get otro;

  /// No description provided for @donarAhora.
  ///
  /// In es, this message translates to:
  /// **'Donar ahora'**
  String get donarAhora;

  /// No description provided for @otrasFormasDeOfrendar.
  ///
  /// In es, this message translates to:
  /// **'Otras formas de ofrendar'**
  String get otrasFormasDeOfrendar;

  /// No description provided for @transferencia.
  ///
  /// In es, this message translates to:
  /// **'Transferencia'**
  String get transferencia;

  /// No description provided for @cuentaNumero.
  ///
  /// In es, this message translates to:
  /// **'Cuenta'**
  String get cuentaNumero;

  /// No description provided for @cuentaCliente.
  ///
  /// In es, this message translates to:
  /// **'Cuenta cliente'**
  String get cuentaCliente;

  /// No description provided for @cuentaIban.
  ///
  /// In es, this message translates to:
  /// **'Cuenta IBAN'**
  String get cuentaIban;

  /// No description provided for @concepto.
  ///
  /// In es, this message translates to:
  /// **'Concepto'**
  String get concepto;

  /// No description provided for @beneficiario.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get beneficiario;

  /// No description provided for @colones.
  ///
  /// In es, this message translates to:
  /// **'Colones'**
  String get colones;

  /// No description provided for @dolares.
  ///
  /// In es, this message translates to:
  /// **'Dólares'**
  String get dolares;

  /// No description provided for @cerrar.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get cerrar;

  /// No description provided for @libros.
  ///
  /// In es, this message translates to:
  /// **'Libros'**
  String get libros;

  /// No description provided for @sinContenido.
  ///
  /// In es, this message translates to:
  /// **'Por ahora no hay contenido.'**
  String get sinContenido;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
