import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

RichText textAlertDialogFactura(String campo1, String campo2, String campo3,
      String atributo1, String atributo2, String atributo3) {
    return RichText(
        text: TextSpan(text: '     ' + campo1 + ': ', children: <TextSpan>[
      TextSpan(
          text: atributo1,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      (campo2.isNotEmpty)
          ? TextSpan(text: '     ' + campo2 + ': ')
          : TextSpan(),
      (campo2.isNotEmpty)
          ? TextSpan(
              text: atributo2,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600))
          : TextSpan(),
      (campo3.isNotEmpty)
          ? TextSpan(text: '     ' + campo3 + ': ')
          : TextSpan(),
      (campo3.isNotEmpty)
          ? TextSpan(
              text: atributo3,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600))
          : TextSpan(),
    ]));
  }