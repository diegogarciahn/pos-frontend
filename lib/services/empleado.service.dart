import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/models/models.dart';

import '../models/cliente.model.dart';

Future<List<Empleado?>> crearEmpleado(
    String dni,
    String nombre,
    String apellido,
    String direccion,
    String telefono,
    String fechaNacimiento,
    String sexo) async {
  var client = http.Client();
  Empleado? empleado = null;
  List<Empleado?> empleadoCreado = [];
  try {
    var response =
        await client.post(Uri.parse(API_URL + "empleado/crearempleado"),
            body: ({
              'dni': dni,
              'nombre': nombre,
              'apellido': apellido,
              'direccion': direccion,
              'telefono': telefono,
              'fechaNacimiento': fechaNacimiento,
              'sexo': sexo
            }));
    print(response.body);
    if (response.statusCode == 200) {
      print(Empleado);
      //return empleadoCreado;
    } else {
      // return empleadoCreado;
    }
    return empleadoCreado;
  } catch (e) {
    return empleadoCreado;
  } finally {
    client.close();
  }
}
Future traerEmpleados() async {
  try {
    final response = await http.post(Uri.parse(API_URL+"empleado/traerTodosLosEmpleados"));///////////////
    if (response.statusCode == 200) {
      // print(response.request);
      // print(jsonDecode(response.body));
      Empleado listaEmpleados = empleadoFromJson(response.body);
      return listaEmpleados;
    }
  } catch (e) {
    
  }
}

Future<List<Empleado?>> ActualizarEmpleado(String id, String dni, String nombre, String apellido,
    String direccion, String telefono, String fechaNacimiento, String sexo) async {////////////////
  var client = http.Client();
  Empleado? empleado = null;
  List<Empleado?> empleadoCreado = [];
  try {
    var response = await http.put(Uri.parse(API_URL + "empleado/actualizarEmpleado"),
        body: ({
          'id': id,
          'dni': dni,
          'nombre': nombre,
          'apellido': apellido,
          'direccion': direccion,
          'telefono': telefono,
          'fechaNacimiento': fechaNacimiento,
          'sexo': sexo,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      print(Empleado);
      //return clienteCreado;
    } else {
      // return clienteCreado;
    }
    return empleadoCreado;
  } catch (e) {
    return empleadoCreado;
  } finally {
    http.Client().close();
  }
}
Future<List<Empleado?>> eliminarEmpleado(String id) async {
  print(id);
  var client = http.Client();
  Empleado? cliente = null;
  List<Empleado?> empleadoCreado = [];
  try {
    var response = await http.post(Uri.parse(API_URL + "empleado/eliminarEmpleado"),
        body: ({
          'id' : id
        }));
    print(response.body);
    if (response.statusCode == 200) {
      print(Cliente);
      //return clienteCreado;
    } else {
      // return clienteCreado;
    }
    return empleadoCreado;
  } catch (e) {
    print(e);
    return empleadoCreado;
  } finally {
    http.Client().close();
  }
}