import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_frontend/controllers/talonarios.controller.dart';
import 'package:soft_frontend/screens/talonarios/components/alertActualizarTalonario.component.dart';
import 'package:soft_frontend/screens/talonarios/components/alerteliminartalonario.component.dart';

import '../../../models/talonario.model.dart';

Widget listItemTalonario(Talonario talonario, context) {
  return Card(
    child: Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          itemRow(talonario.rangoInicialFactura, 1),
          itemRow(talonario.rangoFinalFactura, 1),
          itemRow(talonario.cai, 3),
          itemRow(
              talonario.fechaLimiteEmision.toIso8601String().substring(0, 10),
              1),
          itemRow((talonario.active) ? 'Verdadero' : 'Falso', 1),
          buttonRow('Actualizar', 1, () => 
            alertActualizarTalonario(context, talonario), 
          Colors.blue,
              margenes: EdgeInsets.only(right: 5)),
          buttonRow('Eliminar', 1,
              () => alertEliminarTalonario(context, talonario), Colors.red,
              margenes: EdgeInsets.only(right: 5)),
          buttonRow((talonario.active) ? 'Desactivar' : 'Activar', 1,
              () {
                (talonario.active) 
                ? cambiarEstadoTalonarioController(talonario.idTalonario.toString(), 2, context)
                : cambiarEstadoTalonarioController(talonario.idTalonario.toString(), 1, context);
              }, 
              (talonario.active) ? Colors.yellow : Colors.green,
              textColor: (talonario.active) ? Colors.black : Colors.white),
        ],
      ),
    ),
  );
}

Expanded itemRow(String texto, int flex) {
  return Expanded(
    flex: flex,
    child: Text(
      texto,
      style: GoogleFonts.lato(fontSize: 15),
    ),
  );
}

Expanded buttonRow(String texto, int flex, Function() funcion, Color color,
    {Color textColor = Colors.white,
    EdgeInsetsGeometry margenes = const EdgeInsets.all(0)}) {
  return Expanded(
    child: Container(
      margin: margenes,
      child: TextButton(
        onPressed: funcion,
        child: Text(texto, style: TextStyle(color: textColor)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
      ),
    ),
  );
}
