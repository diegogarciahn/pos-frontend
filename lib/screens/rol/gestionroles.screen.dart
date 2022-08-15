// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:soft_frontend/screens/rol/updaterol.screen.dart';
import 'package:soft_frontend/services/rol.service.dart';
import '../../models/gestionrol.model.dart';
import 'package:soft_frontend/controllers/roles.controller.dart';

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
    var buscadorcontroller = TextEditingController();

    return Scaffold(
        appBar: AppBar(title: const Text('Modulo Roles'), actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, 'PrincipalGestion');
            },
            child: Text('Regresar',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ]),
        body: Container(
          child: FutureBuilder(
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
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'crearRol');
                            },
                            child: Container(
                                width: size.width * 0.15,
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  "Nuevo Rol",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xFFF1F1F1)),
                                )),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFF5FA9E6)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Color(0x89ECEAEA), height: 25,
                              child: Text(
                                'Rol',
                                style: TextStyle(
                                  fontSize: size.width * 0.011,
                                  color: Color(0xFF121213),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Color(0x89ECEAEA), height: 25,
                              child: Text(
                                'Descripcion',
                                style: TextStyle(
                                  fontSize: size.width * 0.011,
                                  color: Color(0xFF121213),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Color(0x89ECEAEA), height: 25,
                              child: Text(
                                'Opciones',
                                style: TextStyle(
                                  fontSize: size.width * 0.011,
                                  color: Color(0xFF121213),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ListView.separated(
                              itemBuilder: (_, i) => item(listaRol[i]),
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
          ),
        ));
  }

  Widget item(TodosLosRol lista) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(lista.rol)),
        Expanded(flex: 2, child: Text(lista.descripcion)),
        const SizedBox(
          width: 15,
        ),
        Expanded(
            flex: 1,
            child: TextButton(
                child: const Text('Actualizar'),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return new ActualizarRole2(
                        id: lista.id,
                        rol: lista.rol,
                        descripcion: lista.descripcion);
                  }));
                })),
        Expanded(
            flex: 1,
            child: TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                _showDialog(context, lista.id.toString());
              },
            )),
      ],
    );
  }

  void _showDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        print(id);
        return AlertDialog(
          title: Text("Baja Rol"),
          content: Text("¿Quieres eliminar el rol?"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Si"),
              onPressed: () {
                eliminarrol_Controller(id, context);
              },
            ),
            ElevatedButton(
              child: Text("No"),
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
