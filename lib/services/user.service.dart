import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
//import 'dart:html';
import '../models/user.model.dart';
import '../models/gestionUsuario.model.dart';
import 'package:soft_frontend/constans.dart';

Future<User?> logins(String username, String passwd) async {
  var client = http.Client();
  User? user = null;
  try {
    var response = await client.post(Uri.parse(API_URL + "user/login"),
        body: {'username': username, 'password': passwd});
    if (response.statusCode == 200) {
      User user = User.fromJson(response.body);
      log(user.toString());
      return user;
    } else {
      return user;
    }
  } finally {
    client.close();
  }
}

Future<List<User?>> crearUser(String usuario, String pass, String email,
    String idEmpleado, String idRol) async {
  var client = http.Client();
  User? user = null;
  List<User?> UserCreado = [];
  try {
    var response = await client.post(Uri.parse(API_URL + "user/crearuser"),
        body: ({
          'usuario': usuario,
          'password': pass,
          'email': email,
          'idEmpleado': idEmpleado,
          'idRol': idRol
        }));
    print(response.body);
    if (response.statusCode == 200) {
      print(User);
    } else {}
    return UserCreado;
  } catch (e) {
    return UserCreado;
  } finally {
    client.close();
  }
}

Future mostrarUsuarios() async {
  var client = http.Client();
  try {
    final response = await http.post(Uri.parse(API_URL + 'user/mostraruser'));
    if (response.statusCode == 200) {
      Usuario listaUser = usuarioFromJson(response.body);
      return listaUser;
    }
  } catch (e) {}
}

Future<List<Usuario?>> eliminarUsuario(String id) async {
  print(id);
  var client = http.Client();
  Usuario? usuario = null;
  List<Usuario?> usuarioCreado = [];
  try {
    var response = await http.post(Uri.parse(API_URL + "user/bajauser"),
        body: ({'id': id}));
    print(response.body);
    if (response.statusCode == 200) {
      print(Usuario);
      //return clienteCreado;
    } else {
      // return clienteCreado;
    }
    return usuarioCreado;
  } catch (e) {
    print(e);
    return usuarioCreado;
  } finally {
    http.Client().close();
  }
}

Future<List<Usuario?>> ActualizarUsuario(
    String id,
    String usuario,
    /*String password,*/ String email,
    /*String idEmpleado,*/ String idRol) async {
  var client = http.Client();
  Usuario? usuarios = null;
  List<Usuario> usuarioActualizado = [];
  try {
    var response = await http.put(Uri.parse(API_URL + 'user/updateUser'),
        body: ({
          'id': id,
          'usuario': usuario,
          // 'password': password,
          'email': email,
          //'idEmpleado': idEmpleado,
          'idRol': idRol,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      print(Usuario);
    } else {}
    return usuarioActualizado;
  } catch (e) {
    return usuarioActualizado;
  } finally {
    http.Client().close();
  }
}
