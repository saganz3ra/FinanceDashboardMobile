import '../../domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  final String? id;
  TransactionModel({
    required super.value,
    required super.description,
    required super.date,
    required super.isIncome,
    this.id,
  }) : assert(value >= 0, 'O valor da transação não pode ser negativo'),
       super();

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      value: map['value'] is int
          ? (map['value'] as int).toDouble()
          : map['value'] as double,
      description: map['description'] as String,
      date: DateTime.parse(map['date'] as String),
      isIncome: map['isIncome'] as bool,
      id: map['id'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'description': description,
      'date': date.toIso8601String(),
      'isIncome': isIncome,
    };
  }
}
