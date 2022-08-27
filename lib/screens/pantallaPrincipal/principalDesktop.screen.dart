import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/user.controller.dart';
import 'package:soft_frontend/services/sharepreference.service.dart';
import '../../controllers/Arqueo.controller.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class PantallaPrincipalDesktop extends StatefulWidget {
  const PantallaPrincipalDesktop({Key? key}) : super(key: key);

  @override
  State<PantallaPrincipalDesktop> createState() =>
      _PantallaPrincipalDesktopState();
}

class _PantallaPrincipalDesktopState extends State<PantallaPrincipalDesktop> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<User>(
        future: usercontroller(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
                child: PantallaDesktop(size: size, user: snapshot.data));
          }
        });
  }
}

class PantallaDesktop extends StatelessWidget {
  const PantallaDesktop({required this.size, required this.user});
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
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.01, vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).focusColor),
              onPressed: () {
                _showDialog(context);
              },
              child: Text('Cerrar Sesion',),
            ),
          ),
        ],
        title: Text('Panel principal'),
      ),
      body: Container(
        color: const Color(0xffF3F3F3),
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(children: [
            const SizedBox(
              height: 100,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (permisosId.contains(8) || permisosId.contains(40)) ...[
                Visibility(
                    visible: true,
                    child: TextButtons(
                      img: 'mantenimiento.png',
                      name: 'Modulo de Mantenimiento',
                      route: 'mantenimiento',
                      width: 0.2,
                      fontSize: 15,
                    )),
              ],
              SizedBox(
                width: 30,
              ),
              if (permisosId.contains(44) || permisosId.contains(15)) ...[
                Visibility(
                  visible: true,
                  child: TextButtons(
                    img: 'salario.png',
                    name: 'Modulo de Ventas',
                    route: 'PrincipalVenta',
                    width: 0.2,
                    fontSize: 15,
                  ),
                ),
              ],
              const SizedBox(
                width: 30,
              ),
              if (permisosId.contains(1) ||
                  permisosId.contains(2) ||
                  permisosId.contains(3) ||
                  permisosId.contains(4)) ...[
                Visibility(
                  visible: true,
                  child: TextButtons(
                    img: 'equilibrar.png',
                    name: 'Modulo de Arqueos',
                    route: 'traer_arqueo',
                    width: 0.2,
                    fontSize: 15,
                  ),
                ),
              ],
              const SizedBox(
                width: 30,
              ),
              if (permisosId.contains(43) ||
                  permisosId.contains(28) ||
                  permisosId.contains(12)) ...[
                Visibility(
                  visible: true,
                  child: TextButtons(
                    img: 'empleado.png',
                    name: 'Gestion de Usuarios',
                    route: 'PrincipalGestion',
                    width: 0.2,
                    fontSize: 15,
                  ),
                ),
              ]
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            )
          ]),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cerrar Sesion'),
          content: Text('¿Esta seguro que quiere cerrar Sesion?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Si'),
              onPressed: () {
                logout_controller(context);
              },
            ),
            ElevatedButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogValidarArqeuoActivo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Validar Arqueo Activo'),
          content: Text('¿Esta seguro que quiere Validar un Arqueo?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Si'),
              onPressed: () {
                //validarArqueoActivo_Controller(context);
              },
            ),
            ElevatedButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
