import 'package:flutter/material.dart';

void alertaExito(BuildContext context,
    {String mensaje = 'Acción realizada con éxito.',}) {
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
                      mensaje,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: 80,
                      height: 40,
                      margin: EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Ok'),
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(10)),
                        ),
                      ),
                    ),
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
