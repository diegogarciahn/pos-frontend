import 'package:flutter/material.dart';
import 'package:soft_frontend/models/empleado.model.dart';
import '../models/empleado.model.dart';
import '../services/empleado.service.dart';

Future<Empleado?> crearEmpleado_Controller(
    String dni,
    String nombre,
    String apellido,
    String direccion,
    String telefono,
    String fechaNacimiento,
    String sexo,
    context) async {
  if (dni.isNotEmpty &&
      nombre.isNotEmpty &&
      apellido.isNotEmpty &&
      direccion.isNotEmpty &&
      telefono.isNotEmpty &&
      fechaNacimiento.isNotEmpty &&
      sexo.isNotEmpty) {
    List<Empleado?> empleado = await crearEmpleado(
        dni, nombre, apellido, direccion, telefono, fechaNacimiento, sexo);
    if (empleado != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Empleado empleado añadido con exito")));
          Navigator.pushNamed(context, "traer_empleados");
    } else {}
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Campos en blanco")));
  }
}

Future<Empleado?> actualizaEmpleado_Controller(
    String id,
    String dni,
    String nombre,
    String apellido,
    String direccion,
    String telefono,
    String fechaNacimiento,
    String sexo,
    context) async {
  if (dni.isNotEmpty &&
      nombre.isNotEmpty &&
      fechaNacimiento.isNotEmpty &&
      sexo.isNotEmpty &&
      direccion.isNotEmpty &&
      telefono.isNotEmpty &&
      apellido.isNotEmpty) {
    List<Empleado?> empleado = await ActualizarEmpleado(
        id, dni, nombre, apellido, direccion, telefono, fechaNacimiento, sexo);
    if (empleado != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Empleado Actualizado con exito")));
      Navigator.pushNamed(context, "traer_empleados");
    } else {}
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Campos en blanco")));
  }
}

Future<Empleado?> eliminarEmpleado_Controller(String id, context) async {
  List<Empleado?> empleado = await eliminarEmpleado(id);
  print(id);
  if (empleado != null) {
    Navigator.pushNamed(context, "traer_empleados");
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Empleado eliminado con exito")));
  } else {}
}
