import 'package:flutter/material.dart';
import '../shared/widgets/atoms/app_button.dart';
import '../shared/widgets/atoms/app_text_field.dart';
import '../shared/constants/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              header: true,
              label: 'Faça seu login',
              child: Text(
                "Faça seu login",
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const AppTextField(
              label: "Email",
              semanticsLabel: 'Campo de email',
            ),
            const SizedBox(height: 16),
            const AppTextField(
              label: "Senha",
              obscureText: true,
              semanticsLabel: 'Campo de senha',
            ),
            const SizedBox(height: 20),
            AppButton(
              label: "Entrar",
              icon: Icons.login,
              color: AppColors.primary,
              semanticsLabel: 'Botão para entrar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login realizado!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
