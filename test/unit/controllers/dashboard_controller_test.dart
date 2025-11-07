import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:financedashboard/presentation/controllers/dashboard_controller.dart';
import 'package:financedashboard/domain/entities/transaction.dart' as domain;
import 'package:financedashboard/domain/usecases/get_transactions.dart';
import 'package:financedashboard/domain/usecases/get_dollar_value.dart';
import 'package:financedashboard/domain/usecases/add_transaction.dart';
import 'package:financedashboard/domain/usecases/edit_transaction.dart';
import 'package:financedashboard/domain/usecases/delete_transaction.dart';

class _MockGetTransactions extends Mock implements GetTransactions {}

class _MockGetDollarValue extends Mock implements GetDollarValue {}

class _MockAddTransaction extends Mock implements AddTransaction {}

class _MockEditTransaction extends Mock implements EditTransaction {}

class _MockDeleteTransaction extends Mock implements DeleteTransaction {}

void main() {
  late _MockGetTransactions getTransactions;
  late _MockGetDollarValue getDollarValue;
  late _MockAddTransaction addTransaction;
  late _MockEditTransaction editTransaction;
  late _MockDeleteTransaction deleteTransaction;
  late DashboardController controller;

  setUp(() {
    getTransactions = _MockGetTransactions();
    getDollarValue = _MockGetDollarValue();
    addTransaction = _MockAddTransaction();
    editTransaction = _MockEditTransaction();
    deleteTransaction = _MockDeleteTransaction();

    controller = DashboardController(
      getTransactions: getTransactions,
      getDollarValue: getDollarValue,
      addTransaction: addTransaction,
      editTransaction: editTransaction,
      deleteTransaction: deleteTransaction,
    );
  });

  test('loadAll deve carregar transações e valor do dólar', () async {
    // Arrange
    final txs = [
      domain.Transaction(
        value: 10,
        description: 'Teste',
        date: DateTime(2023, 1, 1),
        isIncome: true,
      ),
    ];
    when(() => getTransactions.call()).thenAnswer((_) async => txs);
    when(() => getDollarValue.call()).thenAnswer((_) async => 5.0);

    // Act
    await controller.loadAll();

    // Assert
    expect(controller.isLoading, false, reason: 'Deve encerrar loading');
    expect(controller.transactions, txs, reason: 'Deve popular transações');
    expect(controller.dollarValue, 5.0, reason: 'Deve popular valor do dólar');
    expect(controller.error, isNull, reason: 'Não deve haver erro');
  });

  test('add deve delegar para usecase e recarregar lista', () async {
    // Arrange
    final tx = domain.Transaction(
      value: 20,
      description: 'Entrada',
      date: DateTime(2023, 1, 2),
      isIncome: true,
    );
    when(() => addTransaction.call(tx)).thenAnswer((_) async {});
    when(() => getTransactions.call()).thenAnswer((_) async => [tx]);
    when(() => getDollarValue.call()).thenAnswer((_) async => 4.8);

    // Act
    await controller.add(tx);

    // Assert
    verify(() => addTransaction.call(tx)).called(1);
    expect(controller.transactions.length, 1);
  });

  test('edit deve delegar para usecase e recarregar lista', () async {
    // Arrange
    final tx = domain.Transaction(
      value: 30,
      description: 'Saída',
      date: DateTime(2023, 1, 3),
      isIncome: false,
    );
    when(() => editTransaction.call(0, tx)).thenAnswer((_) async {});
    when(() => getTransactions.call()).thenAnswer((_) async => [tx]);
    when(() => getDollarValue.call()).thenAnswer((_) async => 4.7);

    // Act
    await controller.edit(0, tx);

    // Assert
    verify(() => editTransaction.call(0, tx)).called(1);
    expect(controller.transactions.first.description, 'Saída');
  });

  test('deleteAt deve delegar para usecase e recarregar lista', () async {
    // Arrange
    when(() => deleteTransaction.call(0)).thenAnswer((_) async {});
    when(() => getTransactions.call()).thenAnswer((_) async => []);
    when(() => getDollarValue.call()).thenAnswer((_) async => 4.9);

    // Act
    await controller.deleteAt(0);

    // Assert
    verify(() => deleteTransaction.call(0)).called(1);
    expect(controller.transactions, isEmpty);
  });
}
