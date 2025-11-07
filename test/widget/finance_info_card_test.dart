import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financedashboard/shared/widgets/molecules/finance_info_card.dart';

void main() {
  group('Testes do Card de Informação Financeira', () {
    testWidgets('deve exibir título e subtítulo corretamente', (WidgetTester tester) async {
      // Preparação
      const testTitle = 'Saldo Total';     // Título que será exibido no card
      const testSubtitle = 'R\$ 1.234,56';  // Valor formatado como subtítulo
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FinanceInfoCard(
              icon: Icons.account_balance_wallet,
              title: testTitle,
              subtitle: testSubtitle,
              iconColor: Colors.blue,
              semanticsLabel: 'Ícone de carteira',
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testSubtitle), findsOneWidget);
    });

    testWidgets('deve exibir o ícone com a cor correta', (WidgetTester tester) async {
      // Preparação: Define uma cor específica para testar
      const corTeste = Colors.red;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FinanceInfoCard(
              icon: Icons.account_balance_wallet,
              title: 'Test',
              subtitle: 'Subtitle',
              iconColor: corTeste,        // Cor que queremos verificar
              semanticsLabel: 'Ícone de teste',
            ),
          ),
        ),
      );

      // Assert
      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.color, corTeste,
          reason: 'O ícone deve ser exibido na cor especificada');
    });

    testWidgets('deve ter o rótulo semântico correto para acessibilidade', (WidgetTester tester) async {
      // Preparação: Define um rótulo semântico para acessibilidade
      const rotuloAcessibilidade = 'Cartão com informações de saldo';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FinanceInfoCard(
              icon: Icons.account_balance_wallet,
              title: 'Test',
              subtitle: 'Subtitle',
              iconColor: Colors.blue,
              semanticsLabel: rotuloAcessibilidade,  // Rótulo para leitores de tela
            ),
          ),
        ),
      );

      // Assert
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.semanticLabel, rotuloAcessibilidade,
          reason: 'O ícone deve ter o rótulo semântico correto para acessibilidade');
    });
  });
}