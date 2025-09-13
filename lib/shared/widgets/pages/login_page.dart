import 'package:flutter/material.dart';
import '../atoms/app_button.dart';
import '../atoms/app_text_field.dart';
import '../../constants/colors.dart';
import '../../../services/local_user_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    final user = await LocalUserStorage.getUser();
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhum usuário registrado.')),
      );
      return;
    }
    if (_emailController.text == user['email'] &&
        _passwordController.text == user['password']) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login realizado!')));
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou senha incorretos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    AppTextField(
                      controller: _emailController,
                      label: "Email",
                      semanticsLabel: 'Campo de email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Email obrigatório';
                        if (!value.contains('@') ||
                            !RegExp(r'^.+@.+\..+$').hasMatch(value))
                          return 'Email inválido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _passwordController,
                      label: "Senha",
                      obscureText: true,
                      semanticsLabel: 'Campo de senha',
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Senha obrigatória';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                      label: "Entrar",
                      icon: Icons.login,
                      color: AppColors.primary,
                      semanticsLabel: 'Botão para entrar',
                      onPressed: _login,
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                      child: const Text('Não tem conta? Cadastre-se'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
