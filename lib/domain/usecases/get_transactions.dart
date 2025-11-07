import '../repositories/transaction_repository.dart';
import '../entities/transaction.dart';

class GetTransactions {
  final TransactionRepository repository;
  GetTransactions(this.repository);

  Future<List<Transaction>> call() async {
    return await repository.getTransactions();
  }
}
