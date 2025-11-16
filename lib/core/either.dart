/// Representa um resultado que pode ser sucesso (Right) ou falha (Left).
/// Usado para tratamento funcional de erros.
abstract class Either<L, R> {
  const Either();

  /// Cria um Either com valor de erro (Left)
  factory Either.left(L value) = Left<L, R>;

  /// Cria um Either com valor de sucesso (Right)
  factory Either.right(R value) = Right<L, R>;

  /// Executa uma função dependendo se é Left ou Right
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight);

  /// Verifica se é um Left
  bool isLeft();

  /// Verifica se é um Right
  bool isRight();
}

class Left<L, R> extends Either<L, R> {
  final L value;

  const Left(this.value);

  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    return onLeft(value);
  }

  @override
  bool isLeft() => true;

  @override
  bool isRight() => false;
}

class Right<L, R> extends Either<L, R> {
  final R value;

  const Right(this.value);

  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    return onRight(value);
  }

  @override
  bool isLeft() => false;

  @override
  bool isRight() => true;
}
