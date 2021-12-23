import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'http://tidyhair.xyz/api/barber/';
  var token;
  var photo;
  var name;
  var id;
  var email;
  var alamat;

  gToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (localStorage.getString('token') != null) {
      token = localStorage.getString('token');
    }
    if (localStorage.getInt('id') != null) {
      id = localStorage.getInt('id');
    }
    if (localStorage.getString('name') != null) {
      name = localStorage.getString('name');
    }
    if (localStorage.getString('email') != null) {
      email = localStorage.getString('email');
    }
    if (localStorage.getString('alamat') != null) {
      alamat = localStorage.getString('alamat');
    }
  }

  auth(data, apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  rToken() async {
    await gToken();
    return token;
  }

  getData(apiURL) async {
    var fullUrl = _url + apiURL;
    await gToken();
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
