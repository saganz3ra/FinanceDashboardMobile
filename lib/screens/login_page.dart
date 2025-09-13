import '../shared/widgets/organisms/login_form.dart';
import 'package:flutter/material.dart';
import '../shared/constants/colors.dart';
import '../services/local_user_storage.dart';

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
