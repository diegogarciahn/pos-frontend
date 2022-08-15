import 'package:flutter/material.dart';
import 'package:soft_frontend/models/Tipoproducto.model.dart';
import '../services/tipoproducto.service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:soft_frontend/screens/tipoproducto/tipoproducto.screen.dart';
import '../screens/tipoproducto/tipoproducto.screen.dart' as global;

var estaCorrecto;
bool controladorCrearTipoProducto(String tipoproducto,
    String descripcionProducto, String isvTipoProducto, context) {
  bool funciona = false;
  Tipoproducto tipoProducto = Tipoproducto();
  Future<Tipoproducto?> producto2 = crearTipoProductoController(
      tipoproducto, descripcionProducto, isvTipoProducto, context);
  if (producto2 != null) {
    funciona = true;
  } else {
    funciona = false;
  }
  return funciona;
}

bool controladorActualizarTipoProducto(String id, String tipoproducto,
    String descripcionProducto, String isvTipoProducto, context) {
  bool funciona = false;
  Tipoproducto tipoProducto = Tipoproducto();
  Future<Tipoproducto?> producto2 = actualizarTipoProductoController(
      id, tipoproducto, descripcionProducto, isvTipoProducto, context);
  if (producto2 == null) {
    funciona = true;
  } else {
    funciona = false;
  }
  return funciona;
}

Future<Tipoproducto?> crearTipoProductoController(String tipoproducto2,
    String descripcionProducto, String isvTipoProducto, context) async {
  if (tipoproducto2.isNotEmpty &&
      descripcionProducto.isNotEmpty &&
      isvTipoProducto.isNotEmpty) {
    List<Tipoproducto?> producto = await crearTipoProducto2(
        tipoproducto2, descripcionProducto, isvTipoProducto, context);
    if (producto != null) {
      _ventanaExito(context);
    } else {
      _ventanaError(context);
    }
  } else {
    _ventanaError(context);
  }
}

Future<Tipoproducto?> actualizarTipoProductoController(
    String id,
    String tipoproducto2,
    String descripcionProducto,
    String isvTipoProducto,
    context) async {
  if (id.isNotEmpty &&
      tipoproducto2.isNotEmpty &&
      descripcionProducto.isNotEmpty &&
      isvTipoProducto.isNotEmpty) {
    Tipoproducto? producto = await ActualizarTipoProducto(
        id, tipoproducto2, descripcionProducto, isvTipoProducto, context);
    if (producto != null) {
      _ventanaExito(context);
    } else {
      _ventanaError(context);
    }
    return producto;
  } else {
    _ventanaError(context);
  }
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
                            Navigator.popAndPushNamed(
                                context, 'PantallaTipoProductos');
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
