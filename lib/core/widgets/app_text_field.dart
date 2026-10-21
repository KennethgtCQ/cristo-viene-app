import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_tokens.dart';
import 'app_icon.dart';

/// Campo de texto con placeholder, icono opcional y radio 15.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hint,
    this.controller,
    this.icono,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.suffix,
  });

  final String hint;
  final TextEditingController? controller;
  final String? icono;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      style: t.campo,
      cursorColor: t.acento,
      decoration: InputDecoration(
        hintText: hint,
        constraints: const BoxConstraints(minHeight: AppSizes.alturaControl),
        contentPadding: EdgeInsets.fromLTRB(icono == null ? 26 : 0, 15, 15, 15),
        prefixIcon: icono == null
            ? null
            : Padding(
                padding: const EdgeInsetsDirectional.only(start: 15, end: 8),
                child: AppIcon(icono!, size: 18, color: t.secundario),
              ),
        prefixIconConstraints: const BoxConstraints(),
        suffixIcon: suffix,
      ),
    );
  }
}
