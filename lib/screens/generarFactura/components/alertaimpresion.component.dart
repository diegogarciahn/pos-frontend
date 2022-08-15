import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/imprimirfactura.controller.dart';

import '../../../models/crearFactura.model.dart';

Future<dynamic> dialogOpcionDeImpresion(
  context,
  Factura factura,
  int tiempo
) {
  int tipo = 0;
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text('Por favor seleccione un tipo de factura a imprimir.'),
            content: DropdownButton(
              alignment: Alignment.center,
              hint: Text('Factura rápida'),
              items: const [
                DropdownMenuItem(
                  child: Text('Factura rápida'),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text('Factura con membrete'),
                  value: 2,
                ),
              ],
              onChanged: (int? value) {
                switch (value) {
                  case 1:
                    tipo = 1;
                    break;
                  case 2:
                    tipo = 2;
                    break;
                  default:
                }
              },
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    if (tipo != 0) {
                      descargarFacturaOriginal(
                          context, factura.insertfactura.numeroFactura, tipo, tiempo);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Seleccione un tipo de factura a imprimir.')));
                    }
                  },
                  child: Text('Imprimir'))
            ],
          ));
}
