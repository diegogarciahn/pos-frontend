import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/models/models.dart';

// ignore: non_constant_identifier_names
Future traerArqueos(String token) async {
  try {
    final response = await http
        .post(Uri.parse(API_URL + 'arqueo/mostrarArqueo'),
            body: ({'token': token}))
        .timeout(Duration(seconds: 15));
    print(response.statusCode); ///////////////
    if (response.statusCode == 200) {
      // print(response.request);
      //print(jsonDecode(response.body));
      ManipularArqueo listaArq = manipularArqueoFromJson(response.body);
      return listaArq;
    }
  } on TimeoutException catch (_) {
    throw ('Tiempo de espera alcanzado');
  } catch (e) {
    print(e);
    return 2;
  }
}

Future buscarArqueoPorIdUsuario(String idUsuario, String token) async {
  try {
    if (idUsuario.isNotEmpty) {
      var response = await http
          .post(Uri.parse(API_URL + 'arqueo/buscarPorUsuario'),
              body: ({'idUsuario': idUsuario, 'token': token}))
          .timeout(Duration(seconds: 15));
      print(response.statusCode); ///////////////
      if (response.statusCode == 200) {
        ManipularArqueo arqueo = manipularArqueoFromJson(response.body);
      }
    }
  } on TimeoutException catch (_) {
    throw ('Tiempo de espera alcanzado');
  } catch (e) {
    print(e);
    return 2;
  }
}

Future eliminarArqueo(String idArqueo, String token) async {
  print(idArqueo);
  var client = http.Client();
  ManipularArqueo? arqueo = null;
  List<ManipularArqueo> arqueoEliminado = [];
  try {
    var response = await http
        .post(Uri.parse(API_URL + 'arqueo/deleteArqueo'),
            body: ({
              'idArqueo': idArqueo,
              'token': token,
            }))
        .timeout(Duration(seconds: 15));
    print(response.statusCode); ///////////////
    if (response.statusCode == 200) {
      print(Arqueo);
    } else {}
    return arqueoEliminado;
  } on TimeoutException catch (_) {
    throw ('Tiempo de espera alcanzado');
  } catch (e) {
    print(e);
    return 2;
  } finally {
    http.Client().close();
  }
}

Future crearArqueo(String efectivoApertura, String token) async {
  var client = http.Client();
  ManipularArqueo? arqueo = null;
  List<ManipularArqueo> arqueoCreado = [];
  try {
    var response = await http
        .post(Uri.parse(API_URL + 'arqueo/createArqueo'),
            body: ({
              'efectivoApertura': efectivoApertura,
              'token': token,
            }))
        .timeout(Duration(seconds: 15));
    print(response.statusCode); ///////////////
    if (response.statusCode == 200) {
      print(ManipularArqueo);
    }
    return arqueoCreado;
  } on TimeoutException catch (_) {
    throw ('Tiempo de espera alcanzado');
  } catch (e) {
    print(e);
    return 2;
  } finally {
    http.Client().close();
  }
}

Future actualizarArqueoCerrandoSesion(String token) async {
  var client = http.Client();
  ManipularArqueo? arqueo1 = null;
  List<ManipularArqueo> arqueoActualizado = [];

  try {
    var response = await http
        .post(Uri.parse(API_URL + 'arqueo/actualizacionCerrandoSesion'),
            body: ({
              'token': token,
            }))
        .timeout(Duration(seconds: 15));
    print(response.statusCode); ///////////////
    if (response.statusCode == 200) {
      print(ManipularArqueo);
    } else {
      //return arqueoCreado;
    }
    return arqueoActualizado;
  } on TimeoutException catch (_) {
    throw ('Tiempo de espera alcanzado');
  } catch (e) {
    print(e);
    return 2;
  } finally {
    http.Client().close();
  }
}

Future validarArqueoActivo(String token) async {
  var client = http.Client();
  ManipularArqueo? arqueo1 = null;
  List<ManipularArqueo> arqueoActualizado = [];
  try {
    var response = await http
        .post(Uri.parse(API_URL + 'arqueo/validarArqueoActivo'),
            body: ({
              'token': token,
            }))
        .timeout(Duration(seconds: 15));
    print(response.statusCode); ///////////////
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      return false;
    }
    //return arqueoActualizado;
  } on TimeoutException catch (_) {
    throw ('Tiempo de espera alcanzado');
  } catch (e) {
    print(e);
    return 2;
  } finally {
    http.Client().close();
  }
}
