import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/validadores.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_opcion_radio.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/models/datos_perfil.dart';
import '../../../data/models/usuario.dart';
import '../../../l10n/app_localizations.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/texto_error_auth.dart';

/// Se muestra justo después de crear la cuenta (o de entrar con Google/Apple)
/// hasta que el perfil esté completo. No hay diseño en Figma: reutiliza los
/// componentes de las pantallas de perfil.
class CompletarPerfilScreen extends StatefulWidget {
  const CompletarPerfilScreen({super.key});

  @override
  State<CompletarPerfilScreen> createState() => _CompletarPerfilScreenState();
}

class _CompletarPerfilScreenState extends State<CompletarPerfilScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _primerApellido = TextEditingController();
  final _segundoApellido = TextEditingController();
  Genero? _genero;
  DateTime? _fecha;
  bool _generoFaltante = false;
  bool _fechaFaltante = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<AuthViewModel>().limpiarError(),
    );
  }

  @override
  void dispose() {
    _nombre.dispose();
    _primerApellido.dispose();
    _segundoApellido.dispose();
    super.dispose();
  }

  Future<void> _elegirFecha() async {
    final ahora = DateTime.now();
    final elegida = await showDatePicker(
      context: context,
      initialDate: _fecha ?? DateTime(ahora.year - 25, 1, 1),
      firstDate: DateTime(1900),
      lastDate: ahora,
    );
    if (elegida != null) {
      setState(() {
        _fecha = elegida;
        _fechaFaltante = false;
      });
    }
  }

  String _formatear(DateTime fecha) {
    final texto = DateFormat('MMMM d y', Localizations.localeOf(context).toString()).format(fecha);
    return texto[0].toUpperCase() + texto.substring(1);
  }

  Future<void> _continuar() async {
    final formOk = _formKey.currentState!.validate();
    setState(() {
      _generoFaltante = _genero == null;
      _fechaFaltante = _fecha == null;
    });
    if (!formOk || _genero == null || _fecha == null) return;

    // Si funciona, el router lleva al inicio.
    await context.read<AuthViewModel>().completarPerfil(
          DatosPerfil(
            nombre: _nombre.text.trim(),
            primerApellido: _primerApellido.text.trim(),
            segundoApellido: _segundoApellido.text.trim(),
            genero: _genero!,
            fechaNacimiento: _fecha!,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = context.tokens;
    final auth = context.watch<AuthViewModel>();

    String? requerido(String? v) => esNombreValido(v ?? '') ? null : l10n.errCampoRequerido;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
              AppSizes.paddingPantalla, 32, AppSizes.paddingPantalla, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.completarPerfilTitulo, style: t.titulo),
                const SizedBox(height: 8),
                Text(l10n.completarPerfilDesc, style: t.subtituloTenue),
                const SizedBox(height: 28),
                AppTextField(
                  hint: l10n.nombre,
                  controller: _nombre,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.givenName],
                  validator: requerido,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  hint: l10n.primerApellido,
                  controller: _primerApellido,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.familyName],
                  validator: requerido,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  hint: l10n.segundoApellido,
                  controller: _segundoApellido,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 24),
                Text(l10n.genero, style: t.descripcion),
                const SizedBox(height: 10),
                AppOpcionRadio(
                  texto: l10n.hombre,
                  seleccionada: _genero == Genero.hombre,
                  onTap: () => setState(() {
                    _genero = Genero.hombre;
                    _generoFaltante = false;
                  }),
                ),
                const SizedBox(height: 12),
                AppOpcionRadio(
                  texto: l10n.mujer,
                  seleccionada: _genero == Genero.mujer,
                  onTap: () => setState(() {
                    _genero = Genero.mujer;
                    _generoFaltante = false;
                  }),
                ),
                if (_generoFaltante)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(l10n.errGenero, style: t.errorTexto),
                  ),
                const SizedBox(height: 24),
                Text(l10n.fechaNacimiento, style: t.descripcion),
                const SizedBox(height: 10),
                Material(
                  color: t.campoFondo,
                  borderRadius: BorderRadius.circular(AppSizes.radio),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: _elegirFecha,
                    child: Container(
                      height: AppSizes.alturaControl,
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _fecha == null ? l10n.fechaNacimiento : _formatear(_fecha!),
                              style: _fecha == null ? t.placeholder : t.campo,
                            ),
                          ),
                          AppIcon(AppIcons.chevronAbajo, size: 20, color: t.secundario),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_fechaFaltante)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(l10n.errFechaNacimiento, style: t.errorTexto),
                  ),
                if (auth.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(textoErrorAuth(l10n, auth.error!), style: t.errorTexto),
                  ),
                const SizedBox(height: 32),
                AppButton(
                  texto: l10n.continuar,
                  cargando: auth.cargando,
                  onPressed: _continuar,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
