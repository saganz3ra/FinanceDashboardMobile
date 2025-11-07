import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:financedashboard/data/datasources/remote/currency_remote_data_source.dart';
import 'package:financedashboard/data/repositories/currency_repository_impl.dart';
import 'package:financedashboard/data/models/currency_model.dart';

// Mock (simulação) da fonte de dados de moeda
// Isso nos permite testar o repositório sem fazer chamadas reais à API
class MockCurrencyRemoteDataSource extends Mock implements CurrencyRemoteDataSource {}

void main() {
  // Declaração das variáveis que serão usadas nos testes
  late CurrencyRepositoryImpl repository;        // Repositório que queremos testar
  late MockCurrencyRemoteDataSource mockDataSource;  // Simulação da fonte de dados

  // Configuração inicial executada antes de cada teste
  setUp(() {
    mockDataSource = MockCurrencyRemoteDataSource();
    repository = CurrencyRepositoryImpl(remoteDataSource: mockDataSource);
  });

  group('Testes do Repositório de Moeda', () {
    test('deve retornar o valor do dólar da fonte de dados remota', () async {
      // Preparação
      final cotacaoEsperada = CurrencyModel(5.0);  // Simulamos uma cotação de R$ 5,00
      // Configuramos o mock para retornar nossa cotação quando solicitado
      when(() => mockDataSource.fetchDollarValue())
          .thenAnswer((_) async => cotacaoEsperada);

      // Ação: Solicita o valor do dólar ao repositório
      final resultado = await repository.getDollarValue();

      // Verificação
      expect(resultado, cotacaoEsperada.value, 
          reason: 'O valor retornado deve ser igual à cotação configurada');
      // Confirma que o método foi chamado exatamente uma vez
      verify(() => mockDataSource.fetchDollarValue()).called(1);
    });

    test('deve tratar erros da fonte de dados remota corretamente', () async {
      // Preparação: Configuramos o mock para simular uma falha na API
      when(() => mockDataSource.fetchDollarValue())
          .thenThrow(Exception('Erro ao buscar cotação do dólar'));

      // Ação e Verificação: O erro deve ser propagado adequadamente
      expect(
        () => repository.getDollarValue(),
        throwsA(isA<Exception>()),
        reason: 'Deve propagar o erro quando a fonte de dados falha',
      );
      // Confirma que a tentativa de buscar o valor foi feita
      verify(() => mockDataSource.fetchDollarValue()).called(1);
    });
  });
}