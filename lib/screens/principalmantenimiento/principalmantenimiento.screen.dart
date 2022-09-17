// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_single_quotes

import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/user.controller.dart';
import 'package:soft_frontend/screens/screens.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class PantallaMantenimientoPrincipal extends StatefulWidget {
  const PantallaMantenimientoPrincipal({Key? key}) : super(key: key);

  @override
  State<PantallaMantenimientoPrincipal> createState() =>
      _PantallaMantenimientoPrincipalState();
}

class _PantallaMantenimientoPrincipalState
    extends State<PantallaMantenimientoPrincipal> {
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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Modulo de Mantenimiento"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.01, vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).focusColor),
              onPressed: () {
                Navigator.popAndPushNamed(context, 'inicio');
              },
              child: Text("Regresar",),
            ),
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
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (permisosId.contains(8)) ...[
                Visibility(
                    visible: true,
                    child: TextButtons(
                      img: 'satisfied.png',
                      name: 'Clientes',
                      route: 'mantenimiento/clientes',
                      width: 0.2,
                      fontSize: 15,
                    )),
              ],
              SizedBox(
                width: 30,
              ),
              if (permisosId.contains(24)) ...[
                Visibility(
                  visible: true,
                  child: TextButtons(
                    img: 'inventario.png',
                    name: 'Productos',
                    route: 'mantenimiento/productos',
                    width: 0.2,
                    fontSize: 15,
                  ),
                ),
              ],
              SizedBox(
                width: 30,
              ),
              if (permisosId.contains(32)) ...[
                Visibility(
                  visible: true,
                  child: TextButtons(
                    img: 'talonario-de-cheques.png',
                    name: 'Talonarios',
                    route: 'mantenimiento/talonarios',
                    width: 0.2,
                    fontSize: 15,
                  ),
                ),
              ],
              SizedBox(
                width: 30,
              ),
              if (permisosId.contains(32)) ...[
                Visibility(
                  visible: true,
                  child: TextButtons(
                    img: 'edificio-de-oficinas.png',
                    name: 'Sucursal',
                    route: 'mantenimiento/sucursal',
                    width: 0.2,
                    fontSize: 15,
                  ),
                ),
              ],
              SizedBox(
                width: 30,
              ),
              if (permisosId.contains(14)) ...[
                Visibility(
                  visible: true,
                  child: TextButtons(
                    img: 'metodo-de-pago.png',
                    name: 'Metodo de pago',
                    route: 'mantenimiento/tipopagos',
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
