import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cabeceraTableRoles(context) {
  final tema = Theme.of(context);
  return Card(
      color: tema.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 16.0, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itemColumn('Nombre del Rol', 3, tema),
            itemColumn('Descripción', 4, tema),
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