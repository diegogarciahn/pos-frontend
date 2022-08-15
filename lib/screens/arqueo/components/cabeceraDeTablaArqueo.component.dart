import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CabeceraDeTablaArqueo extends StatelessWidget {
  const CabeceraDeTablaArqueo({
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
          flex: 2,
          child: Text(
            '#Arqueo',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01,
                fontWeight: FontWeight.w800,
                color: Colors.black),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Fecha Inicio',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.left,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Fecha Final',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.left,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'efectivo Apertura',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.left,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'efectivo Cierre',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.left,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'otros Pagos',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.left,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'ventaCredito',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'ventaTotal',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'efectivoTotal',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
        /*Expanded(
          flex: 2,
          child: Text(
            'isDelete',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),*/
        Expanded(
          flex: 3,
          child: Text(
            'createdAt',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'updatedAt',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '#Usuario',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.left,
            textScaleFactor: 1,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '#Sesion',
            style: GoogleFonts.lato(
                fontSize: size.width * 0.01, fontWeight: FontWeight.w800),
            textAlign: TextAlign.left,
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
