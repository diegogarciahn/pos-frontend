import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_frontend/models/Producto.model.dart';
import 'package:soft_frontend/screens/producto/components/ventanaeliminar.component.dart';
import 'package:soft_frontend/screens/producto/components/ventananuevaactualizar.component.dart';

import '../../../constans.dart';

listItem(index, List<Producto> tiposN, context) {
    final String enlace =
        (tiposN[index].urlImage.toString().replaceRange(6, 7, '/'));
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 16.0, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                tiposN[index].codigoProducto.toString(),
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                tiposN[index].nombreProducto.toString(),
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'L. ' + tiposN[index].precioProducto.toString(),
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                tiposN[index].cantidadProducto.toString(),
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                tiposN[index].isvProducto.toString() + '%',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
                flex: 1,
                child: FadeInImage(
                    height: 100,
                    width: 100,
                    image: NetworkImage('http://localhost:8080/' + enlace),
                    placeholder:
                        AssetImage('./assets/images/jar-loading.gif'),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image(image: AssetImage('./assets/images/jar-loading.gif'),); 
                        },
                        )),

            // cantidad y precio tan invertidos, al actualizar muestran los valores invertidos, primero va precio y despues cantidad
            //  Aqui los invierto para que se vean como deben verse.
            Expanded(
                flex: 1,
                child: TextButton(
                  child: Text('Actualizar'),
                  onPressed: () {
                    ventanaNuevaActualizar(
                      context,
                      tiposN[index].id.toString(),
                      tiposN[index].codigoProducto.toString(),
                      tiposN[index].nombreProducto.toString(),
                      tiposN[index].cantidadProducto.toString(),
                      tiposN[index].precioProducto.toString(),
                      tiposN[index].isvProducto.toString(),
                      tiposN[index].descProducto.toString(),
                      tiposN[index].isExcento.toString(),
                      path = url + enlace,
                      tiposN[index].idTipoProducto.toString(),
                    );
                    print(tiposN[index].urlImage);
                  },
                )),
            Expanded(
                flex: 1,
                child: TextButton(
                  child: Text('Eliminar'),
                  onPressed: () {
                    ventanaEliminar(context, tiposN[index].id.toString());
                  },
                )),
          ],
        ),
      ),
    );
  }