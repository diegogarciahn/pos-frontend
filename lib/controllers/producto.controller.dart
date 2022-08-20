import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/providers/producto.provider.dart';
import 'package:soft_frontend/services/sharepreference.service.dart';
import '../models/user.model.dart';
import '../screens/producto/components/ventanaerror.component.dart';
import '../screens/producto/components/ventanaexito.component.dart';
import '../services/producto.service.dart';

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

Future actualizarExistenciaController(
    String codigoProducto, String cantidad, context) async {
  ProductoProvider productoProvider = Provider.of<ProductoProvider>(context, listen: false);
  if (codigoProducto.isNotEmpty && cantidad.isNotEmpty) {
    final respuesta =
        await actualizarExistencia(codigoProducto, cantidad);
    if (respuesta == 200) {
      ventanaExito(context);
      productoProvider.setData();
      productoProvider.changeIdTipoProducto = '';
    } else if (respuesta == 404) {
      ventanaError(context, mensaje: 'No existe el producto especificado.');
    } else if (respuesta == 500) {
      ventanaError(context, mensaje: 'Ocurrió un error interno del servidor, comuniquese con el administrador.');
    }
  } else {
    ventanaError(context, mensaje: 'Por favor complete todos los campos.');
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
        mensaje: 'Ocurrió un error interno en el servidor, por facor comuniquese con el administrador.');
  } else if (respuesta == 404) {
    ventanaError(context, mensaje: 'El producto indicado fue removido o no existe.');
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
        pickedFile);
    if (producto == 200) {
      ventanaExito(context);
      productoProvider.changeIdTipoProducto = '';
      productoProvider.setData();
    } else if (producto == 500) {
      ventanaError(context,
          mensaje: 'Ocurrió un error interno en el servidor al agregar el producto, comuniquese con el administrador.');
    } else if (producto == 409) {
      ventanaError(context,
          mensaje: 'Ya existe un producto con el código indicado o el código fue usado anteriormente.');
    }
  } else {
    ventanaError(context,
        mensaje: 'Ocurrió un error al crear el producto. Comuniquese con el administrador.');
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
      pickedFile);
  if (respuesta == 200) {
    ventanaExito(context, titulo: 'Producto actualizado exitosamente');
    productoProvider.changeIdTipoProducto = '';
    productoProvider.setData();
  } else if (respuesta == 500) {
    ventanaError(context,
        mensaje: 'Ocurrió un error al actualizar el producto, comuniquese con el administrador');
  } else if (respuesta == 409) {
    ventanaError(context,
        mensaje: 'Ya existe un producto con el código indicado o el código fue usado anteriormente.');
  }
}