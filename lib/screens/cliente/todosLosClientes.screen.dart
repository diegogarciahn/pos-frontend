// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/cliente.controller.dart';
import 'package:soft_frontend/screens/cliente/actualizarCliente.screen.dart';
import 'package:soft_frontend/services/cliente.service.dart';
import '../../models/cliente.model.dart';

class TodosLosClientes2 extends StatefulWidget {
  const TodosLosClientes2({Key? key}) : super(key: key);

  @override
  State<TodosLosClientes2> createState() => _TodosLosClientes2State();
}

class _TodosLosClientes2State extends State<TodosLosClientes2> {
  List<TodoslosCliente> listaClientes = [];
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var buscadorcontroller = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon( Icons.arrow_back),
          onPressed: () {Navigator.pushReplacementNamed(context, 'mantenimiento');},),
          title: const Text('Modulo Clientes')
        ),
        body: Container(
          child: FutureBuilder(
            future: traerClientes(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                Cliente lista = snapshot.data;
                listaClientes = lista.todoslosClientes;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'crear_cliente');
                            },
                            child: Container(
                                width: size.width * 0.2,
                                padding: const EdgeInsets.all(15),
                                child: const Text(
                                  'Crear Cliente',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff525252)),
                                )),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xffD9D9D9)),
                            ),
                          ),const SizedBox(width: 20),
                          TextButton(
                            onPressed: () => Navigator.popAndPushNamed(context, 'mantenimiento'),
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
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                      children: [
                        Expanded(child:
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.05),
                          child: Text('DNI', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                        )),
                        Expanded(child:
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.05),
                          child: Text('Nombre', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                        )),
                        Expanded(child:
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.05),
                          child: Text('Direccion', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                        )),
                        Expanded(child:
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.05),
                          child: Text('Correo', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                        )),
                        Expanded(child:
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.05),
                          child: Text('Opciones', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                        )),
                      ],
                    ),const SizedBox(
                        height: 20,
                      ),
                        Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ListView.separated(
                              itemBuilder: (_, i) => item(listaClientes[i]),
                              itemCount: lista.todoslosClientes.length,
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

  Widget item(TodoslosCliente lista) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(lista.dni)),
        Expanded(flex: 2, child: Text(lista.nombreCliente)),
        Expanded(flex: 2, child: Text(lista.direccion)),
        Expanded(flex: 2, child: Text(lista.email)),
        Expanded(
            flex: 1,
            child: TextButton(
              child: const Text('Actualizar'),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return new ActualizarCliente2(
                    id: lista.id,
                    dni: lista.dni,
                    rtn: lista.rtn,
                    nombre: lista.nombreCliente,
                    direccion: lista.direccion,
                    telefono: lista.telefonoCliente,
                    email: lista.email,
                  );
                }));
              },
            )),
        Expanded(
            flex: 1,
            child: TextButton(
              child: Text("Eliminar"),
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
          title: Text("ELiminar Cliente"),
          content: Text("¿Quieres eliminar el cliente?"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Si"),
              onPressed: () {
                eliminarCliente_Controller(id, context);
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

void buscarCliente (String query){
  final sugerencia = listaClientes.where((listaClientes){
  final nombre = listaClientes.nombreCliente.toLowerCase();
  final input = query.toLowerCase();
  return nombre.contains(input);
  }).toList();

    listaClientes = sugerencia;
setState(() {
  
});
}

}
