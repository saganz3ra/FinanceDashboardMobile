// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:financedashboard/main.dart';

void main() {
  testWidgets('App deve iniciar na tela de login', (
    WidgetTester tester,
  ) async {
    // Preparação: Constrói nossa aplicação
    await tester.pumpWidget(const MyApp());

    // Verificação: Deve encontrar o título da tela de login
    expect(
      find.text('Login'),
      findsOneWidget,
      reason: 'O título "Login" deve estar visível na AppBar',
    );

    // Verificação: Deve encontrar campos de login
    expect(
      find.text('Email'),
      findsWidgets,
      reason: 'O campo de email deve estar visível',
    );
    
    expect(
      find.text('Senha'),
      findsWidgets,
      reason: 'O campo de senha deve estar visível',
    );
  });
}
