import '../../core/either.dart';
import '../../core/errors/failure.dart';
import '../../core/exceptions.dart';
import '../../domain/repositories/currency_repository.dart';
import '../datasources/remote/currency_remote_data_source.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;
  CurrencyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, double>> getDollarValue() async {
    try {
      final model = await remoteDataSource.fetchDollarValue();
      return Right(model.value);
    } on ServerException {
      return const Left(ServerFailure());
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
