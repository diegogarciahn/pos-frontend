import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:soft_frontend/models/Producto.model.dart';
import 'package:soft_frontend/providers/producto.provider.dart';
import 'dart:convert';
import '../constans.dart';

Future<List<Producto>> obtenerProductos() async {
  var url = Uri.parse(API_URL + 'producto/mostrarproductos');
  var response = await http.get(url);
  List<Producto> listadoProductos = [];
  try {
    if (response.statusCode == 200) {
      var units =
          (json.decode(response.body) as Map<String, dynamic>)['producto'];
      for (var u in units) {
        int idString = (u['id']);
        int cantidadProductoString = (u['cantidadProducto']);
        String precioString = (u['precioProducto']).toString();
        String isvString = (u['isvProducto'].toString());
        String descString = (u['descProducto'].toString());
        String urlImage = (u['image'].toString());
        bool isExcentoString = (u['isExcento']);
        int idTipoProductoString = (u['idTipoProducto']);

        Producto producto = Producto(
            id: idString,
            codigoProducto: u['codigoProducto'],
            nombreProducto: u['nombreProducto'],
            precioProducto: precioString,
            cantidadProducto: cantidadProductoString,
            isvProducto: isvString,
            descProducto: descString,
            isExcento: isExcentoString,
            urlImage: (urlImage != '') ? urlImage : '',
            idTipoProducto: idTipoProductoString);
        listadoProductos.add(producto);
      }
    } else {
      print('Api error');
    }
  } on Exception catch (e) {
    print('error: $e');
  }
  return listadoProductos;
}

Future crearProducto2(
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
  ProductoProvider productoProvider = Provider.of<ProductoProvider>(context, listen: false);
  if (pickedFile != '') {
    var headers = {
      'Content-Type': 'application/json;',
      'Host': 'multipart/form-data',
      'Accept': '*/*',
      'Connection': 'keep-alive',
    };
    print(codigoProducto);
    print(pickedFile!.path);
    var stream = http.ByteStream(pickedFile.openRead());
    stream.cast();
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(API_URL + 'producto/crearproducto'));
      request.headers.addAll(headers);
      Uint8List path = await pickedFile.readAsBytes();
      List<int> listData = path.cast();
      print(pickedFile.name);
      request.fields['codigoProducto'] = codigoProducto;
      request.fields['nombreProducto'] = nombreProducto;
      request.fields['precioProducto'] = precioProducto;
      request.fields['cantidadProducto'] = cantidadProducto;
      request.files.add(http.MultipartFile.fromBytes('image', listData,
          filename: pickedFile.name));
      request.fields['isvProducto'] = isvProducto;
      request.fields['descProducto'] = descProducto;
      request.fields['isExcento'] = isExcento;
      request.fields['idTipoProducto'] = idTipoProducto;
      var response = await request.send();
      response.stream.bytesToString().asStream().listen((event) {
        var parsedJson = json.decode(event);
        print(parsedJson);
        print(response.statusCode);
      });
      if (response.statusCode == 200) {
        print(Producto);
        return 200;
      } else if (response.statusCode == 500) {
        print('ocurrió un error');
        return 500;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      return 1928;
    }
  } else {
    try {
      var response =
          await http.post(Uri.parse(API_URL + 'producto/crearproducto'),
              body: ({
                'codigoProducto': codigoProducto,
                'nombreProducto': nombreProducto,
                'precioProducto': precioProducto,
                'cantidadProducto': cantidadProducto,
                'isvProducto': isvProducto,
                'descProducto': descProducto,
                'isExcento': isExcento,
                'idTipoProducto': idTipoProducto,
              }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(200);
        productoProvider.changeIdTipoProducto = '';
        return 200;
      } else if (response.statusCode == 500) {
        print(500);
        return 500;
      } else if (response.statusCode == 404) {
        return 404;
      } else if (response.statusCode == 409) {
        return 409;
      }
    } catch (e) {
      print(e);
      return 1928;
    }
  }
}

