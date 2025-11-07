import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/local/transaction_local_data_source.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;
  TransactionRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Transaction>> getTransactions() async {
    final models = await localDataSource.getTransactions();
    return models;
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    final model = TransactionModel(
      value: transaction.value,
      description: transaction.description,
      date: transaction.date,
      isIncome: transaction.isIncome,
    );
    await localDataSource.addTransaction(model);
  }

  @override
  Future<void> editTransaction(int index, Transaction transaction) async {
    final model = TransactionModel(
      value: transaction.value,
      description: transaction.description,
      date: transaction.date,
      isIncome: transaction.isIncome,
    );
    await localDataSource.editTransaction(index, model);
  }

  @override
  Future<void> deleteTransaction(int index) async {
    await localDataSource.deleteTransaction(index);
  }
}
