import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../models/Tipoproducto.model.dart';
import 'ventanactualizartipoproducto.component.dart';
import 'ventanaeliminartipoproducto.component.dart';

listItem(index, context, List<Tipoproducto> tiposN) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 16.0, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                tiposN[index].tipoProducto.toString(),
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                tiposN[index].descripcionProducto.toString(),
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(right: 20),
                  child: TextButton(
                    child: Text('Actualizar', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      ventanaActualizar(
                          context,
                          tiposN[index].id.toString(),
                          tiposN[index].tipoProducto.toString(),
                          tiposN[index].descripcionProducto.toString(),
                          tiposN[index].isvTipoProducto.toString());
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue[400]),
                    ),
                  ),
                )
                ),
            Expanded(
                flex: 2,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)
                  ),
                  child: Text('Eliminar', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    ventanaEliminar2(context, tiposN[index].id.toString());
                  },
                )),
          ],
        ),
      ),
    );
  }