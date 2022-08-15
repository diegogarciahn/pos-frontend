import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.model.dart';
import 'package:http/http.dart' as http;
import 'package:soft_frontend/constans.dart';

Future<User?> login(String usuario, String passwd) async {
  var client = http.Client();
  User? user = null;
  final prefs = await SharedPreferences.getInstance();
  try {
    var response = await client.post(Uri.parse(API_URL + "user/login"),
        body: {'username': usuario, 'password': passwd});
    if (response.statusCode == 200) {
      User user = User.fromJson(response.body);
      await prefs.setString("response", response.body);
      return user;
    } else {
      await prefs.setString("response", response.body);
      return user;
    }
  } finally {
    client.close();
  }
}

Future<bool> logout() async {
  var client = http.Client();
  final prefs = await SharedPreferences.getInstance();
  User? user = null;
  try {
    var response = await client.get(Uri.parse(API_URL + "user/login"));
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
