import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_frontend/models/talonario.model.dart';
import 'package:soft_frontend/providers/talonarios.provider.dart';
import 'package:soft_frontend/screens/globals.components/alertaexito.component.dart';
import 'package:soft_frontend/screens/globals.components/alertdialogerror.component.dart';
import 'package:soft_frontend/services/talonarios.service.dart';

import '../constans.dart';
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

Future crearTalonarioController(
    String rangoInicialController,
    String rangoFinalController,
    String caiController,
    String sucursalController,
    String fechaLimiteEController,
    context) async {
  final token = await esperarToken(context);
  if (rangoInicialController.isNotEmpty |
      rangoFinalController.isNotEmpty |
      caiController.isNotEmpty |
      sucursalController.isNotEmpty |
      fechaLimiteEController.isNotEmpty) {
    final respuesta = await createTalonario(
        rangoInicialController,
        rangoFinalController,
        caiController,
        sucursalController,
        fechaLimiteEController,
        token);
    if (respuesta == 200) {
      obtenerTalonariosController(context);
      Navigator.pop(context);
      alertaExito(context, mensaje: 'Talonario creado con éxito');
    } else if (respuesta == 500) {
      alertError(context,
          mensaje:
              'Ocurrió un error interno en el servidor, póngase en contacto con soporte técnico.');
    } else if (respuesta == 1928) {
      alertError(context,
          mensaje:
              'Ocurrió un error al momento de realizar esta acción, recarge la página o póngase en contacto con soporte técnico.');
    } else if (respuesta == 401) {
      Navigator.pushReplacementNamed(context, 'login');
      const snackBar = SnackBar(
        content: Text('Por favor inicie sesión para acceder al sistema.'),
        backgroundColor: Colors.red,
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  } else {
    alertError(context, mensaje: 'Por favor complete todos los campos.');
  }
}

Future actualizarTalonariosController(
    String idTalonario,
    String rangoInicialController,
    String rangoFinalController,
    String caiController,
    String fechaLimiteEController,
    context) async {
  final token = await esperarToken(context);
  if (token != '') {
    final respuesta = await updateTalonario(idTalonario, rangoInicialController,
        rangoFinalController, caiController, fechaLimiteEController, token);
    if (respuesta == 200) {
      obtenerTalonariosController(context);
      Navigator.pop(context);
      alertaExito(context, mensaje: 'Talonario actualizado con éxito');
    } else if (respuesta == 500) {
      alertError(context,
          mensaje:
              'Ocurrió un error interno en el servidor, póngase en contacto con soporte técnico.');
    } else if (respuesta == 1928) {
      alertError(context,
          mensaje:
              'Ocurrió un error al momento de realizar esta acción, recarge la página o póngase en contacto con soporte técnico.');
    } else if (respuesta == 401) {
      Navigator.pushReplacementNamed(context, 'login');
      const snackBar = SnackBar(
        content: Text('Por favor inicie sesión para acceder al sistema.'),
        backgroundColor: Colors.red,
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }
}

Future obtenerTalonariosController(context) async {
  TalonariosProvider talonariosProvider =
      Provider.of<TalonariosProvider>(context, listen: false);
  final token = await esperarToken(context);
  if (token != '') {
    final respuesta = await getTalonarios(token);
    if (respuesta is List<Talonario>) {
      talonariosProvider.setListTalonarios(respuesta);
    } else if (respuesta == 401) {
      Navigator.pushReplacementNamed(context, 'login');
      const snackBar = SnackBar(
        content: Text('Por favor inicie sesión para acceder al sistema.'),
        backgroundColor: Colors.red,
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    } else if (respuesta == 500) {
      alertError(context,
          mensaje:
              'Ocurrió un error interno en el servidor al momento de traer los talonarios, comuniquese con el administrador.');
    }
  }
}

Future eliminarTalonarioController(idTalonario, context) async {
  final token = await esperarToken(context);
  if (token != '') {
    final respuesta = await deleteTalonario(idTalonario, token);
    if (respuesta == 200) {
      alertaExito(context, mensaje: 'Talonario eliminado con éxito.');
      obtenerTalonariosController(context);
    } else if (respuesta == 404) {
      alertError(context,
          mensaje: 'El talonario seleccionado fue removido o no existe.');
    } else if (respuesta == 500) {
      alertError(context,
          mensaje:
              'Ocurrio un error interno en el servidor, comuniquese con soporte técnico.');
    } else if (respuesta == 1928) {
      alertError(context,
          mensaje:
              'Ocurrió un error al momento de realizar esta acción, recarge la página o póngase en contacto con soporte técnico.');
    } else if (respuesta == 401) {
      Navigator.pushReplacementNamed(context, 'login');
      const snackBar = SnackBar(
        content: Text('Por favor inicie sesión para acceder al sistema.'),
        backgroundColor: Colors.red,
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }
}

Future cambiarEstadoTalonarioController(
    String idTalonario, int tipoOperacion, context) async {
  final token = await esperarToken(context);
  late int respuesta;
  if (tipoOperacion == 1) {
    respuesta = await activateTalonario(idTalonario, token);
  } else {
    respuesta = await disactivateTalonario(idTalonario, token);
  }
  if (respuesta == 200) {
    alertaExito(context,
        mensaje: 'Estado del talonario actualizado con éxito.');
    obtenerTalonariosController(context);
  } else if (respuesta == 404) {
    alertError(context,
        mensaje: 'El talonario seleccionado fue removido o no existe.');
  } else if (respuesta == 500) {
    alertError(context,
        mensaje:
            'Ocurrio un error interno en el servidor, comuniquese con soporte técnico.');
  } else if (respuesta == 1928) {
    alertError(context,
        mensaje:
            'Ocurrió un error al momento de realizar esta acción, recarge la página o póngase en contacto con soporte técnico.');
  } else if (respuesta == 401) {
    Navigator.pushReplacementNamed(context, 'login');
    const snackBar = SnackBar(
      content: Text('Por favor inicie sesión para acceder al sistema.'),
      backgroundColor: Colors.red,
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
  }
}
