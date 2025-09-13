import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class RegisterTitle extends StatelessWidget {
  final String text;
  const RegisterTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
