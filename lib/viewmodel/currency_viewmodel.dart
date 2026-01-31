import 'package:flutter/material.dart';
import '../data/models/currency_model.dart';
import '../data/services/api_service.dart';

class CurrencyViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  CurrencyModel? currencyModel;
  bool isLoading = false;
  String? errorMessage;

  String fromCurrency = 'USD';
  String toCurrency = 'INR';
  double result = 0.0;

  Future<void> getRates() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      currencyModel = await _apiService.fetchRates(fromCurrency);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = 'Failed to load exchange rates. Please check your internet connection.';
      notifyListeners();
    }
  }

  void convert(double amount) {
    if (currencyModel == null) return;

    final rate = currencyModel!.rates[toCurrency];
    result = amount * rate;

    notifyListeners();
  }

  List<String> get currencies =>
      currencyModel?.rates.keys.toList() ?? [];
}