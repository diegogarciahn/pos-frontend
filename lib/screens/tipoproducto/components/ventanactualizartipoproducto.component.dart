  import 'package:flutter/material.dart';

void ventanaActualizar(
      BuildContext context,
      String idTipoProductoP,
      String tipoProductoP,
      String descripcionProductoP,
      String isvTipoProductoP) {
    late TextEditingController idTipoProducto =
        TextEditingController(text: idTipoProductoP);
    late TextEditingController tipoProducto2 =
        TextEditingController(text: tipoProductoP);
    late TextEditingController descripcionProducto =
        TextEditingController(text: descripcionProductoP);
    late TextEditingController isvTipoProducto =
        TextEditingController(text: isvTipoProductoP);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Container(
              width: 500,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tipo de Producto',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                        controller: tipoProducto2,
                        decoration:
                            InputDecoration(border: UnderlineInputBorder()),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Descripción',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                        controller: descripcionProducto,
                        decoration:
                            InputDecoration(border: UnderlineInputBorder()),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'ISV',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                        controller: isvTipoProducto,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Escribir en valor decimal.'),
                      ),
                      Container(
                          width: 80,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: RaisedButton(
                            onPressed: () {
                              // estaCorrecto = controladorActualizarTipoProducto(
                              //     idTipoProductoP,
                              //     tipoProducto2.text,
                              //     descripcionProducto.text,
                              //     isvTipoProducto.text,
                              //     context);
                              // Navigator.popAndPushNamed(
                              //     context, 'PantallaTipoProductos');
                              // initState();
                            },
                            child: Text('Actualizar'),
                            padding: EdgeInsets.all(10),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                    ]),
              ),
            ),
          ],
        );
      },
    );
  }