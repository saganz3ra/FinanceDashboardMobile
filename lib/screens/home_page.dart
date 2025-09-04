import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../shared/widgets/atoms/app_button.dart';
import '../shared/constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              header: true,
              label: 'Bem-vindo ao Finance Dashboard!',
              child: Text(
                "Bem-vindo ao Finance Dashboard!",
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppButton(
              label: "Ir para Login",
              icon: Icons.login,
              color: AppColors.success,
              semanticsLabel: 'Botão para ir para tela de login',
              onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
            ),
            const SizedBox(height: 12),
            AppButton(
              label: "Ir para Dashboard",
              icon: Icons.dashboard,
              color: AppColors.primary,
              semanticsLabel: 'Botão para ir para tela de dashboard',
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.dashboard),
            ),
          ],
        ),
      ),
    );
  }
}
