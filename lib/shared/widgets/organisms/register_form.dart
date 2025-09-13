import 'package:flutter/material.dart';
import '../molecules/register_title.dart';
import '../molecules/register_fields.dart';
import '../atoms/app_button.dart';
import '../../constants/colors.dart';
import 'package:flutter/services.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController cpfController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;
  final TextEditingController birthDateController;
  final String? Function(String?)? nameValidator;
  final String? Function(String?)? cpfValidator;
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? passwordValidator;
  final String? Function(String?)? confirmPasswordValidator;
  final String? Function(String?)? phoneValidator;
  final String? Function(String?)? birthDateValidator;
  final List<TextInputFormatter>? birthDateInputFormatters;
  final VoidCallback onSelectBirthDate;
  final VoidCallback onRegister;
  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.cpfController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    required this.birthDateController,
    this.nameValidator,
    this.cpfValidator,
    this.emailValidator,
    this.passwordValidator,
    this.confirmPasswordValidator,
    this.phoneValidator,
    this.birthDateValidator,
    this.birthDateInputFormatters,
    required this.onSelectBirthDate,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const RegisterTitle(text: 'Crie sua conta'),
          const SizedBox(height: 20),
          RegisterFields(
            nameController: nameController,
            cpfController: cpfController,
            emailController: emailController,
            passwordController: passwordController,
            confirmPasswordController: confirmPasswordController,
            phoneController: phoneController,
            birthDateController: birthDateController,
            nameValidator: nameValidator,
            cpfValidator: cpfValidator,
            emailValidator: emailValidator,
            passwordValidator: passwordValidator,
            confirmPasswordValidator: confirmPasswordValidator,
            phoneValidator: phoneValidator,
            birthDateValidator: birthDateValidator,
            birthDateInputFormatters: birthDateInputFormatters,
            onSelectBirthDate: onSelectBirthDate,
          ),
          const SizedBox(height: 24),
          AppButton(
            label: 'Registrar',
            icon: Icons.app_registration,
            color: AppColors.primary,
            semanticsLabel: 'Botão para registrar',
            onPressed: onRegister,
          ),
        ],
      ),
    );
  }
}
