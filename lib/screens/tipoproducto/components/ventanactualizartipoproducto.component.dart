import 'package:flutter/material.dart';

import '../../../controllers/tipoproducto.controller.dart';

void ventanaActualizar(
    BuildContext context,
    String idTipoProductoP,
    String tipoProductoP,
    String descripcionProductoP,
    String isvTipoProductoP) {
  int radioButtonGroup = 4;
  String isvTipoProducto = isvTipoProductoP;
  late TextEditingController tipoProducto2 =
      TextEditingController(text: tipoProductoP);
  late TextEditingController descripcionProducto =
      TextEditingController(text: descripcionProductoP);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tipo de Producto',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    controller: tipoProducto2,
                    decoration: InputDecoration(border: UnderlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Descripción',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    controller: descripcionProducto,
                    decoration: InputDecoration(border: UnderlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ISV',
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<int>(
                          value: 0,
                          groupValue: radioButtonGroup,
                          title: Text('Excento'),
                          onChanged: (value) {
                            setState(() => radioButtonGroup = 0);
                            isvTipoProducto = '0';
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<int>(
                          value: 1,
                          groupValue: radioButtonGroup,
                          title: Text('15%'),
                          onChanged: (value) {
                            setState(() => radioButtonGroup = 1);
                            isvTipoProducto = '15';
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<int>(
                            value: 2,
                            groupValue: radioButtonGroup,
                            title: Text('18%'),
                            onChanged: (value) {
                              setState(() => radioButtonGroup = 2);
                              isvTipoProducto = '18';
                            }),
                      ),
                    ],
                  ),
                ]);
          },
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              actualizarTipoProductoController(
                  idTipoProductoP,
                  tipoProducto2.text,
                  descripcionProducto.text,
                  isvTipoProducto,
                  context);
            },
            child: Text('Guardar'),
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
