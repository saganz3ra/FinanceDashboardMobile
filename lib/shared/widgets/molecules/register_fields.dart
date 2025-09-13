import 'package:flutter/material.dart';
import '../atoms/app_text_field.dart';
import 'package:flutter/services.dart';

class RegisterFields extends StatelessWidget {
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
  const RegisterFields({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppTextField(
          controller: nameController,
          label: 'Nome',
          semanticsLabel: 'Campo de nome',
          validator: nameValidator,
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: cpfController,
          label: 'CPF',
          semanticsLabel: 'Campo de CPF',
          keyboardType: TextInputType.number,
          validator: cpfValidator,
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: emailController,
          label: 'Email',
          semanticsLabel: 'Campo de email',
          keyboardType: TextInputType.emailAddress,
          validator: emailValidator,
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: passwordController,
          label: 'Senha',
          obscureText: true,
          semanticsLabel: 'Campo de senha',
          validator: passwordValidator,
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: confirmPasswordController,
          label: 'Confirmar Senha',
          obscureText: true,
          semanticsLabel: 'Campo de confirmação de senha',
          validator: confirmPasswordValidator,
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: phoneController,
          label: 'Telefone',
          semanticsLabel: 'Campo de telefone',
          keyboardType: TextInputType.phone,
          validator: phoneValidator,
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: birthDateController,
          label: 'Data de Nascimento (dd/mm/aaaa)',
          keyboardType: TextInputType.datetime,
          semanticsLabel: 'Campo de data de nascimento',
          inputFormatters: birthDateInputFormatters,
          validator: birthDateValidator,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: onSelectBirthDate,
            child: const Text('Selecionar no calendário'),
          ),
        ),
      ],
    );
  }
}
