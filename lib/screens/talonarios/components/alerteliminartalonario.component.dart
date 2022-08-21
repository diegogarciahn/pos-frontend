import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/talonarios.controller.dart';
import 'package:soft_frontend/models/talonario.model.dart';

import '../themes/app_theme.dart';

alertEliminarTalonario(context, Talonario talonario) {
  return showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          title: Text(
            'Eliminar talonario',
            style: TextStyle(),
          ),
          content: Text('¿Está seguro de eliminar el talonario con el CAI ' +
              talonario.cai +
              '?'),
          actions: [
            TextButton(
                style: AppTheme.lightTheme.textButtonTheme.style,
                onPressed: () {
                  eliminarTalonarioController(talonario.idTalonario.toString(), context);
                  Navigator.pop(context);
                },
                child: Text('Confirmar')),
                ElevatedButton(
                  style: AppTheme.lightTheme.textButtonTheme.style,
                  onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancelar'))
          ],
        );
      });
}
