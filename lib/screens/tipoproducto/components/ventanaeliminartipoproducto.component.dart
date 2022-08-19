import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/tipoproducto.controller.dart';
import 'package:soft_frontend/screens/tipoproducto/components/ventanaexitotipoproducto.component.dart';

import '../../../services/tipoproducto.service.dart';

void ventanaEliminar(BuildContext context, String idTipoProductoP) {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          '¿Está seguro de eliminar el tipo de producto?',
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              eliminarTipoProductoController(context, idTipoProductoP);
            },
            child: Text('Eliminar'),
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
