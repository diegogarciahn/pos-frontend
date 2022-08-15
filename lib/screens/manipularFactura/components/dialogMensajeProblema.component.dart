import 'package:flutter/material.dart';

Future<dynamic> dialogMensajeProblema(context, String texto) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(texto),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cerrar'))
            ],
          ));
}
