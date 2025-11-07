import '../../domain/entities/currency.dart';

class CurrencyModel extends Currency {
  CurrencyModel(super.value);

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    final value = double.parse(json['USDBRL']['bid'] as String);
    return CurrencyModel(value);
  }
}
