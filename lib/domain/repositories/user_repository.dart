import '../entities/user.dart';

abstract class UserRepository {
  /// Salva dados do usuário com senha (para registro/autenticação)
  Future<void> saveUser(User user, String password);
  Future<User?> getUser();
  Future<void> clearUser();
}
