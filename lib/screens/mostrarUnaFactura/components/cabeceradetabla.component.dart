import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CabeceraDeTablaDeProductos extends StatelessWidget {
  const CabeceraDeTablaDeProductos({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
              flex: 1,
              child: Text(
                'Código',
                style: GoogleFonts.lato(fontSize: size.width * 0.009, fontWeight: FontWeight.w800),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'Nombre',
                style: GoogleFonts.lato(fontSize: size.width * 0.009, fontWeight: FontWeight.w800),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'ISV',
                style: GoogleFonts.lato(fontSize: size.width * 0.009, fontWeight: FontWeight.w800),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Cantidad',
                style: GoogleFonts.lato(fontSize: size.width * 0.009, fontWeight: FontWeight.w800),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Precio unitario',
                style: GoogleFonts.lato(fontSize: size.width * 0.009, fontWeight: FontWeight.w800),
              ),
            ),
    ],);
  }
}