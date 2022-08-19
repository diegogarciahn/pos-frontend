import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/producto.controller.dart';
import '../../../services/producto.service.dart';
import 'ventanaexito.component.dart';

void ventanaEliminar(BuildContext context, String idProductoP) {
  late TextEditingController idProducto =
      TextEditingController(text: idProductoP);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          '¿Está seguro de eliminar el producto seleccionado?',
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 25, horizontal: 15))
              ),
              onPressed: () {
                eliminarProductoController(idProductoP.toString(), context);
              },
              child: Text('Eliminar')),
          ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 25 , horizontal: 15))
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar')),
        ],
      );
    },
  );
}
