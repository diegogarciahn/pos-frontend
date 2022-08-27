import 'package:flutter/material.dart';

import '../../talonarios/themes/app_theme.dart';

alertEliminarTipoPago(context) {
  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          title: Text(
            'Eliminar un tipo de pago',
            style: TextStyle(color: Colors.blue),
          ),
          content: SizedBox(
            height: 90,
            child: Column(
              children: const [
                Text('¿Está seguro de eliminar el tipo de pago?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: AppTheme.lightTheme.textButtonTheme.style,
              onPressed: () {
                // eliminarTipoPago_Controller(
                //         tipoPago.idTipoPago.toString(),
                //         context)
                //     .then((value) => this._cargarFact());
                // Navigator.pop(context);
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      });
}
