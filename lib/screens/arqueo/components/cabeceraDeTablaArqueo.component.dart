import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cabeceraTableArqueos(context) {
  final tema  = Theme.of(context);
  return Card(
      color: tema.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 16.0, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itemColumn('Arqueo', 1),
            itemColumn('Fecha inicial', 2),
            itemColumn('Fecha final', 2),
            itemColumn('Efectivo apertura', 2),
            itemColumn('Efectivo cierre', 2),
            itemColumn('Otros pagos', 2),
            itemColumn('Ventas al crédito', 2),
            itemColumn('Venta total', 2),
            itemColumn('Efectivo total', 2),
          ],
        ),
      ));
}

Expanded itemColumn(String texto, int flex) {
  return Expanded(
    flex: flex,
    child: Text(
      texto,
      style: GoogleFonts.lato(fontSize: 15),
    ),
  );
}