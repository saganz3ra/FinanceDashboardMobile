import '../repositories/auth_repository.dart';
import '../entities/auth_user.dart';

class SignUp {
  final AuthRepository repository;
  SignUp(this.repository);

  Future<AuthUser?> call(String email, String password, {String? displayName}) async {
    return await repository.signUp(email, password, displayName: displayName);
  }
}
