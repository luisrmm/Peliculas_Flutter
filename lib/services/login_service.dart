import 'dart:convert';
import 'package:app_peliculas/models/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static var errorLoginByUser = [];
  static var index;
  static var count = 0;
  static final urlLogin = 'https://apimovie.somee.com/api/Users/Login';
  static final urlLoginDesactived =
      'https://apimovie.somee.com/api/Users/Desactived';
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
      if (response.body == 'Usuario y/o contraseña incorrectos.') {
        _errorMessage(response.body);
      }
      if (response.body ==
          'Su usuario se encuentra inactivo, por favor comuníquese con el administrador.') {
        _errorMessage(response.body);
      }
      if (response.body == 'Contraseña incorrectos.') {
        if (errorLoginByUser.isEmpty) {
          errorLoginByUser.add(username);
        } else {
          index = errorLoginByUser.lastIndexOf(errorLoginByUser) + 1;
          errorLoginByUser.insert(index, username);
        }
        count = errorLoginByUser
            .where((element) => element.toString().contains(username))
            .length;
      }
      if (count >= 3) {
        Map data = {
          'username': username,
        };
        var body = jsonEncode(data);
        var urlDesactivaded = Uri.parse(urlLoginDesactived);
        await http.put(urlDesactivaded,
            headers: {"Content-Type": "application/json"}, body: body);
      }
      return null;
    }
  }

  static _errorMessage(String message) {
    Fluttertoast.showToast(
        msg: message, // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER, // location
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        ); // dura
  }
}
