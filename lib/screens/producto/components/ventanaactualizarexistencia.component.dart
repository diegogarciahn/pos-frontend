import 'package:flutter/material.dart';

import '../../../controllers/producto.controller.dart';
import 'ventanaerror.component.dart';

void ventanaActualizarInventario(BuildContext context) {
    var codigoProductoController = TextEditingController();
    var cantidadProductoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Container(
              color: Colors.white,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 350,
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Código Producto',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          TextFormField(
                            controller: codigoProductoController,
                            decoration:
                                InputDecoration(border: UnderlineInputBorder()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Cantidad Producto',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          TextFormField(
                            controller: cantidadProductoController,
                            decoration:
                                InputDecoration(border: UnderlineInputBorder()),
                          ),
                          Container(
                              width: 100,
                              height: 50,
                              margin: EdgeInsets.all(5),
                              child: RaisedButton(
                                onPressed: () {
                                  controladorCantidad(
                                      codigoProductoController.text,
                                      cantidadProductoController.text,
                                      context);
                                },
                                child: Text('Actualizar'),
                                padding: EdgeInsets.all(10),
                              )),
                        ]),
                  ),
                ),
              ]),
            ),
          ],
        );
      },
    );
  }
