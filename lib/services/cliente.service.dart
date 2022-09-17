import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/models/models.dart';

import '../models/cliente.model.dart';

// ignore: non_constant_identifier_names
Future<List<Cliente?>> crearCliente(String dni, String email, String rtn,
    String nombre, String direccion, String telefono, context) async {
  var client = http.Client();
  Cliente? cliente = null;
  List<Cliente?> clienteCreado = [];
  try {
    var response = await http.post(Uri.parse(API_URL + 'cliente/crearCliente'),
        body: ({
          'dni': dni,
          'email': email,
          'rtn': rtn,
          'nombreCliente': nombre,
          'direccion': direccion,
          'telefonoCliente': telefono
        }));
    print(response.body);
    if (response.statusCode == 200) {
      print(Cliente);
      //return clienteCreado;
    } else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('El dni ya esta siendo utilizado')));
    } else {
      // return clienteCreado;
    }
    return clienteCreado;
  } catch (e) {
    return clienteCreado;
  } finally {
    http.Client().close();
  }
}

Future eliminarCliente(String id, String token) async {
  try {
    var response = await http.post(
        Uri.parse(API_URL + 'cliente/eliminarCliente'),
        body: ({'id': id, 'token': token}));
    print(response.body);
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 404) {
      return 404;
    } else if (response.statusCode == 401) {
      return 401;
    } else if (response.statusCode == 500) {
      return 500;
    }
  } catch (e) {
    print(e);
    return 1928;
  } finally {
    http.Client().close();
  }
}

Future<List<Cliente?>> ActualizarCliente(String id, String dni, String email,
    String rtn, String nombre, String direccion, String telefono) async {
  var client = http.Client();
  Cliente? cliente = null;
  List<Cliente?> clienteCreado = [];
  try {
    var response =
        await http.put(Uri.parse(API_URL + "cliente/actualizarCliente"),
            body: ({
              'id': id,
              'dni': dni,
              'rtn': rtn,
              'email': email,
              'nombreCliente': nombre,
              'direccion': direccion,
              'telefonoCliente': telefono
            }));
    print(response.body);
    if (response.statusCode == 200) {
      print(Cliente);
      //return clienteCreado;
    } else {
      // return clienteCreado;
    }
    return clienteCreado;
  } catch (e) {
    return clienteCreado;
  } finally {
    http.Client().close();
  }
}

Future<void> buscarClienteNombre(String nombre, context) async {
  if (nombre.isNotEmpty) {
    var response = await http.post(
        Uri.parse(API_URL + 'cliente/buscarClientePorNombre'),
        body: ({'nombreCliente': nombre}));

    if (response.statusCode == 200) {
      Cliente cliente = clienteFromJson(response.body);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Cliente Creado')));
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Favor llenar todos los campos')));
  }
}

Future traerClientes(String token) async {
  try {
    final response = await http.post(
        Uri.parse(API_URL + 'cliente/traerTodosLosClientes'), body: {'token': token}); ///////////////
    if (response.statusCode == 200) {
      final listaCliente = clienteFromJson(response.body);
      return listaCliente.todoslosClientes;
    } else if (response.statusCode == 404) {
      return 404;
    } else if (response.statusCode == 401) {
      return 401;
    } else if (response.statusCode == 500) {
      return 500;
    }
  } catch (e) {
    return 1928;
  }
}

Future<void> buscarClienteDni(String dni, context) async {
  if (dni.isNotEmpty) {
    var response = await http.post(Uri.parse(API_URL + 'cliente/buscarcliente'),
        body: ({'dni': dni}));

    if (response.statusCode == 200) {
      Cliente cliente = clienteFromJson(response.body);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Cliente encontrado')));
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al encontrar el cliente')));
  }
}
