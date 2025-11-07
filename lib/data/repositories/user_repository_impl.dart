import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local/user_local_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  UserRepositoryImpl({required this.localDataSource});

  @override
  Future<void> saveUser(User user) async {
    final model = UserModel(
      name: user.name,
      cpf: user.cpf,
      email: user.email,
      password: user.password,
      phone: user.phone,
      birthDate: user.birthDate,
    );
    await localDataSource.saveUser(model);
  }

  @override
  Future<User?> getUser() async {
    final model = await localDataSource.getUser();
    if (model == null) return null;
    return User(
      name: model.name,
      cpf: model.cpf,
      email: model.email,
      password: model.password,
      phone: model.phone,
      birthDate: model.birthDate,
    );
  }

  @override
  Future<void> clearUser() async {
    await localDataSource.clearUser();
  }
}
