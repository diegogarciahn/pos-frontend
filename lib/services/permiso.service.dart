import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft_frontend/models/models.dart';
import 'package:soft_frontend/models/permisos.model.dart';
import 'dart:convert';
import 'dart:developer';
import '../models/permiso.model.dart';
import 'package:soft_frontend/constans.dart';

Future<Permiso?> crearPermiso(String permiso, String descripcion) async {
  var client = http.Client();
  Permiso? permisos = null;
  try {
    var response = await client.post(Uri.parse(API_URL + "permiso/create"),
        body: {'permiso': permiso, 'descripcion': descripcion});

    if (response.statusCode == 200) {
      Permiso permisos = Permiso.fromJson(json.decode(response.body));
      log(permisos.toString());
      return permisos;
    } else {
      return permisos;
    }
  } finally {
    client.close();
  }
}

// Servicio para optener los permisos
Future getPermisos() async {
  List<Permiso> talonarios = [];
  try {
    var response = await http.get(Uri.parse(API_URL + "permisos/buscapermiso"));
    print(response.request);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print(response.body);
      Permisos decode = Permisos.fromJson(response.body);
      return decode;
    } else {
      // print(response.statusCode);
      return talonarios;
    }
  } catch (e) {
    // print(e);
    return talonarios;
  }
}

