import '../repositories/user_repository.dart';
import '../entities/user.dart';

class GetUser {
  final UserRepository repository;
  GetUser(this.repository);

  Future<User?> call() async {
    return await repository.getUser();
  }
}
