import 'package:flutter/material.dart';
import 'package:soft_frontend/models/tipoPago.model.dart';
import 'package:soft_frontend/models/unPagoBuscado.model.dart';
import 'package:soft_frontend/screens/tipoPago/editarTipoPago.screen.dart';
import '../constans.dart';
import '../screens/tipoPago/buscarTipoPago.screen.dart';
import '../services/sharepreference.service.dart';
import '../services/tipoPago.service.dart';

Future paToken(BuildContext context) async {
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

//Controlador para xrear un nuevo tipo de pagoo
Future<TipoPago?> crearTipoPago_Controller(
    String tipoDePago, String descripcionTipoPago, context) async {
  final token = await paToken(context);
  if (token != '') {
    if (tipoDePago.isNotEmpty && descripcionTipoPago.isNotEmpty) {
      List<Tipopago?> tipopago =
          await CrearTipoPago(tipoDePago, descripcionTipoPago, token, context);
      if (tipopago != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Nuevo Tipo de pago añadido con exito")));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuscarTipoPago(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Hubo un problema")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Campos en blanco")));
    }
  }
}

Future<TipoPago?> actualizarTipoPago_Controller(String idTipoPago,
    String tipoDePago, String descripcionTipoPago, context) async {
  final token = await paToken(context);
  if (token != '') {
    if (idTipoPago.isNotEmpty &&
        tipoDePago.isNotEmpty &&
        descripcionTipoPago.isNotEmpty) {
      List<TipoPago?> tipopago = await actualizarTipoPago(
          idTipoPago, tipoDePago, descripcionTipoPago, token, context);
      if (tipopago != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Tipo de pago Actualizado con exito")));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuscarTipoPago(),
          ),
        );
      } else if (tipopago == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se actualizó el tipo de pago!')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Campos en blanco")));
    }
  }
}

Future<TipoPago?> eliminarTipoPago_Controller(
    String idTipoPago, context) async {
  final token = await paToken(context);
  if (token != '') {
    List<TipoPago?> tipopago =
        await EliminarTipoPago(idTipoPago, token, context);
    print(idTipoPago);
    if (tipopago != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tipo Pago eliminado con exito")));
    } else {}
  }
}
