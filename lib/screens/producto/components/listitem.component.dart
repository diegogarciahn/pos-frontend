import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_frontend/models/Producto.model.dart';
import 'package:soft_frontend/screens/producto/components/ventanaeliminar.component.dart';
import 'package:soft_frontend/screens/producto/components/ventananuevaactualizar.component.dart';

import '../../../constans.dart';

listItem(index, List<Producto> tiposN, context) {
  late String enlace = '';
  if (tiposN[index].urlImage != '') {
    enlace =
        (tiposN[index].urlImage.toString().replaceRange(6, 7, '/'));
    
  }
  return Card(
    child: Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16),
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
          // AssetImage('./assets/images/jar-loading.gif')
          Expanded(
              flex: 1,
              child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  imageUrl: 'http://localhost:8080/' + enlace,
                  placeholder: (context, url) => Container(height: 20, width: 20,  child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Image.asset('./assets/images/jar-loading.gif'))),
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
                  return ventanaEliminar(context, tiposN[index].id.toString());
                },
              )),
        ],
      ),
    ),
  );
}
