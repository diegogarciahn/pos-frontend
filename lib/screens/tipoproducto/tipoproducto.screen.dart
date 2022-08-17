import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';

import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/controllers/tipoproducto.controller.dart';
import 'package:soft_frontend/models/Tipoproducto.model.dart';
import 'package:soft_frontend/services/tipoproducto.service.dart';

class PantallaTipoProducto extends StatefulWidget {
  const PantallaTipoProducto({Key? key}) : super(key: key);

  @override
  State<PantallaTipoProducto> createState() => _PantallaTipoProductoState();
}

class _PantallaTipoProductoState extends State<PantallaTipoProducto> {
  int _counter = 0;
  List<Tipoproducto> tipos = <Tipoproducto>[];
  List<Tipoproducto> tiposN = <Tipoproducto>[];
  bool isCorrect = false;

  Future<List<Tipoproducto>> fetchNotes2() async {
    var data = [];
    var url = Uri.parse(API_URL + 'producto/mostrartipos');
    var response = await http.get(url);
    List<Tipoproducto> users = [];

    try {
      if (response.statusCode == 200) {
        var units = (json.decode(response.body)
            as Map<String, dynamic>)['tipoProducto'];
        for (var u in units) {
          Tipoproducto user = Tipoproducto(
              id: u['id'],
              tipoProducto: u['tipoProducto'],
              descripcionProducto: u['descripcionProducto'],
              isvTipoProducto: u['isvTipoProducto']);
          users.add(user);
        }
      } else {
        print('Api error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return users;
  }

  @override
  void initState() {
    fetchNotes2().then((value) {
      tipos.clear();
      tiposN.clear();
      setState(() {
        tipos.addAll(value);
        tiposN.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.maybePop(context).then((value) {
                  if (!value) {
                    Navigator.popAndPushNamed(context, 'mantenimiento/productos');
                  }
                });
              },
              child: Text('Regresar',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ],
          title: Text('Tipos de productos'),
        ),
        body: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 27.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
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
                                    _ventanaCrearTipoProducto(context);
                                  },
                                  child: Text('Agregar'),
                                  padding: EdgeInsets.all(25),
                                )),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: 900,
                  height: 500,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return index == 0 ? _searchBar() : _listItem(index - 1);
                    },
                    itemCount: tiposN.length + 1,
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  _searchBar() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(hintText: 'Buscar tipo producto'),
            onChanged: (text) {
              text = text.toLowerCase();
              setState(() {
                tiposN = tipos.where((note) {
                  var noteTitle = note.tipoProducto.toString().toLowerCase();
                  return noteTitle.contains(text);
                }).toList();
              });
            },
          ),
        ),
        _cabecera(),
      ],
    );
  }

  void _ventanaCrearTipoProducto(BuildContext context) {
    var tipoProductoController = TextEditingController();
    var descripcionProductoController = TextEditingController();
    var isvTipoProductoController = TextEditingController();

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
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Tipo de Producto',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        controller: tipoProductoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Descripción',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        controller: descripcionProductoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'ISV',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        controller: isvTipoProductoController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Escribir en valor decimal.'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            height: 40,
                            margin: EdgeInsets.all(5),
                            child: RaisedButton(
                              onPressed: () {
                                isCorrect = controladorCrearTipoProducto(
                                    tipoProductoController.text,
                                    descripcionProductoController.text,
                                    isvTipoProductoController.text,
                                    context);
                                if (isCorrect == true) {
                                  Navigator.pop(context);
                                  initState();
                                } else {
                                  _ventanaError(context);
                                }
                                initState();
                              },
                              child: Text('Guardar'),
                              padding: EdgeInsets.all(10),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
            ),
          ],
        );
      },
    );
  }

  void _ventanaEliminar(BuildContext context) {
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
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                          width: 80,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: RaisedButton(
                            onPressed: () => EliminarTipoProducto(
                                idTipoProductoController.text, context),
                            child: Text('Eliminar'),
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
      String idTipoProductoP,
      String tipoProductoP,
      String descripcionProductoP,
      String isvTipoProductoP) {
    late TextEditingController idTipoProducto =
        TextEditingController(text: idTipoProductoP);
    late TextEditingController tipoProducto2 =
        TextEditingController(text: tipoProductoP);
    late TextEditingController descripcionProducto =
        TextEditingController(text: descripcionProductoP);
    late TextEditingController isvTipoProducto =
        TextEditingController(text: isvTipoProductoP);

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
                        'Tipo de Producto',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                        controller: tipoProducto2,
                        decoration:
                            InputDecoration(border: UnderlineInputBorder()),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Descripción',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                        controller: descripcionProducto,
                        decoration:
                            InputDecoration(border: UnderlineInputBorder()),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'ISV',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                        controller: isvTipoProducto,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Escribir en valor decimal.'),
                      ),
                      Container(
                          width: 80,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: RaisedButton(
                            onPressed: () {
                              estaCorrecto = controladorActualizarTipoProducto(
                                  idTipoProductoP,
                                  tipoProducto2.text,
                                  descripcionProducto.text,
                                  isvTipoProducto.text,
                                  context);
                              Navigator.popAndPushNamed(
                                  context, 'PantallaTipoProductos');
                              initState();
                            },
                            child: Text('Actualizar'),
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

  void _ventanaProducto(BuildContext context) {
    var tipoProductoController = TextEditingController();
    var descripcionProductoController = TextEditingController();
    var isvImpuestoController = TextEditingController();

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
                        'Tipo de Producto',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                        controller: tipoProductoController,
                        decoration:
                            InputDecoration(border: UnderlineInputBorder()),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Descripción',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                        controller: descripcionProductoController,
                        decoration:
                            InputDecoration(border: UnderlineInputBorder()),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'ISV',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                        controller: isvImpuestoController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Escribir en valor decimal.'),
                      ),
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

  _listItem(index) {
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
                tiposN[index].tipoProducto.toString(),
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                tiposN[index].descripcionProducto.toString(),
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
                flex: 1,
                child: TextButton(
                  child: Text('Actualizar'),
                  onPressed: () {
                    _ventanaActualizar(
                        context,
                        tiposN[index].id.toString(),
                        tiposN[index].tipoProducto.toString(),
                        tiposN[index].descripcionProducto.toString(),
                        tiposN[index].isvTipoProducto.toString());
                  },
                )),
            Expanded(
                flex: 1,
                child: TextButton(
                  child: Text('Eliminar'),
                  onPressed: () {
                    _ventanaEliminar2(context, tiposN[index].id.toString());
                  },
                )),
          ],
        ),
      ),
    );
  }

  _cabecera() {
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
                'Tipo producto',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Descripción',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Descripción',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Descripción',
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
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
                        'Acción realizada con éxito.',
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
                                  context, 'PantallaTipoProductos');
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

  void _ventanaEliminar2(BuildContext context, String idTipoProductoP) {
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
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¿Está seguro de eliminar el tipo de producto?',
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
                                      EliminarTipoProducto(
                                          idTipoProducto.text, context);
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
                        'Ocurrio un error al realizar esta acción, intente de nuevo.',
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
}
