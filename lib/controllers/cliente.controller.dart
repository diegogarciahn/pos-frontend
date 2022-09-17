import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_frontend/providers/cliente.provider.dart';
import 'package:soft_frontend/screens/globals.components/alertaexito.component.dart';
import '../constans.dart';
import '../models/cliente.model.dart';
import '../screens/globals.components/alertdialogerror.component.dart';
import '../screens/globals.components/snackBar.component.dart';
import '../services/cliente.service.dart';
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

Future traerClientesController(context) async {
  ClienteProvider clienteProvider =
      Provider.of<ClienteProvider>(context, listen: false);
  final token = await esperarToken(context);
  final respuesta = await traerClientes(token);
  if (token != '') {
    if (respuesta is List<TodoslosCliente>) {
      clienteProvider.setlistClientes = respuesta;
    } else {
      switch (respuesta) {
        case 401:
          showSnackBarGlobal('Por favor inicie sesión.', context);
          Navigator.pushReplacementNamed(context, 'login');
          break;
        case 500:
          // tipoPagoProvider.loading = false;
          alertError(context,
              mensaje:
                  'Ocurrió un error interno en el servidor, recargue la página o póngase en contacto con soporte técnico.');
          break;
        case 503:
          // tipoPagoProvider.loading = false;
          alertError(context,
              mensaje:
                  'Ocurrió un error al momento de solicitar el servicio, recargue la página o póngase en contacto con soporte técnico.');
          break;
        case 1928:
          // tipoPagoProvider.loading = false;
          alertError(context,
              mensaje:
                  'Ocurrio un error al realizar esta acción, recargue la página o póngase en contacto con soporte técnico.');
          break;
        default:
      }
    }
  }
}

Future crearClienteController(
    TextEditingController dni,
    TextEditingController email,
    TextEditingController rtn,
    TextEditingController nombreCliente,
    TextEditingController direccion,
    TextEditingController telefonoCliente,
    context) async {
  if (dni.text.isNotEmpty &&
      nombreCliente.text.isNotEmpty &&
      direccion.text.isNotEmpty &&
      telefonoCliente.text.isNotEmpty) {
    final respuesta = await crearCliente(
        dni.text, email.text, rtn.text, nombreCliente.text, direccion.text, telefonoCliente.text, context);
    switch (respuesta) {
      case 200:
        alertaExito(context, mensaje: 'Cliente creado con éxito.');
        dni.clear();
        email.clear();
        rtn.clear();
        nombreCliente.clear();
        direccion.clear();
        telefonoCliente.clear();
        traerClientesController(context);
        break;
      case 401:
        Navigator.pushReplacementNamed(context, 'login');
        showSnackBarGlobal('Por favor inicie sesión para completar esta acción.', context);
        break;
      case 503:
        alertError(context, mensaje: 'El servidor no responde, espere un momento para realizar esta acción o comuníquese con soporte técnico.');
        break;
      case 409:
        alertError(context,mensaje: 'Ya existe un cliente creado con el DNI indicado.');
        break;
      case 500:
        alertError(context, mensaje: 'Ocurrió un error interno en el servidor, comuníquese con soporte técnico.');
        break;
      case 1928:
        alertError(context);
        break;
      default:
    }
  } else {
    alertError(context, mensaje: 'Por favor complete todos las campos.');
  }
}

Future eliminarClienteController(String id, context) async {
  String token = await esperarToken(context);
  final respuesta = await eliminarCliente(id, token);
  switch (respuesta) {
    case 200:
      alertaExito(context, mensaje: 'Cliente eliminado exitósamente.');
      traerClientesController(context);
      break;
    case 401:
      showSnackBarGlobal('Por favor inicie sesión.', context);
      Navigator.pushReplacementNamed(context, 'login');
      break;
    case 500:
      // tipoPagoProvider.loading = false;
      alertError(context,
          mensaje:
              'Ocurrió un error interno en el servidor, recargue la página o póngase en contacto con soporte técnico.');
      break;
    case 503:
      // tipoPagoProvider.loading = false;
      alertError(context,
          mensaje:
              'Ocurrió un error al momento de solicitar el servicio, recargue la página o póngase en contacto con soporte técnico.');
      break;
    case 1928:
      // tipoPagoProvider.loading = false;
      alertError(context,
          mensaje:
              'Ocurrio un error al realizar esta acción, recargue la página o póngase en contacto con soporte técnico.');
      break;
    default:
  }
}

Future<Cliente?> actualizarCliente_Controller(
    String id,
    String dni,
    String email,
    String rtn,
    String nombreCliente,
    String direccion,
    String telefonoCliente,
    context) async {
  if (dni.isNotEmpty &&
      nombreCliente.isNotEmpty &&
      direccion.isNotEmpty &&
      telefonoCliente.isNotEmpty) {
    List<Cliente?> cliente = await ActualizarCliente(
        id, dni, email, rtn, nombreCliente, direccion, telefonoCliente);
    if (cliente != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente Actualizado con exito')));
      Navigator.pushNamed(context, 'traer_clientes');
    } else if (cliente == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se actualizó el Cliente!')));
    }
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Campos en blanco')));
  }
}
