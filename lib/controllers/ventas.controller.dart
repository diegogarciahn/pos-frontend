import 'dart:convert';
import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/controllers/user.controller.dart';
import 'package:soft_frontend/models/IdVenta.model.dart';
import 'package:soft_frontend/models/ProductoBuscado.model.dart';
import 'package:soft_frontend/models/cliente.model.dart';
import 'package:soft_frontend/models/ventaBuscada.model.dart';
import 'package:soft_frontend/screens/login/login.screen.dart';
import 'package:soft_frontend/services/cliente.service.dart';
import 'package:soft_frontend/services/sharepreference.service.dart';
import '../models/ventas.model.dart';
import '../services/ventas.service.dart';

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

Future<String> expectUser(BuildContext context) async {
  final idUser = await usercontroller().catchError((error) {
    return '';
  });
  if (idUser != '') {
    return idUser.id.toString();
  } else {
    return '';
  }
}

Future<bool> expectlog(BuildContext context) async {
  final login = await logeado().catchError((error) {
    return true;
  });
  if (login == false) {
    return false;
  } else {
    return true;
  }
}

Future<String> expectIdSesion(BuildContext context) async {
  final idUser = await usercontroller().catchError((error) {
    return '';
  });
  if (idUser != '') {
    return idUser.sesion.id.toString();
  } else {
    return '';
  }
}

Future crearVenta_Controller(
    String totalIsv,
    String totalVenta,
    String totalDescuentoVenta,
    String puntoDeEmision,
    String establecimiento,
    String tipo,
    String idSesion,
    String idUsuario,
    String idCliente,
    context) async {
  final token = await expectToken(context);
  if (token != '') {
    if (totalIsv.isNotEmpty &&
        totalVenta.isNotEmpty &&
        totalDescuentoVenta.isNotEmpty &&
        puntoDeEmision.isNotEmpty &&
        establecimiento.isNotEmpty &&
        tipo.isNotEmpty &&
        idSesion.isNotEmpty &&
        idUsuario.isNotEmpty &&
        idCliente.isNotEmpty) {
      final ventas = await crearVenta(
          totalIsv,
          totalVenta,
          totalDescuentoVenta,
          puntoDeEmision,
          establecimiento,
          tipo,
          idSesion,
          idUsuario,
          idCliente,
          token);
      print(ventas);
      if (ventas is IdVenta) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Venta creada con exito')));
        return ventas;
      } else if (ventas == 500) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Ocurrió un error en el servidor al crear la venta, comuniquese con el administrador.')));
        return 500;
      } else if (ventas == 1928) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Ocurrió un error al crear la venta, póngase en contacto con el administrador.')));
        return 1928;
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Campos en blanco')));
      return 1928;
    }
  }
}

// Controlador para crear una nueva venta
Future habilitarVenta(
    TextEditingController dniController,
    TextEditingController nombreController,
    TextEditingController telefonoController,
    context) async {
  // Buscar cliente en la base de datos.
  if (dniController.text.isNotEmpty) {
    final response =
        await buscarClienteVenta(dniController.text.trim(), context);
    if (response is TodoslosCliente) {
      final venta = await crearVenta_Controller(
          '0.0',
          '0.0',
          '0.0',
          '000',
          '001',
          '01',
          await expectIdSesion(context),
          await expectUser(context),
          response.id.toString(),
          context);
      if (venta is IdVenta) {
        nombreController.text = response.nombreCliente;
        telefonoController.text = response.telefonoCliente;
        return venta;
      } else {
        return false;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'No se encontró el cliente con el DNI: ${dniController.text}, por favor verifique la identidad del cliente o creelo en la base de datos.')));
      return false;
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'No se permiten campos vacíos, por favor ingrese un número de DNI.')));
    return false;
  }
}

Future<Ventas?> eliminarVenta_Controller(String id, context) async {
  final token = await expectToken(context);
  List<Ventas?> venta = await eliminarVenta(id, token);
  print(id);
  if (venta != null) {
    Navigator.pop(context);
    Navigator.restorablePopAndPushNamed(context, 'ventas');

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Venta eliminada con exito")));
  } else {}
}

Future listarVentas_Controller(context) async {
  final token = await expectToken(context);
  if (token != '') {
    final response = await mostrarVentasDetalladas(token);
    if (response is VentaBuscada) {
      return response;
    } else if (response == 200) {
      return 200;
    } else if (response == 404) {
      return 404;
    }
  }
}
