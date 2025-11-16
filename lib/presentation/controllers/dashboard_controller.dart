import 'package:flutter/foundation.dart';
import 'package:financedashboard/domain/entities/transaction.dart';
import 'package:financedashboard/domain/usecases/get_transactions.dart';
import 'package:financedashboard/domain/usecases/get_dollar_value.dart';
import 'package:financedashboard/domain/usecases/add_transaction.dart';
import 'package:financedashboard/domain/usecases/edit_transaction.dart';
import 'package:financedashboard/domain/usecases/delete_transaction.dart';
import 'package:financedashboard/di/injection_container.dart' as sl;

/// ChangeNotifier responsável pelo estado da tela de Dashboard.
///
/// Mantém a lista de transações, o valor do dólar usado no app e flags de
/// carregamento/erro. Encapsula chamadas a usecases e expõe métodos que a
/// UI pode chamar (loadAll, add, edit, deleteAt).
class DashboardController extends ChangeNotifier {
  List<Transaction> transactions = [];
  double? dollarValue;
  bool isLoading = false;
  String? error;

  final GetTransactions _getTransactions;
  final GetDollarValue _getDollarValue;
  final AddTransaction _addTransaction;
  final EditTransaction _editTransaction;
  final DeleteTransaction _deleteTransaction;

  DashboardController({
    GetTransactions? getTransactions,
    GetDollarValue? getDollarValue,
    AddTransaction? addTransaction,
    EditTransaction? editTransaction,
    DeleteTransaction? deleteTransaction,
  }) : _getTransactions = getTransactions ?? sl.sl<GetTransactions>(),
       _getDollarValue = getDollarValue ?? sl.sl<GetDollarValue>(),
       _addTransaction = addTransaction ?? sl.sl<AddTransaction>(),
       _editTransaction = editTransaction ?? sl.sl<EditTransaction>(),
       _deleteTransaction = deleteTransaction ?? sl.sl<DeleteTransaction>();

  /// Carrega transações e cotação do dólar.
  Future<void> loadAll() async {
    isLoading = true;
    notifyListeners();
    try {
      final txs = await _getTransactions.call();
      final usdResult = await _getDollarValue.call();

      transactions = txs;

      usdResult.fold(
        (failure) {
          error = failure.message;
          dollarValue = null;
        },
        (value) {
          dollarValue = value;
          error = null;
        },
      );
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> add(Transaction t) async {
    await _addTransaction.call(t);
    await loadAll();
  }

  Future<void> edit(int index, Transaction t) async {
    await _editTransaction.call(index, t);
    await loadAll();
  }

  Future<void> deleteAt(int index) async {
    await _deleteTransaction.call(index);
    await loadAll();
  }
}
