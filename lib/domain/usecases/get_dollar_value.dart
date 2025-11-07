import '../repositories/currency_repository.dart';

class GetDollarValue {
  final CurrencyRepository repository;
  GetDollarValue(this.repository);

  Future<double> call() async {
    return await repository.getDollarValue();
  }
}
