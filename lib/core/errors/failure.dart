abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => 'Failure: $message';
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Erro no servidor']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Erro no cache local']) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Erro de conexão']) : super(message);
}
