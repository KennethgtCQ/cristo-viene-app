import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_tabs.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/models/preferencias_locales.dart';
import '../../perfil/view_models/preferencias_view_model.dart';

/// Pantalla SOLO DEBUG para comparar componentes contra Figma.
/// Abrir con context.go('/dev/componentes'). Textos fijos a propósito.
class GaleriaComponentesScreen extends StatelessWidget {
  const GaleriaComponentesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final vm = context.watch<PreferenciasViewModel>();
    final p = vm.preferencias;

    return Scaffold(
      appBar: AppBar(title: const Text('Galería (debug)')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          _pad(Text('Título 24 Bold', style: t.titulo)),
          _pad(Text('Subtítulo 16 Light', style: t.subtitulo)),
          _pad(Text('Descripción 16 Regular', style: t.descripcion)),
          _pad(Text('Enlace 16 Regular', style: t.enlace)),
          const SizedBox(height: 16),
          const _Etiqueta('Tema'),
          AppTabs(
            etiquetas: const ['Claro', 'Oscuro', 'Sistema'],
            seleccionada: ModoTema.values.indexOf(p.tema),
            onSeleccion: (i) => vm.cambiarTema(ModoTema.values[i]),
          ),
          const SizedBox(height: 16),
          const _Etiqueta('Tamaño de texto'),
          AppTabs(
            etiquetas: const ['Pequeño', 'Normal', 'Grande'],
            seleccionada: TamanoTexto.values.indexOf(p.tamanoTexto),
            onSeleccion: (i) => vm.cambiarTamanoTexto(TamanoTexto.values[i]),
          ),
          const SizedBox(height: 16),
          const _Etiqueta('Acento'),
          _pad(Wrap(spacing: 14, children: [
            for (final c in AppColors.acentos)
              GestureDetector(
                onTap: () => vm.cambiarAcento(c.toARGB32()),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: c,
                    shape: BoxShape.circle,
                    border: c == t.acento
                        ? Border.all(color: t.principal, width: 2)
                        : null,
                  ),
                ),
              ),
          ])),
          const SizedBox(height: 24),
          _pad(AppButton(texto: 'Acción principal', onPressed: () {})),
          const SizedBox(height: 12),
          _pad(AppButton(
              texto: 'Acción secundaria',
              tipo: AppButtonTipo.secundario,
              onPressed: () {})),
          const SizedBox(height: 12),
          _pad(AppButton(
              texto: 'Cerrar', tipo: AppButtonTipo.cerrar, onPressed: () {})),
          const SizedBox(height: 24),
          _pad(const AppTextField(hint: 'Correo electrónico', icono: AppIcons.correo)),
          const SizedBox(height: 12),
          _pad(const AppTextField(hint: 'Contraseña', icono: AppIcons.candado, obscureText: true)),
          const SizedBox(height: 24),
          _pad(AppCard(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              Container(
                width: 77,
                height: 81,
                decoration: BoxDecoration(
                  color: t.campoFondo,
                  borderRadius: BorderRadius.circular(AppSizes.radio),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Domingo', style: t.diaProximo),
                  Text('13', style: t.fechaProximo),
                  Text('SEPT', style: t.diaProximo),
                ]),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Celebración Anexión Nicoya - Magma', style: t.eventoTitulo),
                  const SizedBox(height: 4),
                  Text('10:15 am - 12:00 md', style: t.hora),
                  const SizedBox(height: 4),
                  Text('Templo', style: t.lugar),
                ]),
              ),
            ]),
          )),
        ],
      ),
    );
  }

  static Widget _pad(Widget child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingPantalla),
        child: child,
      );
}

class _Etiqueta extends StatelessWidget {
  const _Etiqueta(this.texto);
  final String texto;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(AppSizes.paddingPantalla, 0, 0, 8),
        child: Text(texto, style: context.tokens.cardDetalle),
      );
}
