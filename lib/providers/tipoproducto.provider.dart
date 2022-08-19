import 'package:flutter/material.dart';
import 'package:soft_frontend/models/Tipoproducto.model.dart';

class TipoProductoProvider with ChangeNotifier {
  List<Tipoproducto> _listTipoProducto = [];

  List<Tipoproducto> get getListTipoProducto => _listTipoProducto;

  setListTipoProducto(List<Tipoproducto> listaTipoProducto) {
    _listTipoProducto.clear();
    _listTipoProducto = listaTipoProducto;
    notifyListeners();
  }
}
