import 'package:flutter/material.dart';
import '../atoms/app_button.dart';
import '../../../routes/app_routes.dart';
import '../../constants/colors.dart';

class HomeButtonGroup extends StatelessWidget {
  const HomeButtonGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          onPressed: () => Navigator.pushNamed(context, AppRoutes.dashboard),
        ),
      ],
    );
  }
}
