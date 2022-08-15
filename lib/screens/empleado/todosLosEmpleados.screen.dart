// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/empleado.controller.dart';
import 'package:soft_frontend/screens/empleado/actualizarEmpleado.screen.dart';
import 'package:soft_frontend/services/empleado.service.dart';
import '../../models/empleado.model.dart';
import 'package:soft_frontend/screens/user/creauser.scree.dart';

class TodosLosEmpleados2 extends StatefulWidget {
  const TodosLosEmpleados2({Key? key}) : super(key: key);

  @override
  State<TodosLosEmpleados2> createState() => _TodosLosEmpleados2State();
}

class _TodosLosEmpleados2State extends State<TodosLosEmpleados2> {
  List<TodoslosEmpleados> listaEmpleados = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'PrincipalGestion');
              },
            ),
            title: const Text("Modulo Empleados")),
        body: Container(
            child: FutureBuilder(
          future: traerEmpleados(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              Empleado lista = snapshot.data;
              listaEmpleados = lista.todoslosEmpleados;
              return Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "crear_empleado");
                          },
                          child: Container(
                              width: size.width * 0.2,
                              padding: const EdgeInsets.all(15),
                              child: const Text(
                                "Crear Empleado",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xff525252)),
                              )),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffD9D9D9)),
                          ),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, 'PrincipalGestion'),
                          child: Container(
                              width: size.width * 0.2,
                              padding: const EdgeInsets.all(15),
                              child: const Text(
                                "Regresar",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xff525252)),
                              )),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffD9D9D9)),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
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
                              'DNI',
                              style: TextStyle(
                                fontSize: size.width * 0.01,
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
                              'Nombre',
                              style: TextStyle(
                                fontSize: size.width * 0.01,
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
                              'Apellido',
                              style: TextStyle(
                                fontSize: size.width * 0.01,
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
                              'Direccion',
                              style: TextStyle(
                                fontSize: size.width * 0.01,
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
                              'Telefono',
                              style: TextStyle(
                                fontSize: size.width * 0.01,
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
                              'Sexo',
                              style: TextStyle(
                                fontSize: size.width * 0.0,
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
                                fontSize: size.width * 0.01,
                                color: Color(0xFF121213),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            //),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: ListView.separated(
                            itemBuilder: (_, i) => item(listaEmpleados[i]),
                            itemCount: lista.todoslosEmpleados.length,
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
        )));
  }

  Widget item(TodoslosEmpleados lista) {
    return Row(
      children: [
        Expanded(flex: 4, child: Text(lista.dni)),
        Expanded(flex: 4, child: Text(lista.nombre)),
        Expanded(flex: 5, child: Text(lista.apellido)),
        Expanded(flex: 5, child: Text(lista.direccion)),
        Expanded(flex: 3, child: Text(lista.telefono)),
        Expanded(flex: 1, child: Text(lista.sexo)),
        Expanded(
            flex: 3,
            child: TextButton(
              child: const Text("Actualizar"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return new ActualizarEmpleados(
                    id: lista.id,
                    dni: lista.dni,
                    nombre: lista.nombre,
                    apellido: lista.apellido,
                    direccion: lista.direccion,
                    telefono: lista.telefono,
                    fechaNacimiento: lista.fechaNacimiento,
                    sexo: lista.sexo,
                  );
                }));
              },
            )),
        Expanded(
            flex: 3,
            child: TextButton(
              child: const Text("Crear Usuario"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return new CrearUser(
                    id: lista.id,
                    //email: lista.direccion,
                  );
                }));
              },
            )),
        Expanded(
            flex: 3,
            child: TextButton(
              child: Text("Eliminar"),
              onPressed: () {
                _showDialog(context, lista.id.toString());
              },
            )),
      ],
    );
  }
}

void _showDialog(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      print(id);
      return AlertDialog(
        title: Text("ELiminar Empleado"),
        content: Text("¿Quieres eliminar el Empleado?"),
        actions: <Widget>[
          ElevatedButton(
            child: Text("Si"),
            onPressed: () {
              eliminarEmpleado_Controller(id, context);
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
