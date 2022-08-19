import 'dart:js';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soft_frontend/models/errorPeticion.model.dart';
import 'package:soft_frontend/screens/manipularFactura/components/dialogMensajeProblema.component.dart';
import '../models/Arqueo.model.dart';
import '../services/Arqueo.service.dart';
import '../services/sharepreference.service.dart';
import '../constans.dart';

typedef void ListArqueo(List<Arqueo> arqueos);

Future expectToken(BuildContext context) async {
  final token = await getToken().catchError((error) {
    return '';
  });
  if (token != '') {
    return token;
  } else {
    Navigator.pushReplacementNamed(context, 'login');
    const snackBar = SnackBar(
      content: Text('Por favor inicie sesión para acceder al sistema.'),
      backgroundColor: Colors.red,
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
  }
}

Future listarArqueos_Controller(context) async {
  final token = await expectToken(context);
  if (token != '') {
    final response = await traerArqueos(token);
    if (response is ManipularArqueo) {
      return response;
    } else if (response == 200) {
      return 200;
    } else if (response == 404) {
      return 404;
    }
  }
}

Future eliminarArqueo_Controller(String idArqueo, context) async {
  final token = await expectToken(context);
  if (token != '') {
    List<ManipularArqueo?> arq = await eliminarArqueo(idArqueo, token);
    print(idArqueo);
    if (arq != null) {
      Navigator.pushReplacementNamed(context, 'traer_arqueo');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Arqueo eliminado con exito')));
    } else {}
  }
}

Future crearArqueo_Controller(String efectivoApertura, context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('arqueoabierto', true);
  final token = await expectToken(context);
  if (token != '') {
    if (efectivoApertura.isNotEmpty) {
      List<ManipularArqueo?> arqueo =
          await crearArqueo(efectivoApertura, token);
      if (arqueo != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Arqueo Creado con exito')));
        Navigator.pushReplacementNamed(context, 'PrincipalVenta');
      } else {}
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Campos en blanco')));
    }
  }
}

Future actualizarArqueoCerrandoSesion_Controller(context) async {
  bool connectionResult = await setArqueadoCerrado();
  print(connectionResult);
  final token = await expectToken(context);
  if (token != '') {
    List<ManipularArqueo?> arqueo1 =
        await actualizarArqueoCerrandoSesion(token);
    if (arqueo1 != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Arqueo Actualizado con exito')));
      Navigator.popAndPushNamed(context, 'traer_arqueo');
    } else {}
  }
}

Future filtrarArqueoIdUsuario_Controller(
    TextEditingController _textController, ListArqueo callback, context) async {
  final token = await expectToken(context);
  if (token != '') {
    final response =
        await buscarArqueoPorIdUsuario(_textController.text.trim(), token);
    if (response is List<Arqueo>) {
      callback(response);
    } else if (response == 404) {
      dialogMensajeProblema(context,
          'No se encontró ningún resultado para Usuario con Id: ${_textController.text.trim()}');
    } else if (response is MensajePeticion) {
      MensajePeticion mensajeError = response;
      dialogMensajeProblema(context, mensajeError.msg);
    }
  }
}

Future validarArqueoActivoController(context) async {
  final token = await expectToken(context);
  if (token != '') {
    //List<ManipularArqueo?> arqueo1 = await validarArqueoActivo(token);
    final resp = await validarArqueoActivo(token);
    print(resp);
    if (!resp) {
      print('por favor cree un nuevo arqueo');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor Cree un nuevo')));
      Navigator.pushReplacementNamed(context, 'crear_arqueo');
    } else {}
  }
}
