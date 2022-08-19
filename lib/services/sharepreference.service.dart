  import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
  
  Future<String> getToken() async {

    SharedPreferences prefs = await  SharedPreferences.getInstance();
    final String? response = prefs.getString('response');
    Object? finalresponse;
    finalresponse = response;

    User user = User.fromJson(finalresponse.toString());

    String token = user.sesion.token;
    return token;

  }
  Future<bool> setArqueadoCerrado() async {
    SharedPreferences prefs = await  SharedPreferences.getInstance();
     final response = prefs.setBool('arqueoabierto',false);
    return response;

  }
  Future<bool> getarqueo() async {
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    bool? response = prefs.getBool('arqueoabierto');
    return response!;
  }


