import '../../domain/repositories/currency_repository.dart';
import '../datasources/remote/currency_remote_data_source.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;
  CurrencyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<double> getDollarValue() async {
    final model = await remoteDataSource.fetchDollarValue();
    return model.value;
  }
}
