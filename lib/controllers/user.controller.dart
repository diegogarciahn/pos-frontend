import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soft_frontend/models/gestionUsuario.model.dart';
import 'package:soft_frontend/providers/login.provider.dart';
import 'package:soft_frontend/screens/globals.components/snackBar.component.dart';
import 'package:soft_frontend/services/login.service.dart';
import 'package:soft_frontend/models/user.model.dart';
import 'package:soft_frontend/services/sharepreference.service.dart';
import 'package:soft_frontend/services/user.service.dart';

Future<bool> excepcion(String msg, SharedPreferences prefs, context) async {
  LoginProvider loginProvider =
      Provider.of<LoginProvider>(context, listen: false);
  loginProvider.loading = false;
  showSnackBarGlobal(msg, context);
  await prefs.setBool('logeado', false);
  return false;
}


Future<bool> loginController(String usuario, String passwd, context) async {
  LoginProvider loginProvider =
      Provider.of<LoginProvider>(context, listen: false);

  if (usuario.isNotEmpty && passwd.isNotEmpty) {
    loginProvider.loading = true;
    final user = await login(usuario, passwd);
    print(user);
    final prefs = await SharedPreferences.getInstance();
    if (user is User) {
      // prefs.setBool('logeado', true);
      Navigator.popAndPushNamed(context, 'inicio');
      await prefs.setBool('logeado', true);
      return true;
    } else {
      switch (user) {
        case 401:
          return excepcion('Usuario o contraseña inválidos.', prefs, context);
        case 404:
          return excepcion('Usuario o contraseña inválidos.', prefs, context);
        case 500:
          return excepcion(
              'Error interno en el servidor, comuniquese con soporte técnico.',
              prefs, context);
        case 503:
          return excepcion(
              'Error 503: servicio no disponible, comuniquese con soporte técnico.',
              prefs, context);
        default:
          return excepcion('Error al iniciar sesión.', prefs, context);
      }
    }
  } else {
    loginProvider.loading = false;
    showSnackBarGlobal('Por favor llene todos lo campos', context);
    return false;
  }
}

Future<bool?> logout_controller(context) async {
  bool connectionResult = await getarqueo();
  print(connectionResult);

  if (connectionResult == true) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Arqueo abierto'),
          content: Text('Cierra los arqueos antes de cerrar sesion'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Ir Pantalla Arqueo'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, 'ventas');
              },
            ),
            ElevatedButton(
              child: Text('Cerrar Ventana'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } else {
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
        const SnackBar(content: Text('Usuario creado con exito')));
    //Navigator.pushNamed(context, "Traerusuarios");
  }
}

Future<Usuario?> eliminarUsuarioController(String id, context) async {
  List<Usuario?> usuario = await eliminarUsuario(id);
  print(id);
  if (Usuario != null) {
    Navigator.pushNamed(context, 'gestionusuarios/usuarios');
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User eliminado con exito')));
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
          const SnackBar(content: Text('Usuario Actualizado con exito')));
      Navigator.pushNamed(context, 'gestionusuarios/usuarios');
    } else {}
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Campos en blanco')));
  }
}
