import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:soft_frontend/controllers/user.controller.dart';
import 'package:soft_frontend/models/models.dart';
import 'package:soft_frontend/screens/user/updateuser.screen.dart';
import 'package:soft_frontend/services/user.service.dart';
import '../../models/gestionUsuario.model.dart';
import 'package:soft_frontend/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

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
    var buscadorcontroller = TextEditingController();

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Modulo Usuarios'),
            actions: <Widget>[
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
                      /*Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'gestionUsuarios');
                            },
                            child: Container(
                                width: size.width * 0.15,
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  'Ver Usuarios',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFFF1F1F1)),
                                )),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFF5FA9E6)),
                            ),
                          ),
                        ],
                      ),*/
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
                                'Usuario',
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
                              color: Color(0x89ECEAEA),
                              height: 25,
                              child: Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: size.width * 0.011,
                                    color: Color(0xFF121213),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Color(0x89ECEAEA), height: 25,
                              //Padding(
                              //padding: EdgeInsets.only(left: size.height * 0.15),
                              child: Text(
                                'Empleado',
                                style: TextStyle(
                                    fontSize: size.width * 0.011,
                                    color: Color(0xFF121213),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Color(0x89ECEAEA), height: 25,
                              //Padding(
                              //padding: EdgeInsets.only(left: size.height * 0.15),
                              child: Text(
                                'Rol',
                                style: TextStyle(
                                    fontSize: size.width * 0.011,
                                    color: Color(0xFF121213),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Color(0x89ECEAEA), height: 25,
                              //Padding(
                              //padding: EdgeInsets.only(left: size.height * 0.15),
                              child: Text(
                                'Opciones',
                                style: TextStyle(
                                    fontSize: size.width * 0.011,
                                    color: Color(0xFF121213),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ListView.separated(
                              itemBuilder: (_, i) => item(listaUsuarios[i]),
                              itemCount: lista.todoslosUsuarios.length,
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

  Widget item(TodosLosUsuarios lista) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(lista.usuario)),
        Expanded(flex: 2, child: Text(lista.email)),
        Expanded(flex: 2, child: Text(lista.empleado.dni)),
        Expanded(flex: 2, child: Text(lista.role.rol)),
        //Expanded(flex: 2, child: Text(lista.idEmpleado.toString())),
        //Expanded(flex: 2, child: Text(lista.idRol.toString())),
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
                    return new ActualizarUsuario2(
                        id: lista.id,
                        usuario: lista.usuario,
                        //password: lista.password,
                        email: lista.email,
                        idEmpleado: lista.idEmpleado.toString(),
                        idRol: lista.idRol.toString(),
                        empleado: lista.empleado.dni);
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
          title: Text("Baja Usuario"),
          content: Text("¿Quieres eliminar el usuario?"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Si"),
              onPressed: () {
                eliminarUsuario_Controller(id, context);
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
