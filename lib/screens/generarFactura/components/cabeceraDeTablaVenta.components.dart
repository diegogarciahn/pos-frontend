import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CabeceraDeTablaVenta extends StatelessWidget {
  const CabeceraDeTablaVenta({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Total ISV',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01,
                fontWeight: FontWeight.w800,
                color: Colors.black),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Total Venta',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.left,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Total Descuento Venta',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.left,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Nombre Cliente',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.left,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'DNI',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.left,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'RTN',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.left,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'DireccionCliente',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Telefono Cliente',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Nombre Empleado',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }
}
