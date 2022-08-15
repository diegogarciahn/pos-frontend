// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/user.controller.dart';
import 'package:soft_frontend/screens/screens.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class PantallaGestionPrincipal extends StatefulWidget {
  const PantallaGestionPrincipal({Key? key}) : super(key: key);

  @override
  State<PantallaGestionPrincipal> createState() =>
      _PantallaGestionPrincipalState();
}

class _PantallaGestionPrincipalState extends State<PantallaGestionPrincipal> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: logeado(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Login();
          } else {
            return FutureBuilder<User>(
                future: usercontroller(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return _Pantalla(
                      size: size,
                      user: snapshot.data,
                    );
                  }
                });
          }
        });
  }
}

class _Pantalla extends StatelessWidget {
  const _Pantalla({required this.size, required this.user});
  final User? user;
  final Size size;
  @override
  Widget build(BuildContext context) {
    final int? cantidadPermisos = user?.rol.permisos.length;
    final List<int?> permisosId = <int>[];

    for (int i = 0; i < cantidadPermisos!; i++) {
      permisosId.add(user?.rol.permisos[i].id);
    }

    for (int i = 0; i < permisosId.length; i++) {
      print(permisosId[i]);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading :false,
        title: Text("Modulo Gestion de Usuarios"),
         actions: <Widget>[
          TextButton(
            
            onPressed: () {
              Navigator.popAndPushNamed(context, 'pantalla_principal');
            },
            child: Text("Regresar",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xffF3F3F3),
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Modulo de Gestion de usuarios',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (permisosId.contains(12)) ...[
                Visibility(
                    visible: true,
                    child: TextButtons(
                      img: 'empleado.png',
                      name: 'Empleados',
                      route: 'traer_empleados',
                      width: 0.2,
                      fontSize: 15,
                    )),
              ],
              SizedBox(
                width: 30,
              ),
              if (permisosId.contains(43)) ...[
                Visibility(
                  visible: true,
                  child: TextButtons(
                    img: 'agregar.png',
                    name: 'Usuarios',
                    route: 'gestionUsuarios',
                    width: 0.2,
                    fontSize: 15,
                  ),
                ),
              ],
              SizedBox(
                width: 30,
              ),
              if (permisosId.contains(28)) ...[
                Visibility(
                  visible: true,
                  child: TextButtons(
                    img: 'tareas.png',
                    name: 'Rol',
                    route: 'gestionRol',
                    width: 0.2,
                    fontSize: 15,
                  ),
                ),
              ],
            ]),
          ]),
        ),
      ),
    );
  }
}
