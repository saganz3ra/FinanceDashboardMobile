import '../repositories/transaction_repository.dart';
import '../entities/transaction.dart';

class AddTransaction {
  final TransactionRepository repository;
  AddTransaction(this.repository);

  Future<void> call(Transaction transaction) async {
    await repository.addTransaction(transaction);
  }
}
