import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static Future<double> getDollarValue() async {
    final url = Uri.parse("https://economia.awesomeapi.com.br/json/last/USD-BRL");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final value = double.parse(data["USDBRL"]["bid"]);
      return value;
    } else {
      throw Exception("Erro ao buscar valor do dólar");
    }
  }
}
