import 'package:flutter/material.dart';
import 'package:soft_frontend/models/sucursal.model.dart';

class SucursalProvider with ChangeNotifier {
  List<DetalleSucursal> _listSucursales = [];

  List<DetalleSucursal> get getListSucursales => _listSucursales;

  setListSucursales(List<DetalleSucursal> listSucursales) {
    _listSucursales = listSucursales;
    notifyListeners();
  }

}