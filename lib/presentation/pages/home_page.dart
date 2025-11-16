import 'package:flutter/material.dart';
// import '../routes/app_routes.dart';
// import '../shared/widgets/atoms/app_button.dart';
import '../../shared/constants/colors.dart';
import '../../shared/widgets/molecules/home_title.dart';
import '../../shared/widgets/molecules/home_button_group.dart';

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
            const HomeTitle(text: 'Bem-vindo ao Finance Dashboard!'),
            const SizedBox(height: 20),
            const HomeButtonGroup(),
          ],
        ),
      ),
    );
  }
}
