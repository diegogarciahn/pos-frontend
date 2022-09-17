import 'package:flutter/material.dart';
import 'package:soft_frontend/screens/gestionusuarios/components/cabeceraDeTablaUsuarios.component.dart';
import 'package:soft_frontend/services/user.service.dart';
import '../../globals/globals.components.dart';
import '../../models/gestionUsuario.model.dart';
import 'components/itemDeTablaUsuarios.component.dart';

class MostrarUsuarios extends StatefulWidget {
  const MostrarUsuarios({Key? key}) : super(key: key);

  @override
  State<MostrarUsuarios> createState() => _MostrarUsuariosState();
}

class _MostrarUsuariosState extends State<MostrarUsuarios> {
  List<TodosLosUsuarios> listaUsuarios = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Modulo Usuarios'),
            actions: <Widget>[
              buttonAppBarRegresar(context, 'gestionusuarios')
            ]),
        body: FutureBuilder(
          future: mostrarUsuarios(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              Usuario lista = snapshot.data;
              listaUsuarios = lista.todoslosUsuarios;

              return Padding(
                padding: const EdgeInsets.only(left: 10.10, top: 20.5),
                child: Column(
                  children: [
                   cabeceraTableUsuario(context),
                    Expanded(
                      child: Center(
                        child: ListView.separated(
                          itemBuilder: (_, i) => item(listaUsuarios[i], size, context),
                          itemCount: lista.todoslosUsuarios.length,
                          separatorBuilder: (_, i) => const Divider(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
