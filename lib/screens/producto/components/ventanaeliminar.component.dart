import 'package:flutter/material.dart';
import '../../../services/producto.service.dart';
import 'ventanaexito.component.dart';

void ventanaEliminar(BuildContext context, String idProductoP) {
    late TextEditingController idProducto =
        TextEditingController(text: idProductoP);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Container(
              color: Colors.white,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¿Está seguro de eliminar el producto?',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: 200,
                            height: 100,
                            margin: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    onPressed: () {
                                      EliminarProducto(
                                          idProductoP.toString(), context);
                                      Navigator.pop(context);
                                      ventanaExito(context);
                                    },
                                    child: Text('Eliminar'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                ),
                              ],
                            )),
                      ]),
                ),
              ),
            ),
          ],
        );
      },
    );
  }