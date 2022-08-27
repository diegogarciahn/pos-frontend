import 'package:flutter/material.dart';
import 'package:soft_frontend/models/tipoPagoBuscado.model.dart';

class TipoPagoProvider with ChangeNotifier {
  bool _loading = false;
  List<TipoPagoBuscado> _listTipoPago = [];

  bool get loading => _loading;
  List<TipoPagoBuscado> get getListTipoPago => _listTipoPago;
  
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set setListTipoPago(List<TipoPagoBuscado> listTipoPago) {
    _listTipoPago.clear();
    _listTipoPago = listTipoPago;
    notifyListeners();
  }

}