import '../../models/transaction_model.dart';

abstract class TransactionLocalDataSource {
  Future<List<TransactionModel>> getTransactions();
  Future<void> addTransaction(TransactionModel transaction);
  Future<void> editTransaction(int index, TransactionModel transaction);
  Future<void> deleteTransaction(int index);
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final List<TransactionModel> _transactions = [];

  @override
  Future<List<TransactionModel>> getTransactions() async {
    return _transactions;
  }

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    _transactions.add(transaction);
  }

  @override
  Future<void> editTransaction(int index, TransactionModel transaction) async {
    if (index >= 0 && index < _transactions.length) {
      _transactions[index] = transaction;
    }
  }

  @override
  Future<void> deleteTransaction(int index) async {
    if (index >= 0 && index < _transactions.length) {
      _transactions.removeAt(index);
    }
  }
}
