import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final String? semanticsLabel;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.semanticsLabel,
    this.controller,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: semanticsLabel ?? label,
      child: validator != null
          ? TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              validator: validator,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: AppColors.background,
              ),
            )
          : TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: AppColors.background,
              ),
            ),
    );
  }
}
