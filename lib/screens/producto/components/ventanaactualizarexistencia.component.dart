import 'package:flutter/material.dart';

import '../../../controllers/producto.controller.dart';

void ventanaActualizarInventario(BuildContext context) {
  var codigoProductoController = TextEditingController();
  var cantidadProductoController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Por favor indique el código de producto y la cantidad de existencia que desea actualizar.'),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: codigoProductoController,
              decoration: InputDecoration(
                labelText: 'Código de producto',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: cantidadProductoController,
              decoration: InputDecoration(
                labelText: 'Cantidad de producto',
                border: OutlineInputBorder()
              ),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              actualizarExistenciaController(codigoProductoController.text,
                  cantidadProductoController.text, context);
            },
            child: Text('Actualizar'),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(20)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancelar'),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(20)),
            ),
          ),
        ],
      );
    },
  );
}
