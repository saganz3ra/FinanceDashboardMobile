import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final String? semanticsLabel;

  const AppTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: semanticsLabel ?? label,
      child: TextField(
        obscureText: obscureText,
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
