import 'package:flutter_test/flutter_test.dart';
import 'package:financedashboard/data/models/transaction_model.dart';

void main() {
  group('Testes do Modelo de Transação', () {
    test('deve criar uma transação válida a partir de um Map', () {
      // Preparação: Criamos um Map simulando os dados que viriam do Firestore
      // Cada campo representa uma propriedade da transação
      final map = {
        'id': '1',                            // Identificador único
        'description': 'Salário mensal',      // Descrição da transação
        'value': 100.0,                       // Valor em reais
        'date': '2023-11-06T00:00:00.000',   // Data no formato ISO
        'isIncome': true,                     // true = receita, false = despesa
      };

      // Ação: Convertemos o Map em um objeto TransactionModel
      final transacao = TransactionModel.fromMap(map);

      // Verificação: Confirmamos se cada campo foi convertido corretamente
      expect(transacao.id, '1', reason: 'O ID deve ser preservado na conversão');
      expect(transacao.description, 'Salário mensal', reason: 'A descrição deve ser preservada');
      expect(transacao.value, 100.0, reason: 'O valor deve ser mantido como double');
      expect(transacao.date.year, 2023, reason: 'O ano deve ser extraído corretamente da data');
      expect(transacao.date.month, 11, reason: 'O mês deve ser extraído corretamente da data');
      expect(transacao.date.day, 6, reason: 'O dia deve ser extraído corretamente da data');
      expect(transacao.isIncome, true, reason: 'O tipo de transação (receita/despesa) deve ser preservado');
    });

    test('deve converter uma transação para Map corretamente', () {
      // Preparação: Criamos uma transação com todos os campos preenchidos
      final transacao = TransactionModel(
        id: '1',
        description: 'Conta de luz',
        value: 100.0,
        date: DateTime(2023, 11, 6),
        isIncome: false,  // Despesa
      );

      // Ação: Convertemos a transação em Map para salvar no Firestore
      final map = transacao.toMap();

      // Verificação: Garantimos que os dados estão no formato correto para o Firestore
      expect(map['description'], 'Conta de luz', 
          reason: 'A descrição deve ser convertida sem alterações');
      expect(map['value'], 100.0, 
          reason: 'O valor deve permanecer como double');
      expect(map['date'], '2023-11-06T00:00:00.000', 
          reason: 'A data deve ser convertida para string no formato ISO');
      expect(map['isIncome'], false, 
          reason: 'O indicador de receita/despesa deve ser preservado');
    });

    test('deve lidar com valores inteiros na conversão do Map', () {
      // Preparação: Map com valor como inteiro (pode acontecer dependendo da fonte dos dados)
      final map = {
        'id': '1',
        'description': 'Valor inteiro',
        'value': 100,  // Valor como inteiro
        'date': '2023-11-06T00:00:00.000',
        'isIncome': true,
      };

      // Ação: Tentamos converter o Map com valor inteiro
      final transacao = TransactionModel.fromMap(map);

      // Verificação: O valor deve ser convertido para double automaticamente
      expect(transacao.value, 100.0, 
          reason: 'Valores inteiros devem ser convertidos para double');
      expect(transacao.value, isA<double>(), 
          reason: 'O tipo do valor deve sempre ser double');
    });

    test('não deve permitir valores negativos', () {
      // Ação e Verificação: Tentamos criar uma transação com valor negativo
      expect(
        () => TransactionModel(
          id: '1',
          description: 'Valor inválido',
          value: -100.0,  // Valor negativo não deve ser permitido
          date: DateTime.now(),
          isIncome: true,
        ),
        throwsAssertionError,
        reason: 'Deve lançar erro ao tentar criar transação com valor negativo',
      );
    });
  });
}