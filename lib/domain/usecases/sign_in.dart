import '../repositories/auth_repository.dart';
import '../entities/auth_user.dart';

class SignIn {
  final AuthRepository repository;
  SignIn(this.repository);

  Future<AuthUser?> call(String email, String password) async {
    return await repository.signIn(email, password);
  }
}
