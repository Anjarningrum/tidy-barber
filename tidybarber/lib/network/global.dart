import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TopArtikel {
  final String _url = 'http://192.168.1.3:8000/api/barber/dashboard';
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token') ?? "")['token'];
  }

  _rToken() async {}
  auth(data, apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getArtikel() async {
    await _getToken();
    return await http.get(
      Uri.parse(_url),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
