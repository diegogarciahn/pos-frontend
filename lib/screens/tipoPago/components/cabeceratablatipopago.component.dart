import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cabeceraTableTipoPago(context) {
  final tema = Theme.of(context);
  return Card(
      color: tema.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 16.0, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itemColumn('Tipo de pago', 2, tema),
            itemColumn('Descripción', 5, tema),
            itemColumn('Acciones', 3, tema),
          ],
        ),
      ));
}

Expanded itemColumn(String texto, int flex, ThemeData tema) {
  return Expanded(
    flex: flex,
    child: Text(
      texto,
      style: GoogleFonts.lato(fontSize: 15, color: tema.primaryColor),
    ),
  );
}