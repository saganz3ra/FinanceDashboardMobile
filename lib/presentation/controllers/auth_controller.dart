import 'package:flutter/foundation.dart';

/// AuthController (ChangeNotifier)
///
/// Controlador simples com bypass temporário para autenticação.
/// Quando o Firebase Auth for reativado, substitua a lógica dos métodos
/// por chamadas aos usecases/repos (signIn, signUp, signOut).
class AuthController extends ChangeNotifier {
  bool isLoading = false;
  String? error;
  String? currentEmail; // representa o usuário logado (bypass)

  /// Validação básica de credenciais
  bool _isValidEmail(String email) =>
      email.contains('@') && email.contains('.');
  bool _isValidPassword(String password) => password.length >= 6;

  Future<void> signIn(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    if (!_isValidEmail(email) || !_isValidPassword(password)) {
      error = 'Credenciais inválidas';
      isLoading = false;
      notifyListeners();
      return;
    }
    currentEmail = email; // bypass: considera login efetuado
    isLoading = false;
    notifyListeners();
  }

  Future<void> register(
    String email,
    String password, {
    String? displayName,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    if (!_isValidEmail(email) || !_isValidPassword(password)) {
      error = 'Dados de cadastro inválidos';
      isLoading = false;
      notifyListeners();
      return;
    }
    // bypass: considera registro efetuado e já loga
    currentEmail = email;
    isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    isLoading = true;
    error = null;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 150));
    currentEmail = null;
    isLoading = false;
    notifyListeners();
  }
}
