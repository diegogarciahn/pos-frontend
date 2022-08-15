import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:soft_frontend/models/manipularVenta.model.dart';
import 'package:soft_frontend/models/ventaBuscada.model.dart';

import '../constans.dart';

Future<List<MostrarVenta>> traerVentas() async {
  List<MostrarVenta> PagoVacio = [];
  try {
    var response = await http
        .get(Uri.parse(API_URL + 'mostrarventas'))
        .timeout(Duration(seconds: 15));
    if (response.statusCode == 200) {
      final ventas = manipularVentaFromJson(response.body);
      print(ventas);

      return ventas.ventaA;
    } else {
      return PagoVacio;
    }
  } catch (e) {
    return PagoVacio;
  }
}
