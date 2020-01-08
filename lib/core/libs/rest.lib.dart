import 'dart:async';
import 'dart:convert';

import 'package:cubic_flame/core/models/exceptions/nome_existente.exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';

class RestLib {
  final JsonDecoder _decoder = JsonDecoder();
  final ConfigEnvironments _config = ConfigEnvironments();

  Future<dynamic> get({
    @required String url,
    mimeType = 'json',
  }) async {
    try {
      final ambiente = _config.getEnvironments();
      final http.Response response = await http.get(
        ambiente['url'] + url,
        headers: await _getHeaders(mimeType, hasBody: false),
      );

      if (_isSuccessRequest(response.statusCode)) {
        final output = _decoder.convert(response.body);
        return output;
      } else {
        throw Exception('Falha ao obter dados');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> post({
    @required String url,
    body,
    mimeType = 'json',
  }) async {
    try {
      final ambiente = _config.getEnvironments();
      final http.Response response = await http.post(
        ambiente['url'] + url,
        body: jsonEncode(body),
        headers: await _getHeaders(mimeType, hasBody: true),
        encoding: Encoding.getByName('utf-8'),
      );

      if (_isSuccessRequest(response.statusCode)) {
        final output = _decoder.convert(response.body);
        return output;
      } else {
        if (response.body.contains("NomeExistenteException")) {
          throw NomeExistenteException();
        }
        
        if (response.reasonPhrase != null) {
          // TODO: Trocar para uma exception custom
          throw Exception(response.reasonPhrase);
        }

        throw Exception('Falha ao obter dados');
      }
    } catch (e) {
      rethrow;
    }
  }

  bool _isSuccessRequest(int httpCode) {
    return httpCode >= 200 && httpCode < 300;
  }

  Future<Map<String, String>> _getHeaders(String mimetype,
      {bool hasBody}) async {
    final _prefs = await SharedPreferences.getInstance();

    Map<String, String> headers = Map<String, String>();
    headers.addAll({'Accept': 'application/' + mimetype});
    if (hasBody) headers.addAll({'Content-Type': 'application/json'});

    if (_prefs.containsKey('token')) {
      headers.addAll({'Authorization': 'bearer ' + _prefs.getString('token')});
    }

    return Future.value(headers);
  }
}
