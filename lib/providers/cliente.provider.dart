import 'package:flutter/material.dart';
import 'package:soft_frontend/models/cliente.model.dart';

class ClienteProvider with ChangeNotifier {
  List<TodoslosCliente> _listClientes = [];
  bool _loading = false;

  List<TodoslosCliente> get getlistClientes => _listClientes;

  set setlistClientes(List<TodoslosCliente> listaDeClientes){
    _listClientes = listaDeClientes;
    notifyListeners();
  }

  bool get getloading => _loading;

  set loading(bool loading) {
    
  }
}