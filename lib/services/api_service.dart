import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto.dart';

class ApiService {
  static const String _url = 'https://api.coinlore.net/api/tickers/';

  static Future<List<Crypto>> fetchCryptos() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Crypto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cryptos');
    }
  }
}
