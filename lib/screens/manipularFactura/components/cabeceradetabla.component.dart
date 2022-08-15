import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CabeceraDeTabla extends StatelessWidget {
  const CabeceraDeTabla({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Número de Factura',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01,
                fontWeight: FontWeight.w800,
                color: Colors.black),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Fecha',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Total',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Nombre de empleado',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'CAI',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Nombre de cliente',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'RTN',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        )
      ],
    );
  }
}
