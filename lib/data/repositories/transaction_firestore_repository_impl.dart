import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/remote/transaction_firestore_data_source.dart';
import '../models/transaction_model.dart';

class TransactionFirestoreRepositoryImpl implements TransactionRepository {
  final TransactionFirestoreDataSource remoteDataSource;
  final String userId;
  TransactionFirestoreRepositoryImpl({required this.remoteDataSource, required this.userId});

  @override
  Future<List<Transaction>> getTransactions() async {
    final models = await remoteDataSource.getTransactions(userId);
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
    await remoteDataSource.addTransaction(userId, model);
  }

  @override
  Future<void> editTransaction(int index, Transaction transaction) async {
    final models = await remoteDataSource.getTransactions(userId);
    if (index < 0 || index >= models.length) return;
    final model = TransactionModel(
      value: transaction.value,
      description: transaction.description,
      date: transaction.date,
      isIncome: transaction.isIncome,
      id: models[index].id,
    );
    if (model.id != null) {
      await remoteDataSource.editTransaction(userId, model.id!, model);
    }
  }

  @override
  Future<void> deleteTransaction(int index) async {
    final models = await remoteDataSource.getTransactions(userId);
    if (index < 0 || index >= models.length) return;
    final id = models[index].id;
    if (id != null) {
      await remoteDataSource.deleteTransaction(userId, id);
    }
  }
}
