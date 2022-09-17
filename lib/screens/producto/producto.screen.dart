import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:soft_frontend/models/Producto.model.dart';

import 'package:soft_frontend/providers/producto.provider.dart';

import 'components/ventanaactualizarexistencia.component.dart';
import 'components/ventananueva.component.dart';
import 'components/listitem.component.dart';

bool isCorrect = false;
String? path;
ImagePicker picker = ImagePicker();
var imagePiker;

class PantallaProducto extends StatefulWidget {
  const PantallaProducto({Key? key}) : super(key: key);

  @override
  State<PantallaProducto> createState() => _PantallaProductoState();
}

class _PantallaProductoState extends State<PantallaProducto> {
  List<Producto> tipos = <Producto>[];
  List<Producto> tiposN = <Producto>[];

  String idTipoProductoG = '';
  bool esCorrecto = false;
  String urlImage = '';
  String? pathActualizar = '';

  // Porque tantas isExcepto? porque ando probando, y todas sirven, porfa no borrarlas u , u, hay una que se usa en
  // actualizar y otra en crear,

  @override
  void initState() {
    final productoProviderI =
        Provider.of<ProductoProvider>(context, listen: false);
    productoProviderI.setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductoProvider productoProvider = Provider.of<ProductoProvider>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Productos'),
          leading: Icon(Icons.content_paste_sharp),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).focusColor
                ),
                onPressed: () {
                  Navigator.popAndPushNamed(context, 'mantenimiento');
                },
                child: Text('Regresar',),
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 243, 243, 243),
        body: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 27.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 120,
                              height: 80,
                              margin: EdgeInsets.all(5),
                              child: ElevatedButton(
                                  onPressed: () {
                                    ventanaNueva(context);
                                  },
                                  child: Text('Agregar'),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(25)),
                                  ))),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 120,
                                height: 80,
                                margin: EdgeInsets.all(5),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          'mantenimiento/productos/tipoproductos');
                                    },
                                    child: Text(
                                      'Agregar tipo de producto',
                                      textAlign: TextAlign.center,
                                    ),),
                                    )),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 120,
                                height: 80,
                                margin: EdgeInsets.all(5),
                                child: ElevatedButton(
                                    onPressed: () {
                                      ventanaActualizarInventario(context);
                                    },
                                    child: Text('Modificar existencia'),
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.all(25)),
                                    )))),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return index == 0
                            ? _searchBar(productoProvider)
                            : (tiposN.isEmpty)
                                ? listItem(index - 1, productoProvider.getData,
                                    context)
                                : listItem(index - 1, tiposN, context);
                      },
                      itemCount: (tiposN.isEmpty)
                          ? productoProvider.getData.length + 1
                          : tiposN.length + 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

// Este es para buscar productos.
// Se usan dos listas, la que va filtrando y la que static que cuando se borra llena a la que filtra.
  _searchBar(ProductoProvider productoProvider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(hintText: 'Buscar producto'),
            onChanged: (text) {
              text = text.toLowerCase();
              setState(() {
                tiposN = productoProvider.getData.where((note) {
                  var noteTitle = note.nombreProducto.toString().toLowerCase();
                  return noteTitle.contains(text);
                }).toList();
              });
            },
          ),
        ),
        _cardCabecera(),
      ],
    );
  }

  _cardCabecera() {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 16.0, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                'Codigo Producto',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Nombre Producto',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Precio',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Cantidad',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'ISV',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),

            // cantidad y precio tan invertidos, al actualizar muestran los valores invertidos, primero va precio y despues cantidad
            //  Aqui los invierto para que se vean como deben verse.
            Expanded(
              flex: 1,
              child: Text(
                '',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('imagePiker', imagePiker));
  }
}
