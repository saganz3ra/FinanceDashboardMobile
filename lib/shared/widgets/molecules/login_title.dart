import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class LoginTitle extends StatelessWidget {
  final String text;
  const LoginTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      label: text,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
