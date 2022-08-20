import 'package:flutter/material.dart';
import 'package:soft_frontend/services/producto.service.dart';

import '../models/Producto.model.dart';

class ProductoProvider with ChangeNotifier {
  String _idTipoProductoG = '';
  List<Producto> _listaProductos = [];

  String get getidTipoProductoG => _idTipoProductoG;
  List<Producto> get getData => _listaProductos;

  set changeIdTipoProducto(String idTipoProducto) {
    _idTipoProductoG = idTipoProducto;
    print('cambió el id');
    print(_idTipoProductoG);
    notifyListeners();
  }

  setData() async{
    print('set data');
    final data = await obtenerProductos();
    if (data.isNotEmpty) {
      _listaProductos.clear();
      _listaProductos = data;
      notifyListeners();
    }
  }

}