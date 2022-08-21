import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cabeceraTableTalonarios() {
  return Card(
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 16.0, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itemColumn('Rango inicial', 1),
            itemColumn('Rango final', 1),
            itemColumn('CAI', 3),
            itemColumn('Fecha Limite E.', 1),
            itemColumn('Estado', 1),
            itemColumn('Opciones', 3),
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
