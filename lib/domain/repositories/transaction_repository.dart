import '../entities/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactions();
  Future<void> addTransaction(Transaction transaction);
  Future<void> editTransaction(int index, Transaction transaction);
  Future<void> deleteTransaction(int index);
}
