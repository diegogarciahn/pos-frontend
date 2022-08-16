import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/models/errorPeticion.model.dart';
import 'package:soft_frontend/models/facturaBuscada.model.dart';
import 'package:soft_frontend/models/manipularFacturaResponse.dart';
import 'package:soft_frontend/models/mostrarUnaFactura.model.dart';
import 'package:soft_frontend/models/unaFacturaBuscada.model.dart';

// ignore: non_constant_identifier_names

Future traerFactura(String token) async {
  try {
    var response = await http
        .post(Uri.parse(API_URL + 'traerFacturas'), body: ({'token': token}))
        .timeout(Duration(seconds: 15));
    if (response.statusCode == 200) {
      final facturas = manipularFacturaResponseFromJson(response.body);
      return facturas;
    } else if (response.statusCode == 500) {
      return 500;
    } else if (response.statusCode == 403) {
      return 403;
    }
  } on TimeoutException catch (_) {
    throw ('Tiempo de espera alcanzado');
  } catch (e) {
    print(e);
    return 2;
  }
}

Future buscarFacturaPorNumero(String numeroFactura, String token) async {
  try {
    var response = await http.post(
        Uri.parse(API_URL + 'buscarfactura/?numeroFactura=$numeroFactura'),
        body: {'token': token}).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      final facturaBuscada =
          UnaFacturaBuscada.fromJson(jsonDecode(response.body));
      return facturaBuscada;
    } else if (response.statusCode == 404) {
      return response.statusCode;
    } else if (response.statusCode == 403) {
      return 403;
    }
  } catch (e) {
    print(e);
    return e;
  }
}

Future filtrarFacturasPorCliente(
    String nombre, String rtn, String dni, String token) async {
  List<FacturaBuscada> facturaVacia = [];
  String url = API_URL + 'buscarfacturaporcliente/';
  try {
    if (nombre.isNotEmpty) {
      url = url + '?nombreCliente=$nombre';
    } else if (rtn.isNotEmpty) {
      url = url + '?rtn=$rtn';
    } else if (dni.isNotEmpty) {
      url = url + '?dni=$dni';
    }
    var response = await http.post(Uri.parse(url), body: {'token': token});
    if (response.statusCode == 200) {
      final facturas = manipularFacturaResponseFromJson(response.body);
      return facturas.facturas;
    } else if (response.statusCode == 404) {
      return response.statusCode;
    } else if (response.statusCode == 400) {
      final error = mensajePeticionFromJson(response.body);
      return error;
    } else if (response.statusCode == 403) {
      return 403;
    }
    return facturaVacia;
  } catch (e) {
    print(e);
    return facturaVacia;
  }
}

Future filtrarFacturasPorFecha(
    String fecha1, String fecha2, String token) async {
  List<FacturaBuscada> facturaVacia = [];
  String url = API_URL + 'buscarfacturaporfecha/';
  try {
    if (fecha2.isNotEmpty && fecha1.isNotEmpty) {
      url = url + '?fecha1=$fecha1&fecha2=$fecha2';
    } else if (fecha1.isNotEmpty && fecha2.isEmpty) {
      url = url + '?fecha1=$fecha1';
    }
    var response = await http.post(Uri.parse(url), body: {'token': token});
    if (response.statusCode == 200) {
      final facturas = manipularFacturaResponseFromJson(response.body);
      return facturas.facturas;
    } else if (response.statusCode == 404) {
      return response.statusCode;
    } else if (response.statusCode == 400) {
      final error = mensajePeticionFromJson(response.body);
      return error;
    } else if (response.statusCode == 403) {
      return 403;
    }
    return facturaVacia;
  } catch (e) {
    print(e);
    return facturaVacia;
  }
}

Future filtrarFacturasPorTalonario(
    String cai, String token) async {
  List<FacturaBuscada> facturaVacia = [];
  String url = API_URL + 'buscarfacturaportalonario/';
  try {
    url = url + '?cai=$cai';
    var response = await http.post(Uri.parse(url), body: {'token': token});
    if (response.statusCode == 200) {
      final facturas = manipularFacturaResponseFromJson(response.body);
      return facturas.facturas;
    } else if (response.statusCode == 404) {
      return response.statusCode;
    } else if (response.statusCode == 400) {
      final error = mensajePeticionFromJson(response.body);
      return error;
    } else if (response.statusCode == 403) {
      return 403;
    }
    return facturaVacia;
  } catch (e) {
    print(e);
    return facturaVacia;
  }
}

Future filtrarFacturasPorEmpleado(String nombreEmpleado, String token) async {
  List<FacturaBuscada> facturaVacia = [];
  String url = API_URL + 'buscarfacturaporempleado/';
  try {
    url = url + '?nombre=$nombreEmpleado';
    var response = await http.post(Uri.parse(url), body: {'token': token});
    if (response.statusCode == 200) {
      final facturas = manipularFacturaResponseFromJson(response.body);
      return facturas.facturas;
    } else if (response.statusCode == 404) {
      return response.statusCode;
    } else if (response.statusCode == 400) {
      final error = mensajePeticionFromJson(response.body);
      return error;
    } else if (response.statusCode == 403) {
      return 403;
    }
    return facturaVacia;
  } catch (e) {
    print(e);
    return facturaVacia;
  }
}

Future mostrarDatosDeUnaFactura(String numeroFactura, String token) async {
  String url = API_URL+'traerunafactura/';
  if (numeroFactura.isNotEmpty) {
    url = url + '?numeroFactura=$numeroFactura';
  }
  try {
    final response = await http.post(Uri.parse(url), body: {'token': token});
    if (response.statusCode == 200) {
      final datosFactura = mostrarUnaFacturaFromJson(response.body);
      return datosFactura;
    } else if (response.statusCode == 400) {
      final error = mensajePeticionFromJson(response.body);
      return error;
    } else if (response.statusCode == 500) {
      return 'Ocurrió un error interno del servidor';
    } else if (response.statusCode == 403) {
      return 403;
    }
  } catch (e) {
    print(e);
    return 2;
  }
}

Future descargarFactura() async {
  String url = API_URL + 'descargardactura';
  try {
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {}
    return response.body;
  } catch (e) {
    print(e);
  }
}
