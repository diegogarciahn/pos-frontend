import 'dart:convert';
import 'dart:js_util';
import 'package:flutter/material.dart';
import '../models/cliente.model.dart';
import '../services/cliente.service.dart';

Future<Cliente?> crearCliente_Controller(
    String dni,
    String email,
    String rtn,
    String nombreCliente,
    String direccion,
    String telefonoCliente,
    context) async {
  if (dni.isNotEmpty &&
      nombreCliente.isNotEmpty &&
      direccion.isNotEmpty &&
      telefonoCliente.isNotEmpty) {
    List<Cliente?> cliente = await crearCliente(
        dni, email, rtn, nombreCliente, direccion, telefonoCliente, context);
    if (cliente != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cliente añadido con exito")));
      Navigator.pushNamed(context, "traer_clientes");
    } else {
      /////
     }
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Campos en blanco")));
  }
}

Future<Cliente?> eliminarCliente_Controller(String id,context) async {
  List<Cliente?> cliente = await eliminarCliente(id);
  print(id);
  if (cliente != null) {
    Navigator.pushNamed(context, "traer_clientes");
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cliente eliminado con exito")));
  } else {}
}

Future<Cliente?> actualizarCliente_Controller(
    String id,
    String dni,
    String email,
    String rtn,
    String nombreCliente,
    String direccion,
    String telefonoCliente,
    context) async {
  if (dni.isNotEmpty &&
      nombreCliente.isNotEmpty &&
      direccion.isNotEmpty &&
      telefonoCliente.isNotEmpty) {
    List<Cliente?> cliente = await ActualizarCliente(
        id, dni, email, rtn, nombreCliente, direccion, telefonoCliente);
    if (cliente != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cliente Actualizado con exito")));
      Navigator.pushNamed(context, "traer_clientes");
    } else if(cliente == null){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se actualizó el Cliente!')));
    }
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Campos en blanco")));
  }
}
