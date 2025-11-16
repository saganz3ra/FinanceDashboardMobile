import '../../core/either.dart';
import '../../core/errors/failure.dart';
import '../repositories/currency_repository.dart';

class GetDollarValue {
  final CurrencyRepository repository;
  GetDollarValue(this.repository);

  Future<Either<Failure, double>> call() async {
    return await repository.getDollarValue();
  }
}
