import 'package:flutter/material.dart';
import 'package:soft_frontend/screens/tipoproducto/components/ventanaexitotipoproducto.component.dart';

import '../../../services/tipoproducto.service.dart';

void ventanaEliminar2(BuildContext context, String idTipoProductoP) {
  late TextEditingController idTipoProducto =
      TextEditingController(text: idTipoProductoP);

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
              EliminarTipoProducto(
                  idTipoProducto.text, context);
              Navigator.pop(context);
              ventanaExito(context);
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
