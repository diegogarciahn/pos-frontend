// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:soft_frontend/screens/rol/components/cabeceraDeTablaRoles.component.dart';
import 'package:soft_frontend/screens/rol/components/itemDeTablaRoles.component.dart';
import 'package:soft_frontend/services/rol.service.dart';
import '../../globals/globals.components.dart';
import '../../models/gestionrol.model.dart';

class MostrarRol extends StatefulWidget {
  const MostrarRol({Key? key}) : super(key: key);

  @override
  State<MostrarRol> createState() => _MostrarRolState();
}

class _MostrarRolState extends State<MostrarRol> {
  List<TodosLosRol> listaRol = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // var buscadorcontroller = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Modulo Roles'), actions: <Widget>[
          buttonAppBarRegresar(context, 'gestionusuarios')
        ]),
        body: FutureBuilder(
          future: mostrarRol(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              Role lista = snapshot.data;
              listaRol = lista.todoslosRoles;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'crearRol');
                          },
                          child: const Text(
                            'Crear Rol',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    cabeceraTableRoles(context),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16),
                        child: Center(
                          child: ListView.separated(
                            itemBuilder: (_, i) => itemTableRoles(listaRol[i], context, size),
                            itemCount: lista.todoslosRoles.length,
                            separatorBuilder: (_, i) => const Divider(),
                          ),
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
