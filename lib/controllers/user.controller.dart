import 'dart:convert';
import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soft_frontend/models/gestionUsuario.model.dart';
import 'package:soft_frontend/screens/login/login.screen.dart';
import 'package:soft_frontend/screens/pantallaPrincipal/principal.screen.dart';
import 'package:soft_frontend/services/login.service.dart';
import 'package:soft_frontend/models/user.model.dart';
import 'package:soft_frontend/services/sharepreference.service.dart';
import 'package:soft_frontend/services/user.service.dart';

Future<bool> login_controller(String usuario, String passwd, context) async {
  if (usuario.isNotEmpty && passwd.isNotEmpty) {
    User? user = await login(usuario, passwd);
    final prefs = await SharedPreferences.getInstance();
    if (user != null) {
      Navigator.popAndPushNamed(context, 'pantalla_principal');
      await prefs.setBool('logeado', true);
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al iniciar Sesion')));
      await prefs.setBool('logeado', false);
      return false;
    }
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('LLenar todos lo campos')));
    return false;
  }
}

Future<bool?> logout_controller(context) async {
  bool connectionResult = await getarqueo();
  print(connectionResult);
  
  if (connectionResult == true){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Arqueo abierto"),
          content: Text("Cierra los arqueos antes de cerrar sesion"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Ir Pantalla Arqueo"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, 'ventas');
              },
            ),
            ElevatedButton(
              child: Text("Cerrar Ventana"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }else{
  bool? user = await logout();
  if (user != null) {
    final prefs = await SharedPreferences.getInstance();
    final nologin = await prefs.remove('logeado');
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, 'login');
    return true;
  } else {
    return false;
  }
  }
}

Future<User> usercontroller() async {
  final prefs = await SharedPreferences.getInstance();
  final String? user = prefs.getString('response');
  User userfinal = User.fromJson(user!);
  return userfinal;
}

Future<bool?> logeado() async {
  final prefs = await SharedPreferences.getInstance();
  final bool? logeado = prefs.getBool('logeado');
  if (logeado == true) {
    return true;
  } else {
    return null;
  }
}

Future<User?> crearUsuario_Controller(
    String id,
    String usuario,
    String password,
    String email,
    String idEmpleado,
    String idRol,
    context) async {
  List<User?> user =
      await crearUser(usuario, password, email, idEmpleado, idRol);

  if (user != null) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario creado con exito")));
    //Navigator.pushNamed(context, "Traerusuarios");
  }
}

Future<Usuario?> eliminarUsuario_Controller(String id, context) async {
  List<Usuario?> usuario = await eliminarUsuario(id);
  print(id);
  if (Usuario != null) {
    Navigator.pushNamed(context, "gestionUsuarios");
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User eliminado con exito")));
  } else {}
}

Future<Usuario?> actualizarUsuario_Controller(
    String id,
    String usuario,
    //String password,
    String email,
    //String idEmpleado,
    String idRol,
    context) async {
  if (id.isNotEmpty &&
      usuario.isNotEmpty &&
      //password.isNotEmpty &&
      email.isNotEmpty &&
      //idEmpleado.isNotEmpty &&
      idRol.isNotEmpty) {
    List<Usuario?> Listusuario = await ActualizarUsuario(
        id, usuario, /*password,*/ email, /*idEmpleado,*/ idRol);
    if (Listusuario != null) {
      print(usuario);
      //print(password);
      print(email);
      //print(idEmpleado);
      print(idRol);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Usuario Actualizado con exito")));
      Navigator.pushNamed(context, "gestionUsuarios");
    } else {}
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Campos en blanco")));
  }
}
