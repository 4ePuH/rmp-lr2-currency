import '../models/currency.dart';
import 'api_client.dart';

class CurrencyRepository {
  final ApiClient api;

  CurrencyRepository(this.api);

  Future<ExchangeRate> loadRate(String from, String to) async {
    final data = await api.fetchRates(from);
    final rates = data['rates'];
    if (data['result'] != 'success' ||
        data['base_code'] != from ||
        rates is! Map) {
      throw const ApiException('Сервер прислал некорректный ответ');
    }

    final rate = rates[to];
    if (rate is! num || !rate.isFinite || rate <= 0) {
      throw ApiException('Нет курса для валюты $to');
    }

    final timestamp = data['time_last_update_unix'];
    final updatedAt = timestamp is int
        ? DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
        : null;
    return ExchangeRate(rate.toDouble(), updatedAt);
  }
}
