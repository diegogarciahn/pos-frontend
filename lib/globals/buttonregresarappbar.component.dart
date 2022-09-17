import 'package:flutter/material.dart';

Widget buttonAppBarRegresar(context, String ruta,
    {Function()? funcion}) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.01, vertical: 8),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.secondary),
        onPressed: (funcion == null)?() {
          Navigator.maybePop(context).then((value) {
            if (!value) {
              Navigator.popAndPushNamed(context, ruta);
            }
          });
        }:funcion,
        child: Text(
          'Regresar',
        )),
  );
}
