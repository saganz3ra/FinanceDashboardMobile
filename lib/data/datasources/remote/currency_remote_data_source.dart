import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/currency_model.dart';

abstract class CurrencyRemoteDataSource {
  Future<CurrencyModel> fetchDollarValue();
}

class CurrencyRemoteDataSourceImpl implements CurrencyRemoteDataSource {
  final http.Client client;
  CurrencyRemoteDataSourceImpl({required this.client});

  @override
  Future<CurrencyModel> fetchDollarValue() async {
    final url = Uri.parse('https://economia.awesomeapi.com.br/json/last/USD-BRL');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return CurrencyModel.fromJson(data);
    } else {
      throw Exception('Server error');
    }
  }
}
