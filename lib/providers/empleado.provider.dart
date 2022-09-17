import 'package:flutter/material.dart';

import '../models/empleado.model.dart';

class EmpleadoProvider with ChangeNotifier {
  List<TodoslosEmpleados> _listEmpleados = [];

  List<TodoslosEmpleados> get listEmpleados => _listEmpleados;

  set listEmpleados(List<TodoslosEmpleados> listaEmpleados) {
    _listEmpleados = listaEmpleados;
    notifyListeners();
  }
}