import '../repositories/user_repository.dart';
import '../entities/user.dart';

class SaveUser {
  final UserRepository repository;
  SaveUser(this.repository);

  Future<void> call(User user) async {
    await repository.saveUser(user);
  }
}
