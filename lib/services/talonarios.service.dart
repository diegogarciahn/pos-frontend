import 'package:http/http.dart' as http;
import 'package:soft_frontend/models/talonario.model.dart';

import '../constans.dart';

// ignore: non_constant_identifier_names

Future getTalonarios(String token) async {
  try {
    var response = await http
        .post(Uri.parse(API_URL + 'talonarios/get'), body: {'token': token});
    if (response.statusCode == 200) {
      final decode = TalonariosResponse.fromJson(response.body);
      return decode.talonarios!;
    } else if (response.statusCode == 500) {
      return 500;
    } else if (response.statusCode == 401) {
      return 401;
    }
  } catch (e) {
    print(e);
    return 1928;
  }
}

Future deleteTalonario(idTalonario, String token) async {
  try {
    var response = await http.post(
        Uri.parse(API_URL + 'talonarios/delete?idTalonario=' + idTalonario),
        body: {'token': token});

    print(response.body);
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 404) {
      return 404;
    } else if (response.statusCode == 401) {
      return 401;
    } else if (response.statusCode == 500) {
      return 500;
    }
  } catch (e) {
    print(e);
    return 1928;
  }
}

Future updateTalonario(idTalonario, rangoInicialController,
    rangoFinalController, caiController, fechaLimiteEController, String token) async {
  try {
    var response = await http.post(Uri.parse(API_URL + 'talonarios/update'),
        body: ({
          'idTalonario': idTalonario,
          'rangoInicialFactura': rangoInicialController,
          'rangoFinalFactura': rangoFinalController,
          'cai': caiController,
          'fechaLimiteEmision': fechaLimiteEController,
          'token': token,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 404) {
      return 404;
    } else if (response.statusCode == 401) {
      return 401;
    } else if (response.statusCode == 500) {
      return 500;
    }

  } catch (e) {
    print(e);
    return 1928;
  }
}

Future activateTalonario(idTalonario, String token) async {
  try {
    var response = await http.post(Uri.parse(API_URL + 'talonarios/activate'),
        body: ({
          'idTalonario': idTalonario,
          'token': token,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 404) {
      return 404;
    } else if (response.statusCode == 401) {
      return 401;
    } else if (response.statusCode == 500) {
      return 500;
    }
  } catch (e) {
    print(e);
    return 1928;
  }
}

Future disactivateTalonario(idTalonario, String token) async {
  try {
    var response =
        await http.post(Uri.parse(API_URL + 'talonarios/disactivate'),
            body: ({
              'idTalonario': idTalonario,
              'token': token,
            }));
    print(response.body);
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 404) {
      return 404;
    } else if (response.statusCode == 401) {
      return 401;
    } else if (response.statusCode == 500) {
      return 500;
    }
  } catch (e) {
    print(e);
    return 1928;
  }
}

Future createTalonario(rangoInicialController, rangoFinalController,
    caiController, sucursalController, fechaLimiteEController, String token) async {
  try {
    var response = await http.post(Uri.parse(API_URL + 'talonarios/create'),
        body: ({
          'rangoInicialFactura': rangoInicialController,
          'rangoFinalFactura': rangoFinalController,
          'cai': caiController,
          'idSucursal': sucursalController,
          'fechaLimiteEmision': fechaLimiteEController,
          'token': token
        }));
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 500){
      return 500;
    } else if (response.statusCode == 401){
      return 401;
    }
  } catch (e) {
    print(e);
    return 1928;
  }
}
