import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cabeceraTableUsuario(context) {
  final tema = Theme.of(context);
  return Card(
      color: tema.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 16.0, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itemColumn('Usuario', 2),
            itemColumn('Email', 2),
            itemColumn('Empleado', 2),
            itemColumn('Rol', 2),
            itemColumn('Opciones', 2),
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

