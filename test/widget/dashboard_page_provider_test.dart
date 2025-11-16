import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:financedashboard/presentation/pages/dashboard_page.dart';
import 'package:financedashboard/presentation/controllers/dashboard_controller.dart';
import 'package:financedashboard/domain/usecases/get_transactions.dart';
import 'package:financedashboard/domain/usecases/get_dollar_value.dart';
import 'package:financedashboard/domain/usecases/add_transaction.dart';
import 'package:financedashboard/domain/usecases/edit_transaction.dart';
import 'package:financedashboard/domain/usecases/delete_transaction.dart';
import 'package:financedashboard/domain/entities/transaction.dart' as domain;

class _MockGetTransactions extends Mock implements GetTransactions {}

class _MockGetDollarValue extends Mock implements GetDollarValue {}

class _MockAddTransaction extends Mock implements AddTransaction {}

class _MockEditTransaction extends Mock implements EditTransaction {}

class _MockDeleteTransaction extends Mock implements DeleteTransaction {}

void main() {
  testWidgets('DashboardPage deve exibir lista com uma transação', (
    tester,
  ) async {
    // Arrange: cria um controller com estado pronto
    final controller = DashboardController(
      getTransactions: _MockGetTransactions(),
      getDollarValue: _MockGetDollarValue(),
      addTransaction: _MockAddTransaction(),
      editTransaction: _MockEditTransaction(),
      deleteTransaction: _MockDeleteTransaction(),
    );
    controller.isLoading = false;
    controller.dollarValue = 5.0;
    controller.transactions = [
      domain.Transaction(
        value: 100.0,
        description: 'Teste UI',
        date: DateTime(2024, 1, 1),
        isIncome: true,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<DashboardController>.value(
          value: controller,
          child: const DashboardPage(),
        ),
      ),
    );

    // Act
    await tester.pumpAndSettle();

    // Assert
    expect(find.textContaining('Entrada:'), findsOneWidget);
    expect(find.textContaining('Teste UI'), findsOneWidget);
    expect(
      find.textContaining('≈ US'),
      findsOneWidget,
    ); // mostra conversão aproximada
  });
}
