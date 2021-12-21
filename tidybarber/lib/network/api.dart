import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'http://192.168.1.3:8000/api/barber/';
  var token;
  var photo;
  var name;
  var id;
  var email;
  var alamat;

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    id = localStorage.getInt('id');
    name = localStorage.getString('name')!;
    email = localStorage.getString('email')!;
    alamat = localStorage.getString('alamat')!;
    photo = localStorage.getString('photo')!;
  }

  auth(data, apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  rToken() async {
    await getToken();
    return token;
  }

  getData(apiURL) async {
    var fullUrl = _url + apiURL;
    await getToken();
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
