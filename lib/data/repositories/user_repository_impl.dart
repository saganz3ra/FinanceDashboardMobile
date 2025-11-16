import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local/user_local_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  UserRepositoryImpl({required this.localDataSource});

  @override
  Future<void> saveUser(User user, String password) async {
    final model = UserModel.fromEntity(user, password);
    await localDataSource.saveUser(model);
  }

  @override
  Future<User?> getUser() async {
    final model = await localDataSource.getUser();
    if (model == null) return null;
    return model.toEntity();
  }

  @override
  Future<void> clearUser() async {
    await localDataSource.clearUser();
  }
}
