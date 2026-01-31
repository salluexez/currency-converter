import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:curreny_converter/core/constant.dart';
import 'package:curreny_converter/data/models/currency_model.dart';

class ApiService {
  Future<CurrencyModel> fetchRates(String baseCurrency) async {
    final response = await http.get(
      Uri.parse('${AppConstants.baseUrl}$baseCurrency'),
    );

    if (response.statusCode == 200) {
      return CurrencyModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the exchange rates');
    }
  }
}