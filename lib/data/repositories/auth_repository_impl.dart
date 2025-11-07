import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthUser?> signIn(String email, String password) async {
    final model = await remoteDataSource.signIn(email, password);
    return model;
  }

  @override
  Future<AuthUser?> signUp(
    String email,
    String password, {
    String? displayName,
  }) async {
    final model = await remoteDataSource.signUp(
      email,
      password,
      displayName: displayName,
    );
    return model;
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    final model = await remoteDataSource.getCurrentUser();
    return model;
  }
}
