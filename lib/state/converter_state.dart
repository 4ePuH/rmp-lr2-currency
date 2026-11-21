import 'package:flutter/foundation.dart';

import '../data/api_client.dart';
import '../data/currency_repository.dart';
import '../models/currency.dart';

class ConverterState extends ChangeNotifier {
  final CurrencyRepository repository;

  ConverterState({required this.repository});

  static const double maxAmount = 1e12;

  String fromCode = 'EUR';
  String toCode = 'RUB';
  String amountText = '';

  bool isLoading = false;
  String? inputError;
  String? requestError;
  ExchangeRate? rate;
  double? result;

  void setAmount(String text) {
    amountText = text;
    inputError = null;
    requestError = null;
    rate = null;
    result = null;
    notifyListeners();
  }

  void setFrom(String code) {
    if (isLoading || fromCode == code) return;
    fromCode = code;
    _pairChanged();
  }

  void setTo(String code) {
    if (isLoading || toCode == code) return;
    toCode = code;
    _pairChanged();
  }

  void swap() {
    if (isLoading) return;
    final previousFrom = fromCode;
    fromCode = toCode;
    toCode = previousFrom;
    _pairChanged();
  }

  void _pairChanged() {
    if (result != null) {
      convert();
      return;
    }
    requestError = null;
    notifyListeners();
  }

  Future<void> convert() async {
    if (isLoading) return;

    final requestedAmount = amountText;
    final text = requestedAmount
        .trim()
        .replaceAll(' ', '')
        .replaceAll(',', '.');
    final amount = double.tryParse(text);
    rate = null;
    result = null;
    requestError = null;
    inputError = null;

    if (text.isEmpty) {
      inputError = 'Введите сумму';
    } else if (amount == null || !amount.isFinite) {
      inputError = 'Сумма должна быть числом';
    } else if (amount < 0) {
      inputError = 'Сумма не может быть отрицательной';
    } else if (amount > maxAmount) {
      inputError = 'Слишком большая сумма';
    }
    if (inputError != null) {
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();
    try {
      final exchangeRate = await repository.loadRate(fromCode, toCode);
      if (amountText != requestedAmount) return;
      final converted = amount! * exchangeRate.value;
      if (!converted.isFinite) {
        throw const ApiException('Слишком большой результат');
      }
      rate = exchangeRate;
      result = converted;
    } on ApiException catch (error) {
      if (amountText == requestedAmount) requestError = error.message;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
