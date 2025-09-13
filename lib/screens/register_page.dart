import '../shared/widgets/organisms/register_form.dart';
// import '../shared/widgets/molecules/register_fields.dart';
// import '../shared/widgets/molecules/register_title.dart';
import 'package:flutter/material.dart';

// import '../shared/widgets/atoms/app_button.dart';
// import '../shared/widgets/atoms/app_text_field.dart';
import 'package:flutter/services.dart';
import '../shared/constants/colors.dart';
import '../services/local_user_storage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _confirmPasswordController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirme a senha';
    if (value != _passwordController.text) return 'As senhas não coincidem';
    return null;
  }

  final _birthDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  DateTime? _birthDate;

  // Validação de CPF simples (formato e dígitos)
  String? _validateCPF(String? value) {
    if (value == null || value.isEmpty) return 'CPF obrigatório';
    final cpf = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cpf.length != 11) return 'CPF deve ter 11 dígitos';
    bool allEqual = true;
    for (int i = 1; i < cpf.length; i++) {
      if (cpf[i] != cpf[0]) {
        allEqual = false;
        break;
      }
    }
    if (allEqual) return 'CPF inválido';
    int calcDigit(String str, int len) {
      int sum = 0;
      for (int i = 0; i < len; i++) {
        sum += int.parse(str[i]) * (len + 1 - i);
      }
      int mod = sum % 11;
      return mod < 2 ? 0 : 11 - mod;
    }

    final d1 = calcDigit(cpf, 9);
    final d2 = calcDigit(cpf, 10);
    if (d1 != int.parse(cpf[9]) || d2 != int.parse(cpf[10])) {
      return 'CPF inválido';
    }
    return null;
  }

  // Validação de email simples
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email obrigatório';
    if (!value.contains('@') || !RegExp(r'^.+@.+\..+$').hasMatch(value)) {
      return 'Email inválido';
    }
    return null;
  }

  // Validação de senha forte
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Senha obrigatória';
    if (value.length < 6) return 'Senha deve ter pelo menos 6 caracteres';
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Senha deve ter letra maiúscula';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Senha deve ter letra minúscula';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Senha deve ter número';
    if (!RegExp(r'[!@#\$%¨&*()_+=\-{}\[\]:;,.?/~^]').hasMatch(value)) {
      return 'Senha deve ter caractere especial';
    }
    return null;
  }

  // Validação de telefone com DDD (formato brasileiro)
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Telefone obrigatório';
    final phone = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (phone.length < 10 || phone.length > 11) {
      return 'Telefone deve ter DDD e número válido';
    }
    if (!RegExp(r'^[1-9]{2}[2-9][0-9]{7,8}$').hasMatch(phone)) {
      return 'Telefone inválido';
    }
    return null;
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: RegisterForm(
                formKey: _formKey,
                nameController: _nameController,
                cpfController: _cpfController,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                phoneController: _phoneController,
                birthDateController: _birthDateController,
                nameValidator: (value) =>
                    value == null || value.isEmpty ? 'Nome obrigatório' : null,
                cpfValidator: _validateCPF,
                emailValidator: _validateEmail,
                passwordValidator: _validatePassword,
                confirmPasswordValidator: _validateConfirmPassword,
                phoneValidator: _validatePhone,
                birthDateValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Data de nascimento obrigatória';
                  }
                  final regex = RegExp(
                    r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$',
                  );
                  if (!regex.hasMatch(value)) {
                    return 'Formato inválido (dd/mm/aaaa)';
                  }
                  // Atualiza _birthDate se o valor for válido
                  final parts = value.split('/');
                  final day = int.tryParse(parts[0]);
                  final month = int.tryParse(parts[1]);
                  final year = int.tryParse(parts[2]);
                  if (day != null && month != null && year != null) {
                    final date = DateTime(year, month, day);
                    if (_birthDate == null ||
                        _birthDate!.day != day ||
                        _birthDate!.month != month ||
                        _birthDate!.year != year) {
                      setState(() {
                        _birthDate = date;
                      });
                    }
                  }
                  return null;
                },
                birthDateInputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    var text = newValue.text;
                    if (text.length > 2 && text[2] != '/') {
                      text = '${text.substring(0, 2)}/${text.substring(2)}';
                    }
                    if (text.length > 5 && text[5] != '/') {
                      text = '${text.substring(0, 5)}/${text.substring(5)}';
                    }
                    if (text.length > 10) {
                      text = text.substring(0, 10);
                    }
                    return TextEditingValue(
                      text: text,
                      selection: TextSelection.collapsed(offset: text.length),
                    );
                  }),
                ],
                onSelectBirthDate: () async {
                  await _selectBirthDate(context);
                  if (_birthDate != null) {
                    _birthDateController.text =
                        '${_birthDate!.day.toString().padLeft(2, '0')}/${_birthDate!.month.toString().padLeft(2, '0')}/${_birthDate!.year}';
                  }
                },
                onRegister: () async {
                  if (_formKey.currentState!.validate() && _birthDate != null) {
                    await LocalUserStorage.saveUser({
                      'name': _nameController.text,
                      'cpf': _cpfController.text,
                      'email': _emailController.text,
                      'password': _passwordController.text,
                      'phone': _phoneController.text,
                      'birthDate': _birthDateController.text,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Registro realizado com sucesso!'),
                      ),
                    );
                    Future.delayed(const Duration(milliseconds: 500), () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    });
                  } else if (_birthDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Selecione a data de nascimento.'),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
