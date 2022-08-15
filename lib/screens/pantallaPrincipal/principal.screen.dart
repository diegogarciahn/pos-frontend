import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/user.controller.dart';
import 'package:soft_frontend/screens/screens.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: logeado(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Login();
          }else{
            return Pantalla();
          }
        }
        );
  }
}

class Pantalla extends StatelessWidget {
  const Pantalla({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const PantallaPrincipalDesktop();
          //return const PantallaPrincipalMovil();
        } else {
          return const PantallaPrincipalDesktop();
        }
      }),
    );
  }
}
