import 'package:flutter/material.dart';

void alertError(BuildContext context, {String mensaje = 'Ocurrio un error al realizar esta acción, intente de nuevo.'}) {
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
                              MaterialStateProperty.all(EdgeInsets.all(20)),
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
