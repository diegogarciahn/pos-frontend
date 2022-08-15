import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soft_frontend/models/talonario.model.dart';

import '../constans.dart';

// ignore: non_constant_identifier_names

Future<List<Talonario>> getTalonarios() async {
  List<Talonario> talonarios = [];
  try {
    var response = await http.get(Uri.parse(API_URL + "talonarios/get"));
    if (response.statusCode == 200) {
      final decode = TalonariosResponse.fromJson(response.body);
      print(decode.talonarios!);
      print(decode.talonarios![0].idTalonario);
      return decode.talonarios!;
    } else {
      // print(response.statusCode);
      return talonarios;
    }
  } catch (e) {
    // print(e);
    return talonarios;
  }
}

Future<String> deleteTalonario(idTalonario) async {
  print('entra');
  String resp = "";
  try {
    var response = await http.get(
        Uri.parse(API_URL + "talonarios/delete?idTalonario=" + idTalonario));

    print(response.body);
    if (response.statusCode == 200) {
      final decode = json.decode(response.body);
      resp = decode;
    } else {
      resp = 'Error';
    }
    return resp;
  } catch (e) {
    print(e);
    return e.toString();
  }
}

Future<String> updateTalonario(idTalonario, rangoInicialController,
    rangoFinalController, caiController, fechaLimiteEController) async {
  String resp = "";
  try {
    var response = await http.post(Uri.parse(API_URL + "talonarios/update"),
        body: ({
          'idTalonario': idTalonario,
          'rangoInicialFactura': rangoInicialController,
          'rangoFinalFactura': rangoFinalController,
          'cai': caiController,
          'fechaLimiteEmision': fechaLimiteEController,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      final decode = json.decode(response.body);
      resp = decode;
    } else {
      resp = 'Error';
    }
    return resp;
  } catch (e) {
    print(e);
    return e.toString();
  }
}

Future<String> activateTalonario(idTalonario) async {
  String resp = "";
  try {
    var response = await http.post(Uri.parse(API_URL + "talonarios/activate"),
        body: ({
          'idTalonario': idTalonario,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      final decode = json.decode(response.body);
      resp = decode;
    } else {
      resp = 'Error';
    }
    return resp;
  } catch (e) {
    print(e);
    return e.toString();
  }
}

Future<String> disactivateTalonario(idTalonario) async {
  String resp = "";
  try {
    var response =
        await http.post(Uri.parse(API_URL + "talonarios/disactivate"),
            body: ({
              'idTalonario': idTalonario,
            }));
    print(response.body);
    if (response.statusCode == 200) {
      final decode = json.decode(response.body);
      resp = decode;
    } else {
      resp = 'Error';
    }
    return resp;
  } catch (e) {
    print(e);
    return e.toString();
  }
}

Future<String> createTalonario(rangoInicialController, rangoFinalController,
    caiController, sucursalController, fechaLimiteEController) async {
  String resp = "";
  try {
    var response = await http.post(Uri.parse(API_URL + "talonarios/create"),
        body: ({
          'rangoInicialFactura': rangoInicialController,
          'rangoFinalFactura': rangoFinalController,
          'cai': caiController,
          'idSucursal': sucursalController,
          'fechaLimiteEmision': fechaLimiteEController,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      final decode = json.decode(response.body);
      print(decode);
      resp = 'Creado';
    } else {
      resp = 'Error';
    }
    return resp;
  } catch (e) {
    print(e);
    return e.toString();
  }
}
