import 'package:flutter_test/flutter_test.dart';
import 'package:financedashboard/presentation/controllers/auth_controller.dart';

void main() {
  late AuthController controller;

  setUp(() {
    controller = AuthController();
  });

  test('signIn com credenciais válidas deve autenticar (bypass)', () async {
    await controller.signIn('user@test.com', '123456');
    expect(controller.isLoading, false);
    expect(controller.error, isNull);
    expect(controller.currentEmail, 'user@test.com');
  });

  test('signIn com credenciais inválidas deve falhar', () async {
    await controller.signIn('user', '123');
    expect(controller.isLoading, false);
    expect(controller.error, isNotNull);
    expect(controller.currentEmail, isNull);
  });

  test('register com dados válidos deve autenticar (bypass)', () async {
    await controller.register('new@test.com', '123456', displayName: 'Novo');
    expect(controller.isLoading, false);
    expect(controller.error, isNull);
    expect(controller.currentEmail, 'new@test.com');
  });

  test('signOut deve limpar usuário atual', () async {
    await controller.signIn('user@test.com', '123456');
    await controller.signOut();
    expect(controller.currentEmail, isNull);
    expect(controller.error, isNull);
  });
}
