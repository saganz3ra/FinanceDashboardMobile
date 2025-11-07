class Transaction {
  final double value;
  final String description;
  final DateTime date;
  final bool isIncome;
  Transaction({
    required this.value,
    required this.description,
    required this.date,
    required this.isIncome,
  });
}
