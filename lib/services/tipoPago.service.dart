import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:soft_frontend/models/manipularTipoPago.dart';
import 'package:soft_frontend/models/tipoPago.model.dart';
import 'package:soft_frontend/models/unPagoBuscado.model.dart';
import '../constans.dart';

Future<List<Tipopago?>> CrearTipoPago(String tipoDePago,
    String descripcionTipoPago, String token, context) async {
  var tipopag = http.Client();
  Tipopago? tipopago = null;
  List<Tipopago?> tipopagoCreado = [];
  try {
    var response = await http.post(Uri.parse(API_URL + 'gene/insertartipopago'),
        body: ({
          'tipoDePago': tipoDePago,
          'descripcionTipoPago': descripcionTipoPago,
          'token': token
        }));
    print(response.body);
    if (response.statusCode == 200) {
      print(Tipopago);
    } else {}
    return tipopagoCreado;
  } catch (e) {
    return tipopagoCreado;
  } finally {
    http.Client().close();
  }
}

Future<List<TipoPago?>> EliminarTipoPago(
    String idTipoPago, String token, context) async {
  print(idTipoPago);
  var tipo = http.Client();
  TipoPago? tipopag = null;
  List<TipoPago?> tipoPagoCreado = [];
  try {
    var response = await http.post(Uri.parse(API_URL + 'gene/eliminartipopago'),
        body: ({'idTipoPago': idTipoPago, 'token': token}));
    print(response.body);
    if (response.statusCode == 200) {
      print(TipoPago);
    } else {
      //
    }
    return tipoPagoCreado;
  } catch (e) {
    print(e);
    return tipoPagoCreado;
  } finally {
    http.Client().close();
  }
}

Future<List<TipoPago?>> actualizarTipoPago(String idTipoPago, String tipoDePago,
    String descripcionTipoPago, String token, context) async {
  var client = http.Client();
  TipoPago? tipopago = null;
  List<TipoPago?> tipoPagoCreado = [];
  try {
    var response =
        await http.post(Uri.parse(API_URL + 'gene/actualizartipopago'),
            body: ({
              'idTipoPago': idTipoPago,
              'tipoDePago': tipoDePago,
              'descripcionTipoPago': descripcionTipoPago,
              'token': token
            }));
    print(response.body);
    if (response.statusCode == 200) {
      print(TipoPago);
    } else {
      //
    }
    return tipoPagoCreado;
  } catch (e) {
    return tipoPagoCreado;
  } finally {
    http.Client().close();
  }
}

Future traerPago() async {
  try {
    var response = await http
        .get(Uri.parse(API_URL + 'gene/buscartipopago'))
        .timeout(Duration(seconds: 15));

    switch (response.statusCode) {
      case 200:
        final tipopagos = manipularTipoPagoFromJson(response.body);
        return tipopagos.tipoPago;
      case 401:
        return 401;
      case 500:
        return 500;
    }
  } on http.ClientException catch (_) {
    print('Servicio no disponible.');
    return 503;
  } on TimeoutException catch (_) {
    throw ('Tiempo de espera alcanzado');
  } catch (e) {
    print(e);
    return 1928;
  }
}

/*
Future<void> EliminarTipoPago(String idTipoPago, context) async {
  var response = await http.post(Uri.parse(API_URL + "gene/eliminartipopago"),
      body: ({
        'idTipoPago': idTipoPago,
      }));

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Tipo de Pago Eliminado")));
  }
}


Future<void> EditarTipoPago(String idTipoPago, String tipoDePago,
    String descripcionTipoPago, context) async {
  var response = await http.post(Uri.parse(API_URL + "gene/actualizartipopago"),
      body: ({
        'idTipoPago': idTipoPago,
        'tipoDePago': tipoDePago,
        'descripcionTipoPago': descripcionTipoPago,
      }));

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tipo de Pago Actualizado")));
  }
}*/