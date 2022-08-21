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
    var response = await http.post(Uri.parse(API_URL + 'sucursales/get'),
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

Future getSucursales(String token) async {
  try {
    var response = await http.post(
      Uri.parse(API_URL + 'sucursales/getAll'),
      body: {'token': token}
    );

    if (response.statusCode == 200) {
      List<DetalleSucursal> sucursales = [];
      final decode = Sucursales.fromJson(response.body);
      sucursales = decode.sucursales;
      return sucursales;
    } else if (response.statusCode == 500){
      return 500;
    } else if (response.statusCode == 401) {
      return 401;
    }
  } catch (e) {
    print(e);
    return 1928;
  }
}

Future<String> updateSucursal(
    idSucursal, nombre, lema, direccion, telefono, email, rtn, logo) async {
  String resp = '';
  try {
    var response = await http.post(Uri.parse(API_URL + 'sucursales/update'),
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
