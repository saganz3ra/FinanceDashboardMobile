// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:financedashboard/main.dart';

void main() {
  testWidgets('App deve iniciar e mostrar a tela inicial', (
    WidgetTester tester,
  ) async {
    // Preparação: Constrói nossa aplicação
    await tester.pumpWidget(const MyApp());

    // Verificação: Deve encontrar o título da tela inicial
    expect(
      find.text('Home'),
      findsOneWidget,
      reason: 'O título "Home" deve estar visível na AppBar',
    );

    // Verificação: Deve encontrar o texto de boas-vindas
    expect(
      find.text('Bem-vindo ao Finance Dashboard!'),
      findsOneWidget,
      reason: 'O texto de boas-vindas deve estar visível',
    );

    // Verificação: Deve encontrar os botões de navegação
    expect(
      find.text('Ir para Login'),
      findsOneWidget,
      reason: 'O botão de login deve estar visível',
    );
    expect(
      find.text('Ir para Dashboard'),
      findsOneWidget,
      reason: 'O botão do dashboard deve estar visível',
    );
  });
}