Future actualizarProducto(
    String idProducto,
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
      ProductoProvider productoProvider = Provider.of<ProductoProvider>(context, listen: false);
  if (pickedFile != '') {
    var headers = {
      'Content-Type': 'application/json;',
      'Host': 'multipart/form-data',
      'Accept': '*/*',
      'Connection': 'keep-alive',
    };
    var stream = http.ByteStream(pickedFile.openRead());
    stream.cast();
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(API_URL + 'producto/actualizarproducto'));
      request.headers.addAll(headers);
      Uint8List path = await pickedFile.readAsBytes();
      List<int> listData = path.cast();
      request.fields['id'] = idProducto;
      request.fields['codigoProducto'] = codigoProducto;
      request.fields['nombreProducto'] = nombreProducto;
      request.fields['precioProducto'] = precioProducto;
      request.fields['cantidadProducto'] = cantidadProducto;
      request.files.add(http.MultipartFile.fromBytes('image', listData,
          filename: pickedFile.name));
      request.fields['isvProducto'] = isvProducto;
      request.fields['descProducto'] = descProducto;
      request.fields['isExcento'] = isExcento;
      request.fields['idTipoProducto'] = idTipoProducto;
      var response = await request.send();
      response.stream.bytesToString().asStream().listen((event) {
        var parsedJson = json.decode(event);
        print(parsedJson);
        print(response.statusCode);
      });
      if (response.statusCode == 200) {
        productoProvider.changeIdTipoProducto = '';
        return 200;
      } else if (response.statusCode == 404) {
        return 404;
      } else if (response.statusCode == 500) {
        return 500;
      }
    } catch (e) {
      print(e);
      return 1928;
    } finally {
      http.Client().close();
    }
  } else {
    try {
      var response =
          await http.post(Uri.parse(API_URL + 'producto/actualizarproducto/'),
              body: ({
                'id': idProducto,
                'codigoProducto': codigoProducto,
                'nombreProducto': nombreProducto,
                'precioProducto': precioProducto,
                'cantidadProducto': cantidadProducto,
                'isvProducto': isvProducto,
                'descProducto': descProducto,
                'isExcento': isExcento,
                'idTipoproducto': idTipoProducto,
              }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        productoProvider.changeIdTipoProducto = '';
        return 200;
      } else if (response.statusCode == 404) {
        return 404;
      } else if (response.statusCode == 500) {
        return 500;
      }
    } catch (e) {
      print(e);
      return 1928;
    }
  }
}

Future<void> ActualizarSaldo(
    String codigoProducto, String cantidadProducto, context) async {
  var response = await http.post(
      Uri.parse(API_URL + 'producto/actualizarsaldo'),
      body: ({
        'codigoProducto': codigoProducto,
        'cantidadProducto': cantidadProducto
      }));

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Producto Actualizado.')));
  }
}

Future eliminarProducto(String idProducto) async {
  try {
    var response =
        await http.post(Uri.parse(API_URL + 'producto/eliminarproducto'),
            body: ({
              'id': idProducto,
            }));

    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 500) {
      return 500;
    } else if (response.statusCode == 404) {
      return 404;
    }
  } catch (e) {
    print(e);
    return 1928;
  }
}

