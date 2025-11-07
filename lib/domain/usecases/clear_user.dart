import '../repositories/user_repository.dart';

class ClearUser {
  final UserRepository repository;
  ClearUser(this.repository);

  Future<void> call() async {
    await repository.clearUser();
  }
}
