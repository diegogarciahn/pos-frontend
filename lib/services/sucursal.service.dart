import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soft_frontend/models/sucursal.model.dart';

import '../constans.dart';

Future<Sucursal> getSucursal(idSucursal) async {
  Sucursal resp = Sucursal(
      sucursal: DetalleSucursal(
          nombreSucursal: '',
          lemaSucursal: '',
          idSucursal: 0,
          direccion: '',
          telefono: '',
          email: '',
          rtn: '',
          logo: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()));
  try {
    var response = await http.post(Uri.parse(API_URL + "sucursales/get"),
        body: ({'idSucursal': idSucursal.toString()}));
    print(response.body);
    if (response.statusCode == 200) {
      final decode = Sucursal.fromJson(response.body);
      print(decode);
      resp.sucursal = decode.sucursal;

      return resp;
    } else {
      print('b');
      return resp;
    }
  } catch (e) {
    return resp;
  }
}

Future<List<DetalleSucursal>> getSucursales() async {
  List<DetalleSucursal> sucursales = [];
  try {
    var response = await http.get(
      Uri.parse(API_URL + "sucursales/getAll"),
    );

    if (response.statusCode == 200) {
      final decode = Sucursales.fromJson(response.body);
      print(decode.sucursales);
      sucursales = decode.sucursales;

      return sucursales;
    } else {
      return sucursales;
    }
  } catch (e) {
    return sucursales;
  }
}

Future<String> updateSucursal(
    idSucursal, nombre, lema, direccion, telefono, email, rtn, logo) async {
  String resp = '';
  try {
    var response = await http.post(Uri.parse(API_URL + "sucursales/update"),
        body: ({
          'idSucursal': idSucursal.toString(),
          'nombreSucursal': nombre,
          'lemaSucursal': lema,
          'direccion': direccion,
          'telefono': telefono,
          'email': email,
          'rtn': rtn,
          'logo': logo
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return resp = 'Guardado con éxito.';
    } else {
      print('b');
      return resp = 'Error.';
    }
  } catch (e) {
    return resp = 'Error.';
  }
}