Future<Producto> buscarProducto(String codigoProductoR, context) async {
  Producto productoBuscado = Producto(
      id: 1,
      codigoProducto: '2',
      nombreProducto: 'm',
      precioProducto: '12',
      cantidadProducto: 1,
      isvProducto: 'asda',
      descProducto: '21',
      isExcento: false,
      urlImage: 'sda',
      idTipoProducto: 1);
  if (codigoProductoR.isNotEmpty) {
    var response = await http.post(
        Uri.parse(API_URL + 'producto/buscarproductoxcodigo'),
        body: ({'codigoProducto': codigoProductoR}));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      var units =
          (json.decode(response.body) as Map<String, dynamic>)['producto'];
      int idString = (units['id']);
      String precioString = (units['precioProducto']).toString();
      int cantidadProductoString = (units['cantidadProducto']);
      String isvString = (units['isvProducto'].toString());
      String descString = (units['descProducto'].toString());
      bool isExcentoString = (units['isExcento']);
      int idTipoProductoString = (units['idTipoProducto']);
      String codigoProducto = units['codigoProducto'];
      String nombreProducto = units['nombreProducto'];

      Producto nuevoProducto = Producto(
          id: idString,
          codigoProducto: codigoProducto,
          nombreProducto: nombreProducto,
          precioProducto: precioString,
          cantidadProducto: cantidadProductoString,
          isvProducto: isvString,
          descProducto: descString,
          isExcento: isExcentoString,
          idTipoProducto: idTipoProductoString);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Producto encontrado')));
      return nuevoProducto;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto no encontrado.')));
      productoBuscado.nombreProducto = 'No encontrado';
      productoBuscado.codigoProducto = 'No encontrado';
      return productoBuscado;
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al encontrar el producto')));
    productoBuscado.nombreProducto = 'No encontrado';
    return productoBuscado;
  }
}

Future<List<Producto?>> eliminarProducto2(String id) async {
  Producto? producto = null;
  List<Producto?> productoCreado = [];
  try {
    var response = await http.post(
        Uri.parse(API_URL + 'producto/eliminarproducto'),
        body: ({'id': id}));
    print(response.body);
    if (response.statusCode == 200) {
    } else {}
    return productoCreado;
  } catch (e) {
    print(e);
    return productoCreado;
  } finally {}
}

Future<List<Producto?>> ActualizarSaldo2(
    String codigoProducto, String cantidadProducto, context) async {
  Producto? producto = null;
  List<Producto?> productoC = [];
  try {
    var response = await http.post(
        Uri.parse(API_URL + 'producto/actualizarsaldo'),
        body: ({
          'codigoProducto': codigoProducto,
          'cantidadProducto': cantidadProducto
        }));

    if (response.statusCode == 200) {
    } else {}
    return productoC;
  } catch (e) {
    print(e);
    return productoC;
  }
}

Future<List<Producto?>> ActualizarProductoSinImagen(
    String idProducto,
    String codigoProducto,
    String nombreProducto,
    String precioProducto,
    String cantidadProducto,
    String isvProducto,
    String descProducto,
    String isExcento,
    String idTipoProducto,
    context) async {
  Producto? producto = null;
  List<Producto?> productoC = [];
  try {
    var response =
        await http.post(Uri.parse(API_URL + 'producto/actualizarsinimagen'),
            body: ({
              'id': idProducto,
              'codigoProducto': codigoProducto,
              'nombreProducto': nombreProducto,
              'precioProducto': precioProducto,
              'cantidadProducto': cantidadProducto,
              'isvProducto': isvProducto,
              'descProducto': descProducto,
              'isExcento': isExcento,
              'idTipoproducto': idTipoProducto,
            }));
    print(response.body);
    if (response.statusCode == 200) {
      print(producto);
    } else {}
    return productoC;
  } catch (e) {
    return productoC;
  } finally {}
}

class UserApi {
  static Future<List<Tipoproducto2>> obtenerTipos(String query) async {
    final url = Uri.parse(API_URL + 'producto/mostrartipos');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List tipos =
          (json.decode(response.body) as Map<String, dynamic>)['tipoProducto'];
      return tipos.map((json) => Tipoproducto2.fromJson(json)).where((tipos) {
        final nameLower = tipos.tipoProducto.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

// ????

class Tipoproducto2 {
  final String tipoProducto;
  final String isvTipoProducto;
  final int id;
  final String descripcionProducto;

  const Tipoproducto2({
    required this.id,
    required this.tipoProducto,
    required this.descripcionProducto,
    required this.isvTipoProducto,
  });

  static Tipoproducto2 fromJson(Map<String, dynamic> json) => Tipoproducto2(
        id: json['id'],
        tipoProducto: json['tipoProducto'],
        descripcionProducto: json['descripcionProducto'],
        isvTipoProducto: json['isvTipoProducto'],
      );
}
