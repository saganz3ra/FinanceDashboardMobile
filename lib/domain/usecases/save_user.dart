import '../repositories/user_repository.dart';
import '../entities/user.dart';

class SaveUser {
  final UserRepository repository;
  SaveUser(this.repository);

  Future<void> call(User user, String password) async {
    await repository.saveUser(user, password);
  }
}
