import 'package:flutter/material.dart';
import 'package:soft_frontend/models/talonario.model.dart';

class TalonariosProvider with ChangeNotifier {
  List<Talonario> _listTalonarios = [];

  List<Talonario> get getListTalonarios => _listTalonarios;

  setListTalonarios(List<Talonario> listTalonarios) {
    _listTalonarios = listTalonarios;
    notifyListeners();
  }

}