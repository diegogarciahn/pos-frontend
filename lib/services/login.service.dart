import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.model.dart';
import 'package:http/http.dart' as http;
import 'package:soft_frontend/constans.dart';

Future login(String usuario, String passwd) async {
  var client = http.Client();
  final prefs = await SharedPreferences.getInstance();
  try {
    var response = await client.post(Uri.parse(API_URL + 'user/login'),
        body: {'username': usuario, 'password': passwd}).timeout(Duration(seconds: 5) ,onTimeout: () {
          return http.Response('error', 503);
        },);
    switch (response.statusCode) {
      case 200:
        User user = User.fromJson(response.body);
        await prefs.setString('response', response.body);
        return user;
      case 401:
        return 401;
      case 404:
        return 404;
      case 408:
        return 408;
      case 500:
        return 500;
    }
  } on http.ClientException catch (_) {
    print('Servicio no disponible.');
    return 503;
  } on Error catch (e) {
    print(e);
    return 1928;
  } finally {
    client.close();
  }
  print('abrazame muy fuerte amor');
}

Future<bool> logout() async {
  var client = http.Client();
  final prefs = await SharedPreferences.getInstance();
  User? user = null;
  try {
    var response = await client.get(Uri.parse(API_URL + 'user/login'));
    if (response.statusCode == 200) {
      await prefs.setString('response', response.body);
      final nologin = await prefs.remove('logeado');
      return true;
    }
    return false;
  } finally {
    client.close();
  }
}
