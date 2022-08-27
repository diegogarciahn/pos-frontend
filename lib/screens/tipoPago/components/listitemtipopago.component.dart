import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:soft_frontend/screens/tipoPago/components/alerteliminartipopago.component.dart';

import '../../../models/tipoPagoBuscado.model.dart';
import '../editarTipoPago.screen.dart';

Widget listItemTipoPago(TipoPagoBuscado tipoPago, context) {
  Size size = MediaQuery.of(context).size;
  final tema = Theme.of(context);
  return Card(
      child: Padding(
    padding:
        const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        itemRow(tipoPago.tipoDePago, 2),
        itemRow(tipoPago.descripcionTipoPago, 5),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              buttonRow(
                  'Editar',
                  5,
                  () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditarTipoPagos(
                            tipoPago: tipoPago,
                          ),
                        ),
                      ),
                  tema.primaryColor,
                  margenes: EdgeInsets.only(right: size.width * 0.005)),
              buttonRow('Eliminar', 5, () => alertEliminarTipoPago(context),
                  Colors.red,
                  margenes: EdgeInsets.only(left: size.width * 0.005)),
            ],
          ),
        ),
      ],
    ),
  ));
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
