import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;

  const ApiException(this.message);
}

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> fetchRates(String fromCode) async {
    final uri = Uri.https('open.er-api.com', '/v6/latest/$fromCode');
    final http.Response response;
    try {
      response = await _client.get(uri).timeout(const Duration(seconds: 10));
    } on TimeoutException {
      throw const ApiException('Сервер долго не отвечает, попробуйте ещё раз');
    } on http.ClientException {
      throw const ApiException('Нет подключения к интернету');
    }

    if (response.statusCode == 429) {
      throw const ApiException('Слишком много запросов. Попробуйте позже.');
    }
    if (response.statusCode != 200) {
      throw ApiException('Ошибка сервера (код ${response.statusCode})');
    }

    try {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      if (json is Map<String, dynamic>) return json;
    } on FormatException {
      throw const ApiException('Сервер прислал некорректный ответ');
    }
    throw const ApiException('Сервер прислал некорректный ответ');
  }
}
