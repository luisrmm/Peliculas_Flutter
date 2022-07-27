import 'dart:convert';

import 'package:app_peliculas/models/api_response.dart';
import 'package:app_peliculas/models/login.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static final urlLogin = 'https://apimovie.somee.com/api/Users/Login';
  static Future<Login> authLogin(String username, String password) async {
    Login _apiResponse = new Login();
    var url = Uri.parse(urlLogin);
    Map data = {
      'username': username,
      'password': password,
    };
    var body = jsonEncode(data);
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
       _apiResponse = Login.fromJson(jsonDecode(response.body));
      return _apiResponse;
    } else {
      return null;
    }
    
  }
}
