import 'package:flutter/material.dart';
import '../molecules/login_title.dart';
import '../molecules/login_fields.dart';
import '../atoms/app_button.dart';
import '../../constants/colors.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? passwordValidator;
  final VoidCallback onLogin;
  final VoidCallback onRegister;
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    this.emailValidator,
    this.passwordValidator,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const LoginTitle(text: 'Faça seu login'),
          const SizedBox(height: 20),
          LoginFields(
            emailController: emailController,
            passwordController: passwordController,
            emailValidator: emailValidator,
            passwordValidator: passwordValidator,
          ),
          const SizedBox(height: 20),
          AppButton(
            label: "Entrar",
            icon: Icons.login,
            color: AppColors.primary,
            semanticsLabel: 'Botão para entrar',
            onPressed: onLogin,
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: onRegister,
            child: const Text('Não tem conta? Cadastre-se'),
          ),
        ],
      ),
    );
  }
}
