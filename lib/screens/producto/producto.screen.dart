import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:soft_frontend/models/Producto.model.dart';

import 'package:soft_frontend/controllers/producto.controller.dart';
import 'package:soft_frontend/providers/producto.provider.dart';

import 'package:soft_frontend/services/producto.service.dart';

import 'components/buscartipoproducto.component.dart';
import 'components/ventananueva.component.dart';
import 'components/ventanaerror.component.dart';
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
    final productoProviderI = Provider.of<ProductoProvider>(context, listen: false);
    productoProviderI.setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productoProvider = Provider.of<ProductoProvider>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Productos'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, 'mantenimiento');
              },
              child: Text('Regresar',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ],
        ),
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
                      child: Container(
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 120,
                                height: 80,
                                margin: EdgeInsets.all(5),
                                child: RaisedButton(
                                  onPressed: () {
                                    ventanaNueva(context);
                                    // fetchData();
                                    setState(() {});
                                    print('he podido ayudarme a vivir');
                                  },
                                  child: Text('Agregar'),
                                  padding: EdgeInsets.all(25),
                                )),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 120,
                                  height: 80,
                                  margin: EdgeInsets.all(5),
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context,'mantenimiento/productos/tipoproductos');
                                    },
                                    child: Text('Agregar Tipo de producto'),
                                    padding: EdgeInsets.all(25),
                                  ))),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 120,
                                  height: 80,
                                  margin: EdgeInsets.all(5),
                                  child: RaisedButton(
                                    onPressed: () {
                                      _ventanaActualizarInventario(context);
                                    },
                                    child: Text('Modificar existencia'),
                                    padding: EdgeInsets.all(25),
                                  ))),
                        ]),
                      ),
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
                        return index == 0 ? _searchBar() : listItem(index - 1, productoProvider.getData,context);
                      },
                      itemCount: productoProvider.getData.length+1,
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
  _searchBar() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(hintText: 'Buscar producto'),
            onChanged: (text) {
              text = text.toLowerCase();
              setState(() {
                tiposN = tipos.where((note) {
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

  void _ventanaActualizarInventario(BuildContext context) {
    var codigoProductoController = TextEditingController();
    var cantidadProductoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Container(
              color: Colors.white,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 350,
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Código Producto',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          TextFormField(
                            controller: codigoProductoController,
                            decoration:
                                InputDecoration(border: UnderlineInputBorder()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Cantidad Producto',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          TextFormField(
                            controller: cantidadProductoController,
                            decoration:
                                InputDecoration(border: UnderlineInputBorder()),
                          ),
                          Container(
                              width: 100,
                              height: 50,
                              margin: EdgeInsets.all(5),
                              child: RaisedButton(
                                onPressed: () {
                                  isCorrect = controladorCantidad(
                                      codigoProductoController.text,
                                      cantidadProductoController.text,
                                      context);
                                  if (isCorrect == true) {
                                    // initState2();
                                    // fetchData();
                                    setState(() {});
                                    Navigator.pop(context);
                                  } else {
                                    ventanaError(context, 'Ocurrio un error al realizar esta acción, intente de nuevo.');
                                  }
                                  // fetchData();
                                  setState(() {});
                                },
                                child: Text('Actualizar'),
                                padding: EdgeInsets.all(10),
                              )),
                        ]),
                  ),
                ),
              ]),
            ),
          ],
        );
      },
    );
  }

  _cardCabecera() {
    return Card(
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
          ],
        ),
      ),
    );
  }

  void _prueba(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 500,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buscarTipoProducto(context),
                          SizedBox(
                            height: 40,
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('imagePiker', imagePiker));
  }
}
