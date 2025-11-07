import '../shared/widgets/organisms/login_form.dart';
import 'package:flutter/material.dart';
import '../shared/constants/colors.dart';

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
    // Bypass temporário da autenticação
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login realizado! (Bypass temporário)')),
    );

    // Aguarda um pequeno delay e garante que o widget ainda esteja montado
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/dashboard');
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
              child: LoginForm(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                emailValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email obrigatório';
                  }
                  if (!value.contains('@') ||
                      !RegExp(r'^.+@.+\..+').hasMatch(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
                passwordValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Senha obrigatória';
                  }
                  return null;
                },
                onLogin: _login,
                onRegister: () {
                  Navigator.of(context).pushNamed('/register');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
