import '../repositories/transaction_repository.dart';
import '../entities/transaction.dart';

class EditTransaction {
  final TransactionRepository repository;
  EditTransaction(this.repository);

  Future<void> call(int index, Transaction transaction) async {
    await repository.editTransaction(index, transaction);
  }
}
