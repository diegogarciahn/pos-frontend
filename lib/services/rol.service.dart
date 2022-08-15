import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft_frontend/models/rolResponse.model.dart';
import 'dart:convert';
import 'dart:developer';
import '../models/rol.model.dart';
import '../models/gestionrol.model.dart';
import 'package:soft_frontend/constans.dart';

Future<List<Rol2?>> crearRol(String rol, String descripcion, context) async {
  var client = http.Client();
  Rol2? role;
  List<Rol2?> RolCreado = [];
  try {
    var response = await client.post(Uri.parse(API_URL + "roles/create"),
        body: ({'rol': rol, 'descripcion': descripcion}));
    if (response.statusCode == 200) {
      final decode = RolResponse.fromJson(response.body);
      print('hola');
      print(decode.data);
      RolCreado.add(decode.data);
    return RolCreado;
    } else {}
    return RolCreado;
  } catch (e) {
    return RolCreado;
  } finally {
    client.close();
  }
}

Future mostrarRol() async {
  var client = http.Client();
  try {
    final response = await http.post(Uri.parse(API_URL + 'roles/mostrarroles'));
    if (response.statusCode == 200) {
      Role listaRol = rolFromJson(response.body);
      return listaRol;
    }
  } catch (e) {}
}

Future<List<Role?>> eliminarRol(String id) async {
  print(id);
  var client = http.Client();
  Role? roles = null;
  List<Role?> rolCreado = [];
  try {
    var response = await http.post(Uri.parse(API_URL + 'roles/bajarol'),
        body: ({'id': id}));
    print(response.body);
    if (response.statusCode == 200) {
      print(Role);
      //return clienteCreado;
    } else {
      // return clienteCreado;
    }
    return rolCreado;
  } catch (e) {
    print(e);
    return rolCreado;
  } finally {
    http.Client().close();
  }
}

Future<List<Role?>> ActualizarRole(
    String id, String rol, String descripcion) async {
  var client = http.Client();
  Role? roles = null;
  List<Role> RoleActualizado = [];
  try {
    var response = await http.put(Uri.parse(API_URL + 'roles/updaterol'),
        body: ({
          'id': id,
          'rol': rol,
          'descripcion': descripcion,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      print(Role);
    } else {}
    return RoleActualizado;
  } catch (e) {
    return RoleActualizado;
  } finally {
    http.Client().close();
  }
}
