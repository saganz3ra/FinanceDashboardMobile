import 'package:flutter/material.dart';
import '../atoms/app_text_field.dart';

class LoginFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? passwordValidator;
  const LoginFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    this.emailValidator,
    this.passwordValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: emailController,
          label: "Email",
          semanticsLabel: 'Campo de email',
          keyboardType: TextInputType.emailAddress,
          validator: emailValidator,
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: passwordController,
          label: "Senha",
          obscureText: true,
          semanticsLabel: 'Campo de senha',
          validator: passwordValidator,
        ),
      ],
    );
  }
}
