import 'package:flutter/material.dart';

import '../../../models/Arqueo.model.dart';

Widget itemTableArqueo(Arqueo listaArqueos, Size size) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        columnaDeTexto(listaArqueos.idArqueo.toString(), 1, size),
        columnaDeTexto(listaArqueos.fechaInicio.toString(), 2, size),
        columnaDeTexto(listaArqueos.fechaFinal.toString(), 2, size),
        columnaDeTexto(listaArqueos.efectivoApertura.toString(), 2, size),
        columnaDeTexto(listaArqueos.efectivoCierre.toString(), 2, size),
        columnaDeTexto(listaArqueos.otrosPagos.toString(), 2, size),
        columnaDeTexto(listaArqueos.ventaCredito.toString(), 2, size),
        columnaDeTexto(listaArqueos.ventaTotal.toString(), 2, size),
        columnaDeTexto(listaArqueos.efectivoTotal.toString(), 2, size),
      ],
    ),
  );
}

Widget columnaDeTexto(String texto, int flex, size) {
  return Expanded(
      flex: flex,
      child: Text(
        texto,
        style: TextStyle(
            fontSize: size.width * 0.01,
            fontWeight: FontWeight.w800,
            color: Colors.black),
        textAlign: TextAlign.left,
        textScaleFactor: 1,
      ));
}
