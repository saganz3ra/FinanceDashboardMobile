import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser?> signIn(String email, String password);
  Future<AuthUser?> signUp(String email, String password, {String? displayName});
  Future<void> signOut();
  Future<AuthUser?> getCurrentUser();
}
