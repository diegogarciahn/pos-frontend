  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

cabecera() {
    return Card(
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 16.0, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                'Tipo producto',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                'Descripción',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Acciones',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }