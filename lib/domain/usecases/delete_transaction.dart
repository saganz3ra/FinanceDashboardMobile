import '../repositories/transaction_repository.dart';

class DeleteTransaction {
  final TransactionRepository repository;
  DeleteTransaction(this.repository);

  Future<void> call(int index) async {
    await repository.deleteTransaction(index);
  }
}
