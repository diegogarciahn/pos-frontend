import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_frontend/models/tipoPago.model.dart';
import 'package:soft_frontend/models/tipoPagoBuscado.model.dart';
import 'package:soft_frontend/models/unPagoBuscado.model.dart';
import '../constans.dart';
import '../globals/globals.components.dart';
import '../providers/tipopago.provider.dart';
import '../screens/tipoPago/buscarTipoPago.screen.dart';
import '../services/sharepreference.service.dart';
import '../services/tipoPago.service.dart';

Future<String> paToken(BuildContext context) async {
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

Future traerTipoPagosController(context) async {
  TipoPagoProvider tipoPagoProvider =
      Provider.of<TipoPagoProvider>(context, listen: false);
  final token = await paToken(context);
  tipoPagoProvider.loading = true;
  if (token.isNotEmpty) {
    final respuesta = await traerPago();
    if (respuesta is List<TipoPagoBuscado>) {
      tipoPagoProvider.loading = false;
      tipoPagoProvider.setListTipoPago = respuesta;
    } else {
      switch (respuesta) {
        case 401:
          showSnackBarGlobal('Por favor inicie sesión.', context);
          Navigator.pushReplacementNamed(context, 'login');
          break;
        case 500:
          tipoPagoProvider.loading = false;
          alertError(context, mensaje: 'Ocurrió un error interno en el servidor, recargue la página o póngase en contacto con soporte técnico.');
          break;
        case 503:
          tipoPagoProvider.loading = false;
          alertError(context, mensaje: 'Ocurrió un error al momento de solicitar el servicio, recargue la página o póngase en contacto con soporte técnico.');
          break;
        case 1928:
          tipoPagoProvider.loading = false;
          alertError(context, mensaje: 'Ocurrio un error al realizar esta acción, recargue la página o póngase en contacto con soporte técnico.');
          break;
        default:
      }
    }
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
