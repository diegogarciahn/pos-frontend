  import 'package:flutter/material.dart';

void ventanaExito(BuildContext context) {
    var idTipoProductoController = TextEditingController();

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
                        'Acción realizada con éxito.',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                          width: 80,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // initState2();
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
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