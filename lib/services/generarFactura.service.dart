import 'package:http/http.dart' as http;

import '../constans.dart';
import '../models/crearFactura.model.dart';

Future crearFactura(
    String idVenta, String idTipoPago, String token, context) async {
  var fact = http.Client();
  Factura? factura = null;
  List<Factura?> facturaCreada = [];
  try {
    var response = await http.post(Uri.parse(API_URL + "gene/insertfact"),
        body: ({'idVenta': idVenta, 'idTipoPago': idTipoPago, 'token': token}));
    if (response.statusCode == 200) {
      final facturaInsertada = facturaFromJson(response.body);
      return facturaInsertada;
    } else {}
    return facturaCreada;
  } catch (e) {
    return facturaCreada;
  } finally {
    http.Client().close();
  }
}
