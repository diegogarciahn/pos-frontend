import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/roles.controller.dart';

class ActualizarRole2 extends StatefulWidget {
  const ActualizarRole2({
    required this.id,
    required this.rol,
    required this.descripcion,
  });

  @override
  State<ActualizarRole2> createState() => _ActualizarRole2State();
  final int id;
  final String rol, descripcion;
}

class _ActualizarRole2State extends State<ActualizarRole2> {
  late TextEditingController idController =
      TextEditingController(text: widget.id.toString());
  late TextEditingController rolController =
      TextEditingController(text: widget.rol);
  late TextEditingController descripcionController =
      TextEditingController(text: widget.descripcion);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualizar Rol"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: const Color(0xffF3F3F3),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 500,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Por favor llene los campos",
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xff606060)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Rol",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: rolController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'rol'),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Descripcion",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: descripcionController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'descripcion'),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextButton(
                              onPressed: null,
                              child: Center(
                                child: ElevatedButton(
                                    onPressed: () => setState(() {
                                          actualizarRole_Controller(
                                              idController.text,
                                              rolController.text,
                                              descripcionController.text,
                                              context);
                                        }),
                                    child: const Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: const Text('Aceptar'),
                                    )),
                              ),
                            ),
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
