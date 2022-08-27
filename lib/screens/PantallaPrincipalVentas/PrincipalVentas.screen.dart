// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/user.controller.dart';
import 'package:soft_frontend/screens/screens.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';
import 'package:soft_frontend/controllers/Arqueo.controller.dart';

class PantallaPrincipalVenta extends StatefulWidget {
  const PantallaPrincipalVenta({Key? key}) : super(key: key);

  @override
  State<PantallaPrincipalVenta> createState() => _PantallaPrincipalVentaState();
}

class _PantallaPrincipalVentaState extends State<PantallaPrincipalVenta> {
  @override
  void initState() {
    validarArqueoActivoController(context);
    super.initState();
  }

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
        title: Text('Modulo Ventas'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.maybePop(context).then((value) => {
                (!value)
                ?Navigator.popAndPushNamed(context, 'pantalla_principal')
                :null
                });
            },
            child: Text('Regresar',
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Modulo de Ventas',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (permisosId.contains(44)) ...[
                Visibility(
                    visible: true,
                    child: TextButtons(
                      img: 'salario.png',
                      name: 'Nueva Venta',
                      route: 'ventas',
                      width: 0.3,
                      fontSize: 18,
                    )),
              ],
              SizedBox(
                width: 30,
              ),
              if (permisosId.contains(15)) ...[
                Visibility(
                  visible: true,
                  child: TextButtons(
                    img: 'notas.png',
                    name: 'Facturacion',
                    route: 'ventas/facturas',
                    width: 0.3,
                    fontSize: 18,
                  ),
                ),
              ],
              SizedBox(
                width: 30,
              ),
              if (permisosId.contains(15)) ...[
                Visibility(
                  visible: true,
                  child: TextButtons(
                    img: 'venta-cruzada.png',
                    name: 'Procesar Ventas',
                    route: 'mostrar_ventas',
                    width: 0.3,
                    fontSize: 18,
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
