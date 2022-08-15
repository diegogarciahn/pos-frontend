import 'dart:convert';
import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soft_frontend/models/gestionrol.model.dart';
import 'package:soft_frontend/models/rolResponse.model.dart';
import '../models/rol.model.dart';
import '../services/rol.service.dart';

//bloc
//provider
//

Future<Rol2?> CreaRol_controller(
    String rol, String descripcion, context) async {
  List<Rol2?> role = await crearRol(rol, descripcion, context);
  
  if (role != null) {
    print('Aca:');
    print(role);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Rol creado con exito")));
    return role[0];
    //Navigator.pushNamed(context, "Traerusuarios");
  }
}

Future<Role?> eliminarrol_Controller(String id, context) async {
  List<Role?> rol = await eliminarRol(id);
  print(id);
  if (rol != null) {
    Navigator.pushNamed(context, "gestionRol");
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Rol eliminado con exito")));
  } else {}
}

Future<Role?> actualizarRole_Controller(
    String id, String rol, String descripcion, context) async {
  if (id.isNotEmpty && rol.isNotEmpty && descripcion.isNotEmpty) {
    List<Role?> Listroles = await ActualizarRole(id, rol, descripcion);
    if (Listroles != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("rol Actualizado con exito")));
      Navigator.pushNamed(context, "gestionRol");
    } else {}
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Campos en blanco")));
  }
}
