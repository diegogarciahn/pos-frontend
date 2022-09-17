import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_frontend/models/sucursal.model.dart';
import 'package:soft_frontend/providers/sucursal.provider.dart';
import 'package:soft_frontend/services/sucursal.service.dart';

import '../constans.dart';
import '../globals/globals.components.dart';
import '../services/sharepreference.service.dart';

Future<String> esperarToken(BuildContext context) async {
  final token = await getToken().catchError((error) {
    Navigator.pushReplacementNamed(context, 'login');
    const snackBar = SnackBar(
      content: Text('Por favor inicie sesión para acceder al sistema.'),
      backgroundColor: Colors.red,
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
    return '';
  });
  return token;
}

Future obtenerSucursalesController(context) async {
  SucursalProvider sucursalProvider =
      Provider.of<SucursalProvider>(context, listen: false);
  final token = await esperarToken(context);
  if (token != '') {
    final respuesta = await getSucursales(token);
    if (respuesta is List<DetalleSucursal>) {
      sucursalProvider.setListSucursales(respuesta);
    } else if (respuesta == 500) {
      alertError(context,
          mensaje:
              'Ocurrió un error interno en el servidor al traer todas las sucursales, póngase en contacto con soporte técnico.');
    } else if (respuesta == 1928) {
      alertError(context,
          mensaje:
              'Ocurrió un error al momento de realizar esta acción, recarge la página o póngase en contacto con soporte técnico.');
    } else if (respuesta == 401) {
      Navigator.pushReplacementNamed(context, 'login');
      const snackBar = SnackBar(
        content: Text('Por favor inicie sesión para realizar esta acción.'),
        backgroundColor: Colors.red,
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }
}
