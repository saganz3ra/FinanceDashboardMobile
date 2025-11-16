import '../../core/either.dart';
import '../../core/errors/failure.dart';

abstract class CurrencyRepository {
  Future<Either<Failure, double>> getDollarValue();
}
