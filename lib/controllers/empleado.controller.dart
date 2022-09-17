import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_frontend/models/empleado.model.dart';
import 'package:soft_frontend/screens/globals.components/alertdialogerror.component.dart';
import '../constans.dart';
import '../models/empleado.model.dart';
import '../providers/empleado.provider.dart';
import '../screens/globals.components/snackBar.component.dart';
import '../services/empleado.service.dart';
import '../services/sharepreference.service.dart';

Future<String> esperarToken(BuildContext context) async {
  final token = await getToken().catchError((error) {
    Navigator.pushReplacementNamed(context, 'login');
    const snackBar = SnackBar(
      content: Text('Por favor inicie sesión para acceder al sistema.'),
      backgroundColor: Colors.red,
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
    return '';
  });
  return token;
}

Future obtenerEmpleadosController(context) async {
  final empleadoProvider = Provider.of<EmpleadoProvider>(context, listen: false);
  final token = await esperarToken(context);
  if (token != '') {
    final respuesta = await traerEmpleados(token);
    if (respuesta is Empleado) {
      empleadoProvider.listEmpleados = respuesta.todoslosEmpleados;
    } else {
      switch (respuesta) {
        case 401:
          showSnackBarGlobal('Por favor inicie sesión.', context);
          Navigator.pushReplacementNamed(context, 'login');
          break;
        case 500:
          alertError(context, mensaje: 'Ocurrió un error interno en el servidor, comuníquese con soporte técnico.');
          break;
        case 503:
          alertError(context, mensaje: 'Servicio no disponible, comuníquese con soporte técnico.');
          break;
        default:
      }
    }
  }
}

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
          const SnackBar(content: Text('Empleado empleado añadido con exito')));
      Navigator.pushNamed(context, 'gestionusuarios/empleados');
    } else {}
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Campos en blanco')));
  }
}

Future<Empleado?> actualizaEmpleadoController(
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
          const SnackBar(content: Text('Empleado Actualizado con exito')));
      Navigator.pushNamed(context, 'gestionusuarios/empleados');
    } else {}
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Campos en blanco')));
  }
}

Future eliminarEmpleadoController(String id, context) async {
  List<Empleado?> empleado = await eliminarEmpleado(id);
  print(id);
  if (empleado != null) {
    Navigator.pushNamed(context, 'gestionusuarios/empleados');
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Empleado eliminado con exito')));
  } else {}
}
