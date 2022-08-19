import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:soft_frontend/models/buscarProducto.dart';
//import 'package:soft_frontend/models/buscarProducto.dart';
import 'package:soft_frontend/models/Tipoproducto.model.dart';
import 'dart:convert';
import '../constans.dart';

// ignore: non_constant_identifier_names
class FetchUser {
  String fetchurl = '';
  List<Tipoproducto> results = [];
  Future<List<Tipoproducto>> getUserList({String? query}) async {
    var data = [];
    var url = Uri.parse(API_URL + 'producto/mostrartipos');
    var response = await http.get(url);
    List<Tipoproducto> users = [];
    try {
      if (response.statusCode == 200) {
        var units = (json.decode(response.body)
            as Map<String, dynamic>)['tipoProducto'];
        //results = units.map((e) => Tipoproducto.fromJson(e)).toList();
        for (var u in units) {
          Tipoproducto user = Tipoproducto(
              id: u['id'],
              tipoProducto: u['tipoProducto'],
              descripcionProducto: u['descripcionProducto'],
              isvTipoProducto: u['isvTipoProducto']);
          users.add(user);
        }
        if (query != null) {
          users = users
              .where((element) => element.tipoProducto!
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('Api error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return users;
  }
}

Future eliminarTipoProductoService(String idTipoProducto, String token) async {
  var response = await http.post(Uri.parse(API_URL + 'producto/eliminartipo'),
      body: ({
        'id': idTipoProducto,
        'token': token,
      }));
  if (response.statusCode == 200) {
    return 200;
  } else if (response.statusCode == 500) {
    return 500;
  } else if (response.statusCode == 409) {
    return 401;
  } else if (response.statusCode == 401) {
    return 401;
  }
}

Future obtenerTipos(String token) async {
  var url = Uri.parse(API_URL + 'producto/mostrartipos');
  var response = await http.post(url, body: {'token': token});
  List<Tipoproducto> users = [];
  try {
    if (response.statusCode == 200) {
      var units =
          (json.decode(response.body) as Map<String, dynamic>)['tipoProducto'];
      for (var u in units) {
        Tipoproducto user = Tipoproducto(
            id: u['id'],
            tipoProducto: u['tipoProducto'],
            descripcionProducto: u['descripcionProducto'],
            isvTipoProducto: u['isvTipoProducto']);
        users.add(user);
      }
      return users;
    } else if (response.statusCode == 404) {
      return 404;
    } else if (response.statusCode == 500) {
      return 500;
    } else if (response.statusCode == 401) {
      return 401;
    }
  } on Exception catch (e) {
    print('error: $e');
    return 1928;
  }
}

Future crearTipoProductoService(String tipoProducto, String descripcionProducto,
    String isvTipoProducto, String token) async {
  try {
    var response = await http.post(Uri.parse(API_URL + 'producto/tipoproducto'),
        body: ({
          'tipoProducto': tipoProducto,
          'descripcionProducto': descripcionProducto,
          'isvTipoProducto': isvTipoProducto,
          'token': token,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 500) {
      return 500;
    } else if (response.statusCode == 409) {
      return 401;
    } else if (response.statusCode == 401) {
      return 401;
    }
  } catch (e) {
    print(e);
    return 1928;
  } finally {}
}

Future actualizarTipoProducto(String idTipoProducto, String tipoProducto,
    String descripcionProducto, String isvTipoProducto, String token) async {
  try {
    var response =
        await http.post(Uri.parse(API_URL + 'producto/actualizartipo/'),
            body: ({
              'id': idTipoProducto.toString(),
              'tipoProducto': tipoProducto,
              'descripcionProducto': descripcionProducto,
              'isvTipoProducto': isvTipoProducto,
              'token': token,
            }));
    print(response.body);
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 404) {
      return 404;
    } else if (response.statusCode == 500) {
      return 500;
    }
  } catch (e) {
    print(e);
    return 1928;
  } finally {}
}
