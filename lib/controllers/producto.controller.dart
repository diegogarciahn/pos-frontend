import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/providers/producto.provider.dart';
import '../models/Producto.model.dart';
import 'package:soft_frontend/services/sharepreference.service.dart';
import '../models/user.model.dart';
import '../screens/producto/components/ventanaerror.component.dart';
import '../screens/producto/components/ventanaexito.component.dart';
import '../services/producto.service.dart';

var estaCorrecto;

Future expectToken(BuildContext context) async {
  final token = await getToken().catchError((error) {
    return '';
  });
  if (token != '') {
    return token;
  } else {
    Navigator.pushReplacementNamed(context, 'login');
    const snackBar = SnackBar(
      content: Text('Por favor inicie sesión para acceder al sistema.'),
      backgroundColor: Colors.red,
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
  }
}

Future<String> expectSesion(BuildContext context) async {
  final idUser = await usercontroller().catchError((error) {
    return '';
  });
  if (idUser != '') {
    return idUser.sesion.id.toString();
  } else {
    return '';
  }
}

Future<User> usercontroller() async {
  final prefs = await SharedPreferences.getInstance();
  final String? user = prefs.getString('response');
  User userfinal = User.fromJson(user!);
  return userfinal;
}

Future<String> expectUser(BuildContext context) async {
  final idUser = await usercontroller().catchError((error) {
    return '';
  });
  if (idUser != '') {
    return idUser.id.toString();
  } else {
    return '';
  }
}

Future<String> expectIdSesion(BuildContext context) async {
  final idUser = await usercontroller().catchError((error) {
    return '';
  });
  if (idUser != '') {
    return idUser.sesion.id.toString();
  } else {
    return '';
  }
}

bool controladorActualizarSinProducto(
    String idProducto,
    String codigoProducto,
    String nombreProducto,
    String precioProducto,
    String cantidadProducto,
    String isvProducto,
    String descProducto,
    String isExcento,
    String idTipoProducto,
    context) {
  bool funciona = false;
  Producto producto = Producto();
  Future<Producto?> producto2 = actualizaProductoControllerN(
      idProducto,
      codigoProducto,
      nombreProducto,
      precioProducto,
      cantidadProducto,
      isvProducto,
      descProducto,
      isExcento,
      idTipoProducto,
      context);
  if (producto2 != null) {
    funciona = true;
  } else {
    funciona = false;
  }
  return funciona;
}


bool controladorCantidad(
    String codigoProducto, String cantidadProducto, context) {
  bool funciona = false;
  Producto producto = Producto();
  Future<Producto?> producto2 =
      actualizarCantidadController(codigoProducto, cantidadProducto, context);
  if (producto2 != null) {
    funciona = true;
  } else {
    funciona = false;
  }
  return funciona;
}

Future<Producto?> actualizarCantidadController(
    String codigoProducto, String cantidad, context) async {
  if (codigoProducto.isNotEmpty && cantidad.isNotEmpty) {
    List<Producto?> producto =
        await ActualizarSaldo2(codigoProducto, cantidad, context);
    if (producto != null) {
      _ventanaExito(context);
    } else {
      _ventanaError(context);
    }
  } else {
    _ventanaError(context);
  }
}

Future eliminarProductoController(String idProducto, context) async {
  ProductoProvider productoProvider =
      Provider.of<ProductoProvider>(context, listen: false);
  final respuesta = await eliminarProducto(idProducto);
  if (respuesta == 200) {
    ventanaExito(context, titulo: 'Producto eliminado con éxito');
    productoProvider.setData();
  } else if (respuesta == 500) {
    ventanaError(context,
        'Ocurrió un error interno en el servidor, por facor comuniquese con el administrador.');
  } else if (respuesta == 404) {
    ventanaError(context, 'El producto indicado fue removido o no existe.');
  }
}

Future crearProductoController(
    String codigoProducto,
    String nombreProducto,
    String precioProducto,
    String cantidadProducto,
    String isvProducto,
    String descProducto,
    String isExcento,
    String idTipoProducto,
    var pickedFile,
    context) async {
  ProductoProvider productoProvider =
      Provider.of<ProductoProvider>(context, listen: false);
  print(
      '$codigoProducto $nombreProducto $precioProducto $isvProducto $isExcento $idTipoProducto');
  if (codigoProducto.isNotEmpty &&
      nombreProducto.isNotEmpty &&
      precioProducto.isNotEmpty &&
      cantidadProducto.isNotEmpty &&
      isvProducto.isNotEmpty &&
      idTipoProducto.isNotEmpty) {
    final producto = await crearProducto2(
        codigoProducto,
        nombreProducto,
        precioProducto,
        cantidadProducto,
        isvProducto,
        descProducto,
        isExcento,
        idTipoProducto,
        pickedFile,
        context);
    if (producto == 200) {
      ventanaExito(context);
      productoProvider.setData();
    } else if (producto == 500) {
      ventanaError(context,
          'Ocurrió un error interno en el servidor al agregar el producto, comuniquese con el administrador.');
    } else if (producto == 409) {
      ventanaError(context,
          'Ya existe un producto con el código indicado o el código fue usado anteriormente.');
    }
  } else {
    _ventanaError(context);
  }
}

Future actualizarProductoController(
    String id,
    String codigoProducto,
    String nombreProducto,
    String precioProducto,
    String cantidadProducto,
    String isvProducto,
    String descProducto,
    String isExcento,
    String idTipoProducto,
    var pickedFile,
    context) async {
  ProductoProvider productoProvider =
      Provider.of<ProductoProvider>(context, listen: false);
  final respuesta = await actualizarProducto(
      id,
      codigoProducto,
      nombreProducto,
      precioProducto,
      cantidadProducto,
      isvProducto,
      descProducto,
      isExcento,
      idTipoProducto,
      pickedFile,
      context);
  if (respuesta == 200) {
    ventanaExito(context, titulo: 'Producto actualizado exitosamente');
    productoProvider.setData();
  } else if (respuesta == 500) {
    ventanaError(context,
        'Ocurrió un error al actualizar el producto, comuniquese con el administrador');
  } else if (respuesta == 409) {
    ventanaError(context,
          'Ya existe un producto con el código indicado o el código fue usado anteriormente.');
  }
}

Future<Producto?> actualizaProductoControllerN(
    String id,
    String codigoProducto,
    String nombreProducto,
    String precioProducto,
    String cantidadProducto,
    String isvProducto,
    String descProducto,
    String isExcento,
    String idTipoProducto,
    context) async {
  if (id.isNotEmpty &&
      codigoProducto.isNotEmpty &&
      nombreProducto.isNotEmpty &&
      precioProducto.isNotEmpty &&
      cantidadProducto.isNotEmpty &&
      isvProducto.isNotEmpty &&
      descProducto.isNotEmpty &&
      isExcento.isNotEmpty &&
      idTipoProducto.isNotEmpty) {
    bool funciona = false;
    List<Producto?> producto = await ActualizarProductoSinImagen(
        id,
        codigoProducto,
        nombreProducto,
        precioProducto,
        cantidadProducto,
        isvProducto,
        descProducto,
        isExcento,
        idTipoProducto,
        context);
    if (producto != null) {
      _ventanaExito(context);
    } else {
      _ventanaError(context);
    }
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
                                context, 'PantallaProductos');
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
