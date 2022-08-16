import 'package:flutter/material.dart';
import 'package:soft_frontend/models/mostrarUnaFactura.model.dart';
import 'package:soft_frontend/services/sharepreference.service.dart';

import '../constans.dart';
import '../models/models.dart';
import '../models/unaFacturaBuscada.model.dart';
import '../screens/manipularFactura/components/dialogMensajeProblema.component.dart';
import '../screens/manipularFactura/components/dialogVerFactura.component.dart';
import '../screens/mostrarUnaFactura/mostrarunafactura.screen.dart';
import '../services/manipularfactura.service.dart';

typedef void ListFactura(List<FacturaBuscada> facturasBuscadas);
final numerico = RegExp(r'^[0-9]+$');
final validarFecha = RegExp(r'^[0-9]{4}-[0-9]{2}-[0-9]{2}$');
var tokenConfirmado = '';

Future esperarToken(BuildContext context) async {
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

Future listarFacturas(context) async {
  final token = await esperarToken(context);
  if (token != '') {
    final response = await traerFactura(token);
    if (response is ManipularFacturaResponse) {
      return response;
    } else if (response == 2) {
      return 2;
    } else if (response == 500) {
      return 500;
    } else if (response == 403) {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}

Future filtrarFacturasPorNombreCliente(
    TextEditingController controller, ListFactura callback, context) async {
  final token = await esperarToken(context);
  if (token != '') {
    final response =
        await filtrarFacturasPorCliente(controller.text.trim(), '', '', token);
    if (response is List<FacturaBuscada>) {
      callback(response);
    } else if (response == 404) {
      dialogMensajeProblema(context,
          'No se encontró ningúna factura para el cliente: ${controller.text.trim()}');
    } else if (response == 403) {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}

Future filtrarFacturasPorRTNCliente(TextEditingController _textController,
    ListFactura callback, context) async {
  final token = await esperarToken(context);
  if (token != '') {
    if (numerico.hasMatch(_textController.text.trim())) {
      final response = await filtrarFacturasPorCliente(
          '', _textController.text.trim(), '', token);
      if (response is List<FacturaBuscada>) {
        callback(response);
      } else if (response == 404) {
        dialogMensajeProblema(context,
            'No se encontró ningún resultado para la factura con RTN: ${_textController.text.trim()}');
      } else if (response is MensajePeticion) {
        MensajePeticion mensajeError = response;
        dialogMensajeProblema(context, mensajeError.msg);
      } else if (response == 403) {
        Navigator.pushReplacementNamed(context, 'login');
      }
    } else {
      dialogMensajeProblema(context,
          'El RTN debe ser numérico, no debe contener números y letras.');
      _textController.clear();
    }
  }
}

Future filtrarFacturasPorDNICliente(TextEditingController _textController,
    ListFactura callback, context) async {
  final token = await esperarToken(context);
  if (token != '') {
    if (numerico.hasMatch(_textController.text.trim())) {
      final response = await filtrarFacturasPorCliente(
          '', '', _textController.text.trim(), token);
      if (response is List<FacturaBuscada>) {
        callback(response);
      } else if (response == 404) {
        dialogMensajeProblema(context,
            'No se encontró ningún resultado para facturas con DNI: ${_textController.text.trim()}');
      } else if (response is MensajePeticion) {
        MensajePeticion mensajeError = response;
        dialogMensajeProblema(context, mensajeError.msg);
      } else if (response == 403) {
        Navigator.pushReplacementNamed(context, 'login');
      }
    } else {
      dialogMensajeProblema(context,
          'El DNI debe ser numérico, no debe contener números y letras.');
      _textController.clear();
    }
  }
}

Future filtrarFacturasPorFechaController(
    TextEditingController _textController,
    TextEditingController _textController2,
    ListFactura callback,
    context) async {
  final token = await esperarToken(context);
  if (token != '') {
    if (_textController2.text.isEmpty) {
      if (validarFecha.hasMatch(_textController.text.trim())) {
        final response = await filtrarFacturasPorFecha(
            _textController.text.trim(), '', token);
        if (response is List<FacturaBuscada>) {
          callback(response);
        } else if (response == 404) {
          dialogMensajeProblema(context,
              'No se encontró ningúna factura el día: ${_textController.text.trim()}');
        } else if (response is MensajePeticion) {
          MensajePeticion mensajeError = response;
          dialogMensajeProblema(context, mensajeError.msg);
        } else if (response == 403) {
          Navigator.pushReplacementNamed(context, 'login');
        }
      } else {
        dialogMensajeProblema(context,
            'La fecha debe ser de formato YYYY-MM-DD donde: YYYY representa el año, MM el mes y DD el día.');
        _textController.clear();
      }
      // Si ambos campos tienen datos
    } else {
      if (validarFecha.hasMatch(_textController.text.trim()) &&
          validarFecha.hasMatch(_textController2.text.trim())) {
        final response = await filtrarFacturasPorFecha(
            _textController.text.trim(), _textController2.text.trim(), token);
        if (response is List<FacturaBuscada>) {
          callback(response);
        } else if (response == 404) {
          dialogMensajeProblema(context,
              'No se encontró ningúna factura el ${_textController.text.trim()} y el ${_textController2.text.trim()}');
        } else if (response is MensajePeticion) {
          MensajePeticion mensajeError = response;
          dialogMensajeProblema(context, mensajeError.msg);
        } else if (response == 403) {
          Navigator.pushReplacementNamed(context, 'login');
        }
      } else {
        dialogMensajeProblema(context,
            'La fecha debe ser de formato YYYY-MM-DD donde: YYYY representa el año, MM el mes y DD el día.');
        _textController.clear();
        _textController2.clear();
      }
    }
  }
}

Future filtrarFacturasPorCAI(TextEditingController _textController,
    ListFactura callback, context) async {
  final token = await esperarToken(context);
  if (token != '') {
    final response = await filtrarFacturasPorTalonario(
        _textController.text.trim(), token);
    if (response is List<FacturaBuscada>) {
      callback(response);
      // Si no encontró ningúna coincidencia.
    } else if (response == 404) {
      dialogMensajeProblema(context,
          'No se encontró ningúna factura con el cai de talonario: ${_textController.text.trim()}');
    } else if (response is MensajePeticion) {
      MensajePeticion mensajeError = response;
      dialogMensajeProblema(context, mensajeError.msg);
    } else if (response == 403) {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}

Future filtrarFacturasPorNombreEmpleado(TextEditingController _textController,
    ListFactura callback, context) async {
  final token = await esperarToken(context);
  if (token != '') {
    final response =
        await filtrarFacturasPorEmpleado(_textController.text.trim(), token);
    if (response is List<FacturaBuscada>) {
      callback(response);
    } else if (response == 404) {
      dialogMensajeProblema(context,
          'No se encontró ningúna factura para el empleado: ${_textController.text.trim()}');
    } else if (response is MensajePeticion) {
      MensajePeticion mensajeError =
          await filtrarFacturasPorEmpleado(_textController.text.trim(), token);
      dialogMensajeProblema(context, mensajeError.msg);
    } else if (response == 403) {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}

Future buscarFacturaPorNumeroFact(
    TextEditingController _textController, Size size, context) async {
  final token = await esperarToken(context);
  if (token != '') {
    final response =
        await buscarFacturaPorNumero(_textController.text.trim(), token);
    if (response is UnaFacturaBuscada) {
      UnaFacturaBuscada facturaBuscada = response;
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Resultado de la búsqueda'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    textAlertDialogFactura(
                        'Número de factura',
                        'Fecha de emisión',
                        'Empleado',
                        facturaBuscada.unafactura.numeroFactura.toString(),
                        facturaBuscada.unafactura.fechaFactura.toString(),
                        facturaBuscada.unafactura.empleado!.nombre.toString() +
                            ' ' +
                            facturaBuscada.unafactura.empleado!.apellido
                                .toString()),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    textAlertDialogFactura(
                        'Nombre de cliente',
                        'RTN',
                        'CAI',
                        facturaBuscada.unafactura.cliente!.nombreCliente
                            .toString(),
                        facturaBuscada.unafactura.cliente!.rtn.toString(),
                        facturaBuscada.unafactura.talonario!.cai.toString()),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    textAlertDialogFactura('Total de factura', '', '',
                        facturaBuscada.unafactura.totalFactura, '', ''),
                  ],
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MostrarFactura(
                                    numeroFactura: facturaBuscada
                                        .unafactura.numeroFactura)));
                      },
                      child: Text('Ver factura')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cerrar')),
                ],
              ));
    } else if (response == 404) {
      dialogMensajeProblema(context,
          'No se encontró ningún resultado para la factura con número: ${_textController.text.trim()}');
    } else if (response == 403) {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}

Future mostrarDatosDeUnaFacturaController(String numeroFactura, context) async {
  final token = await esperarToken(context);
  if (token != '') {
    final response = await mostrarDatosDeUnaFactura(numeroFactura, token);
    if (response is MostrarUnaFactura) {
      return response;
    } else if (response == 403) {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}


class Totales {
  double totalFactura = 0.00;
  double subTotalFactura = 0.00;
  double importeExcento = 0.00;
  double importeGravado15 = 0.00;
  double importeGravado18 = 0.00;
  double isv15 = 0.00;
  double isv18 = 0.00;
}

Totales calcularTotales(List<DetallesDeVenta?> detalleDeVenta) {
  Totales totales = Totales();
  for (var i = 0; i < detalleDeVenta.length; i++) {
    totales.totalFactura =  totales.totalFactura + double.parse('${ detalleDeVenta[i]?.totalDetalleVenta }');
    if (detalleDeVenta[i]!.producto!.isExcento) {
      totales.importeExcento = totales.importeExcento + double.parse('${ detalleDeVenta[i]?.totalDetalleVenta }');
    } else {
      if (detalleDeVenta[i]!.isvAplicado == '18.00') {
        totales.importeGravado18 += (double.parse('${ detalleDeVenta[i]?.totalDetalleVenta  }')/1.18);
        totales.isv18 += (totales.importeGravado18 * 0.18);
      } else {
        totales.importeGravado15 += (double.parse('${ detalleDeVenta[i]?.totalDetalleVenta  }')/1.15);
        totales.isv15 += (totales.importeGravado15 * 0.15);
      }
    }
  }
  totales.subTotalFactura = totales.importeExcento + totales.importeGravado15 + totales.importeGravado18;
  print('==========================================');
  print('Total factura: ${totales.totalFactura}');
  print('Total excento: ${totales.importeExcento}');
  print('importe gravado 15%: ${totales.importeGravado15.toStringAsFixed(2)}');
  print('isv 15%: ${totales.isv15.toStringAsFixed(2)}');
  print('importe gravado 18%: ${totales.importeGravado18.toStringAsFixed(2)}');
  print('isv 18%: ${totales.isv18.toStringAsFixed(2)}');
  print('Sub total: ${totales.subTotalFactura.toStringAsFixed(2)}');
  return totales;
}
