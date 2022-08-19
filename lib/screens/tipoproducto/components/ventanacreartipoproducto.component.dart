import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/tipoproducto.controller.dart';

void ventanaCrearTipoProducto(BuildContext context) {
  int radioButtonGroup = 4;
  String isvTipoProducto = '';
  var tipoProductoController = TextEditingController();
  var descripcionProductoController = TextEditingController();

  showDialog(
    context: context,
    builder: (
      BuildContext context) {
      return AlertDialog(
        content: StatefulBuilder(
          builder: (context, StateSetter setState) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Tipo de Producto',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                TextFormField(
                  controller: tipoProductoController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Ej. Embutidos'),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Descripción',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                TextFormField(
                  controller: descripcionProductoController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ej. Diferentes tipos de carne.'),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'ISV',
                    style: TextStyle(fontSize: 18),
                  ),
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
        }),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              crearTipoProductoController(tipoProductoController.text,
                  descripcionProductoController.text, isvTipoProducto, context);
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
