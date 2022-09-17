import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cabeceraTableEmpleados(context) {
  final tema = Theme.of(context);
  return Card(
      color: tema.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 16.0, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itemColumn('DNI', 2),
            itemColumn('Nombre', 2),
            itemColumn('Apellido', 2),
            itemColumn('Dirección', 2),
            itemColumn('Teléfono', 2),
            itemColumn('Sexo', 1),
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
      textAlign: TextAlign.left,
      style: GoogleFonts.lato(fontSize: 15),
    ),
  );
}