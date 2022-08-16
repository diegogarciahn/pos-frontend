import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/controllers/producto.controller.dart';
import 'package:soft_frontend/models/Producto.model.dart';
import 'package:soft_frontend/models/buscarProducto.dart';
import 'package:soft_frontend/screens/tipoproducto/tipoproducto.screen.dart';
import 'package:soft_frontend/screens/principalmantenimiento/principalmantenimiento.screen.dart';
import 'package:soft_frontend/services/producto.service.dart';
import 'package:soft_frontend/services/tipoproducto.service.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:soft_frontend/controllers/producto.controller.dart' as globals;

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
  int _counter = 0;
  List<Producto> tipos = <Producto>[];
  List<Producto> tiposN = <Producto>[];
  bool _loading = true;

  final TextEditingController _typeAheadController = TextEditingController();
  String idTipoProductoG = "";
  String excenteo = "";
  int isExcento = 0;
  bool isExcento2 = false;
  String isExcento3 = "";
  int isExceptoN = 0;
  bool esCorrecto = false;
  String urlImage = "";
  String? pathActualizar ="";

  // Porque tantas isExcepto? porque ando probando, y todas sirven, porfa no borrarlas u , u, hay una que se usa en
  // actualizar y otra en crear,

  @override
  void initState() {
    super.initState();
    //getInitData();
    fetchData();
  }

  fetchData() async {
    tipos.clear();
    tiposN.clear();
    var res = await obtenerProductos().then((value) {
      setState(() {
        tipos.addAll(value);
        tiposN.addAll(value);
      });
    });
    setState(() {
      _loading = false;
    });
  }

  Future<void> getInitData() async {
    await obtenerProductos().then((value) {
      setState(() {
        tipos.addAll(value);
        tiposN.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Nueva Venta'),
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
                                    _ventanaNueva(context);
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            PantallaTipoProducto(),
                                      ));
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
                        return index == 0
                            ? _searchBar()
                            : _listItem(index - 1);
                      },
                      itemCount: tiposN.length + 1,
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
                              "Código Producto",
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
                              "Cantidad Producto",
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
                                    initState();
                                    Navigator.pop(context);
                                  } else {
                                    _ventanaError(context);
                                  }
                                  initState();
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

  void _ventanaEliminar(BuildContext context, String idProductoP) {
    late TextEditingController idProducto =
        TextEditingController(text: idProductoP);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Container(
              color: Colors.white,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "¿Está seguro de eliminar el producto?",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: 200,
                            height: 100,
                            margin: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    onPressed: () {
                                      EliminarProducto(
                                          idProductoP.toString(), context);
                                      Navigator.pop(context);
                                      _ventanaExito(context);
                                    },
                                    child: Text('Eliminar'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                ),
                              ],
                            )),
                      ]),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _ventanaExito(BuildContext context) {
    var idTipoProductoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Container(
              width: 500,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Acción realizada con éxito.",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                          width: 80,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(
                                  context, 'PantallaProductos');
                              initState();
                            },
                            child: Text('OK'),
                            padding: EdgeInsets.all(10),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                    ]),
              ),
            ),
          ],
        );
      },
    );
  }

  void _ventanaActualizar(
      BuildContext context,
      String idProductoP,
      String codigoProductoP,
      String nombreProductoP,
      String cantidadProductoP,
      String precioProductoP,
      String isvProductoP,
      String descProductoP,
      String isExcentoP,
      var imagePiker,
      String idTipoProductoP) {
    late TextEditingController idProducto =
        TextEditingController(text: idProductoP);
    late TextEditingController codigoProducto =
        TextEditingController(text: codigoProductoP);
    late TextEditingController nombreProducto =
        TextEditingController(text: nombreProductoP);
    late TextEditingController precioProducto =
        TextEditingController(text: precioProductoP);
    late TextEditingController cantidadProducto =
        TextEditingController(text: cantidadProductoP);
    late TextEditingController isvProducto =
        TextEditingController(text: isvProductoP);
    late TextEditingController descProducto =
        TextEditingController(text: descProductoP);
    late TextEditingController isExcento =
        TextEditingController(text: isExcentoP);
    late TextEditingController idTipoProducto =
        TextEditingController(text: idTipoProductoP);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Container(
              color: Colors.white,
              child: Expanded(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 350,
                        height: 450,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Código Producto",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                TextFormField(
                                  controller: codigoProducto,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Precio",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                TextFormField(
                                  controller: precioProducto,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "ISV",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                TextFormField(
                                    controller: isvProducto,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Excento",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                TextFormField(
                                  controller: isExcento,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  margin: EdgeInsets.all(5),
                                ),
                              ]),
                        ),
                      ),
                      Container(
                        width: 350,
                        height: 450,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Nombre del producto",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                TextFormField(
                                  controller: nombreProducto,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Cantidad en existencia",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                TextFormField(
                                  controller: cantidadProducto,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Descuento",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                TextFormField(
                                  controller: descProducto,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                Container(
                                    width: 100,
                                    height: 50,
                                    margin: EdgeInsets.all(5),
                                    child: RaisedButton(
                                      onPressed: () {
                                        ActualizarProducto2(
                                            idProducto.text,
                                            codigoProducto.text,
                                            nombreProducto.text,
                                            precioProducto.text,
                                            cantidadProducto.text,
                                            isvProducto.text,
                                            descProducto.text,
                                            isExcento.text,
                                            idTipoProducto.text,
                                            imagePiker,
                                            context);
                                        Navigator.pop(context);
                                        _ventanaExito(context);
                                        initState();
                                      },
                                      child: Text('Actualizar'),
                                      padding: EdgeInsets.all(10),
                                    )),
                              ]),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        );
      },
    );
  }

  _listItem(index) {
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
                "L. " + tiposN[index].precioProducto.toString(),
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
                tiposN[index].isvProducto.toString() + "%",
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
                        AssetImage('./assets/images/jar-loading.gif'))),

            // cantidad y precio tan invertidos, al actualizar muestran los valores invertidos, primero va precio y despues cantidad
            //  Aqui los invierto para que se vean como deben verse.
            Expanded(
                flex: 1,
                child: TextButton(
                  child: Text("Actualizar"),
                  onPressed: () {
                    _ventanaNuevaActualizar(
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
                  child: Text("Eliminar"),
                  onPressed: () {
                    _ventanaEliminar(context, tiposN[index].id.toString());
                  },
                )),
          ],
        ),
      ),
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
                "Codigo Producto",
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Nombre Producto",
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "Precio",
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "Cantidad",
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "ISV",
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),

            // cantidad y precio tan invertidos, al actualizar muestran los valores invertidos, primero va precio y despues cantidad
            //  Aqui los invierto para que se vean como deben verse.
            Expanded(
              flex: 1,
              child: Text(
                "",
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "",
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buscarTipoProducto() {
    return Container(
        child: TypeAheadField<Tipoproducto2?>(
      hideSuggestionsOnKeyboardHide: false,
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
            hintText: 'Agregar tipo producto',
          ),
          controller: _typeAheadController),
      suggestionsCallback: UserApi.obtenerTipos,
      itemBuilder: (context, Tipoproducto2? suggestion) {
        final tipos = suggestion!;
        return ListTile(
          title: Text(tipos.tipoProducto),
        );
      },
      noItemsFoundBuilder: (context) => Container(
        height: 100,
        child: Center(
          child: Text(
            'No hay tipos de productos.',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      onSuggestionSelected: (Tipoproducto2? suggestion) {
        final tipo = suggestion!;
        idTipoProductoG = tipo.id.toString();
        this._typeAheadController.text = tipo.tipoProducto;

        /*
              ScaffoldMessenger.of(context),
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('TipoProducto: ${tipo.tipoProducto}'),
              ));
            */
      },
    ));
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
                          _buscarTipoProducto(),
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

  void _ventanaNueva(BuildContext context) {
    var idProductoController = TextEditingController();
    var codigoProductoController = TextEditingController();
    var nombreProductoController = TextEditingController();
    var precioProductoController = TextEditingController();
    var cantidadProductoController = TextEditingController();
    var isvProductoController = TextEditingController();
    var descProductoController = TextEditingController();
    var isExcentoController = TextEditingController();
    var idTipoProductoController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 350,
                              height: 350,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Código Producto",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: codigoProductoController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Precio",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: precioProductoController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "ISV",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      TextFormField(
                                          controller: isvProductoController,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Excento",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: RadioListTile<int>(
                                              value: 1,
                                              groupValue: isExcento,
                                              title: Text('Si'),
                                              onChanged: (value) {
                                                setState(() => isExcento = 1);
                                                isExcento2 = true;
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: RadioListTile<int>(
                                                value: 0,
                                                groupValue: isExcento,
                                                title: Text('No'),
                                                onChanged: (value) {
                                                  setState(() => isExcento = 0);
                                                  isExcento2 = false;
                                                }),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                            Container(
                              width: 350,
                              height: 350,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Nombre del producto",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: nombreProductoController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Cantidad en existencia",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: cantidadProductoController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Descuento",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: descProductoController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Tipo producto",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      _buscarTipoProducto(),
                                    ]),
                              ),
                            ),
                          ]),
                      Row(
                        children: [
                          (path == null)
                              ? Container(
                                  width: 150,
                                  height: 150,
                                  child: FadeInImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                        './assets/images/no-image.png'),
                                    placeholder: AssetImage(
                                        './assets/images/no-image.png'),
                                  ),
                                )
                              : Image.network(
                                  path!,
                                  width: 100,
                                  height: 100,
                                ),
                          TextButton(
                              child: Text('Agregar Imagen'),
                              onPressed: () async {
                                picker = ImagePicker();
                                imagePiker = await picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  path = imagePiker!.path;
                                });
                              }),
                        ],
                      ),
                      Row(children: [
                        Container(
                            width: 100,
                            height: 50,
                            margin: EdgeInsets.all(2),
                            child: RaisedButton(
                              onPressed: () {
                                //Estos if anidados, estan porque de verdad, Dios sabra porque no puede
                                // hacer una comparacion
                                if(codigoProductoController.text!=""){
                                  if(nombreProductoController.text!= ""){
                                    if (precioProductoController.text!=""){
                                      if(cantidadProductoController.text!=""){
                                        if(isvProductoController.text!=""){
                                          isCorrect = pruebaControlador(
                                              codigoProductoController.text,
                                              nombreProductoController.text,
                                              precioProductoController.text,
                                              cantidadProductoController.text,
                                              isvProductoController.text,
                                              descProductoController.text,
                                              isExcento.toString(),
                                              idTipoProductoG,
                                              imagePiker,
                                              context);
                                          if (isCorrect == true){
                                            Navigator.pop(context);
                                            _ventanaExito(context);
                                            initState();
                                          }
                                        } else {
                                          _ventanaError(context);
                                        }
                                      } else{
                                        _ventanaError(context);
                                      }
                                    } else {
                                      _ventanaError(context);
                                    }
                                  } else {
                                    _ventanaError(context);
                                  }
                                } else {
                                  _ventanaError(context);
                                }

                                /*
                                if (isCorrect == true) {
                                  Navigator.pop(context);
                                  _ventanaExito(context);
                                  initState();
                                } else {
                                  _ventanaError(context);
                                }}


                                 */
                                initState();
                              },
                              child: Text('Guardar'),
                              padding: EdgeInsets.all(10),
                            )),
                        Container(
                            width: 100,
                            height: 50,
                            margin: EdgeInsets.all(5),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancelar'),
                              padding: EdgeInsets.all(10),
                            )),
                      ]),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _ventanaNuevaActualizar(
      BuildContext context,
      String idProductoP,
      String codigoProductoP,
      String nombreProductoP,
      String cantidadProductoP,
      String precioProductoP,
      String isvProductoP,
      String descProductoP,
      String isExcentoP,
      String? path,
      String idTipoProductoP) {
    late TextEditingController idProducto =
        TextEditingController(text: idProductoP);
    late TextEditingController codigoProducto =
        TextEditingController(text: codigoProductoP);
    late TextEditingController nombreProducto =
        TextEditingController(text: nombreProductoP);
    late TextEditingController precioProducto =
        TextEditingController(text: precioProductoP);
    late TextEditingController cantidadProducto =
        TextEditingController(text: cantidadProductoP);
    late TextEditingController isvProducto =
        TextEditingController(text: isvProductoP);
    late TextEditingController descProducto =
        TextEditingController(text: descProductoP);
    late TextEditingController isExcento5 =
        TextEditingController(text: isExcentoP);
    idTipoProductoG = idTipoProductoP;
    late TextEditingController idTipoProducto =
        TextEditingController(text: idTipoProductoP);
    if (isExcentoP.toString() == "true") {
      isExceptoN = 1;
    } else {
      isExceptoN = 0;
    }
    pathActualizar = path;
    imagePiker = path;
    bool imagenNueva = false;

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 350,
                            height: 350,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Código Producto",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: codigoProducto,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Precio",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: precioProducto,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "ISV",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                        controller: isvProducto,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Excento",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RadioListTile<int>(
                                            value: 1,
                                            groupValue: isExceptoN,
                                            title: Text('Si'),
                                            onChanged: (value) {
                                              setState(() => isExceptoN = 1);
                                              isExcento2 = true;
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile<int>(
                                              value: 0,
                                              groupValue: isExceptoN,
                                              title: Text('No'),
                                              onChanged: (value) {
                                                setState(() => isExceptoN = 0);
                                                isExcento2 = false;
                                              }),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                          Container(
                            width: 350,
                            height: 350,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Nombre del producto",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: nombreProducto,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Cantidad en existencia",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: cantidadProducto,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Descuento",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: descProducto,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Tipo producto",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    _buscarTipoProducto(),
                                  ]),
                            ),
                          ),
                        ]),
                    Row(
                      children: [
                        (path == null)
                            ? Container(
                                width: 150,
                                height: 150,
                                child: FadeInImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      './assets/images/no-image.png'),
                                  placeholder: AssetImage(
                                      './assets/images/no-image.png'),
                                ),
                              )
                            : Image.network(
                                path!,
                                width: 100,
                                height: 100,
                              ),
                        TextButton(
                            child: Text('Agregar Imagen'),
                            onPressed: () async {
                              picker = ImagePicker();
                              imagePiker = await picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                path = imagePiker!.path;
                                imagenNueva = true;
                              });
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            width: 100,
                            height: 50,
                            margin: EdgeInsets.all(5),
                            child: RaisedButton(
                              onPressed: () {
                                if (imagenNueva == false){
                                  isCorrect = controladorActualizarSinProducto(
                                      idProducto.text,
                                      codigoProducto.text,
                                      nombreProducto.text,
                                      precioProducto.text,
                                      cantidadProducto.text,
                                      isvProducto.text,
                                      descProducto.text,
                                      isExcento2.toString(),
                                      idTipoProductoG,
                                      context
                                  );
                                  if (isCorrect == true) {
                                    initState();
                                    Navigator.pop(context);
                                  } else {
                                    _ventanaError(context);
                                  }
                                  initState();

                                } else {
                                  isCorrect = controladorActualizarConImagen(
                                      idProducto.text,
                                      codigoProducto.text,
                                      nombreProducto.text,
                                      precioProducto.text,
                                      cantidadProducto.text,
                                      isvProducto.text,
                                      descProducto.text,
                                      isExcento2.toString(),
                                      idTipoProductoG,
                                      imagePiker,
                                      context);
                                  if (isCorrect == true) {
                                    _ventanaExito(context);
                                    initState();
                                    Navigator.pop(context);
                                  } else {
                                    _ventanaError(context);
                                  }
                                  initState();
                                }


                              },
                              child: Text('Guardar'),
                              padding: EdgeInsets.all(10),
                            )),
                        Container(
                            width: 100,
                            height: 50,
                            margin: EdgeInsets.all(5),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancelar'),
                              padding: EdgeInsets.all(10),
                            )),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _ventanaError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Container(
              width: 500,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ocurrio un error al realizar esta acción, intente de nuevo.",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                          width: 80,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              //initState();
                            },
                            child: Text('OK'),
                            padding: EdgeInsets.all(10),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                    ]),
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
