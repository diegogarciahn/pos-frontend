import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:soft_frontend/providers/tipoproducto.provider.dart';

import '../constans.dart';

import 'package:soft_frontend/models/Tipoproducto.model.dart';

import '../screens/tipoproducto/components/ventanaerrortipoproducto.component.dart';
import '../screens/tipoproducto/components/ventanaexitotipoproducto.component.dart';

import '../services/sharepreference.service.dart';
import '../services/tipoproducto.service.dart';

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

Future obtenerTipoDeProductosController(context) async {
  TipoProductoProvider tipoProductoProvider =
      Provider.of<TipoProductoProvider>(context, listen: false);
  final token = await esperarToken(context);
  if (token.isNotEmpty) {
    final respuesta = await obtenerTipos(token);
    if (respuesta is List<Tipoproducto>) {
      tipoProductoProvider.setListTipoProducto(respuesta);
    } else if (respuesta == 500) {
      ventanaError(context,
          mensaje:
              'Ocurrió un error interno del servidor, comuniquese con el administrador.');
    } else if (respuesta == 409) {
      Navigator.pushReplacementNamed(context, 'login');
      const snackBar = SnackBar(
        content: Text('Por favor inicie sesión para acceder al sistema.'),
        backgroundColor: Colors.red,
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    } else if (respuesta == 1928) {
      ventanaError(context);
    }
  }
}

Future crearTipoProductoController(String tipoproducto2,
    String descripcionProducto, String isvTipoProducto, context) async {
  final token = await esperarToken(context);
  if (token != '') {
    if (tipoproducto2.isNotEmpty &&
        descripcionProducto.isNotEmpty &&
        isvTipoProducto.isNotEmpty) {
      final respuesta = await crearTipoProductoService(
          tipoproducto2, descripcionProducto, isvTipoProducto, token);
      if (respuesta == 200) {
        ventanaExito(context, mensaje: 'Tipo de producto creado con éxito');
        obtenerTipoDeProductosController(context);
      } else if (respuesta == 500) {
        ventanaError(context,
            mensaje:
                'Ocurrió un error interno en el servidor, comuniquese con el administrador.');
      } else if (respuesta == 1928) {
        ventanaError(context,
            mensaje:
                'Ocurrió un error al realizar esta acción, comuniquese con el administrador.');
      } else if (respuesta == 401) {
        Navigator.pushReplacementNamed(context, 'login');
        const snackBar = SnackBar(
          content:
              Text('Por favor inicie sesión para poder realizar esta acción.'),
          backgroundColor: Colors.red,
        );
        snackbarKey.currentState?.showSnackBar(snackBar);
      }
    } else {
      ventanaError(context, mensaje: 'Por favor complete todos los campos.');
    }
  }
}

Future actualizarTipoProductoController(
    String id,
    String tipoproducto2,
    String descripcionProducto,
    String isvTipoProducto,
    context) async {
  if (id.isNotEmpty &&
      tipoproducto2.isNotEmpty &&
      descripcionProducto.isNotEmpty &&
      isvTipoProducto.isNotEmpty) {
    final token = await esperarToken(context);
    final respuesta = await actualizarTipoProducto(
        id, tipoproducto2, descripcionProducto, isvTipoProducto, token);
    if (respuesta == 200) {
      ventanaExito(context);
      obtenerTipoDeProductosController(context);
    } else if (respuesta == 404) {
      ventanaError(context, mensaje: 'El archivo al que usted está haciendo referencia fue removido o no se encuentra disponible.');
    } else if (respuesta == 500) {
      ventanaError(context, mensaje: 'Ocurrió un error interno en el servidor, comuniquese con el administrador.');
    } else if (respuesta == 1928) {
      ventanaError(context);
    }
  } else {
    ventanaError(context);
  }
}

Future eliminarTipoProductoController(context, String idTipoProducto) async{
  final token = await esperarToken(context);
  final respuesta = await eliminarTipoProductoService(idTipoProducto, token);
  if (respuesta == 200) {
        ventanaExito(context, mensaje: 'Tipo de producto eliminado con éxito');
        obtenerTipoDeProductosController(context);
      } else if (respuesta == 500) {
        ventanaError(context,
            mensaje:
                'Ocurrió un error interno en el servidor, comuniquese con el administrador.');
      } else if (respuesta == 1928) {
        ventanaError(context,
            mensaje:
                'Ocurrió un error al realizar esta acción, comuniquese con el administrador.');
      } else if (respuesta == 401) {
        Navigator.pushReplacementNamed(context, 'login');
        const snackBar = SnackBar(
          content:
              Text('Por favor inicie sesión para poder realizar esta acción.'),
          backgroundColor: Colors.red,
        );
        snackbarKey.currentState?.showSnackBar(snackBar);
      }
}
