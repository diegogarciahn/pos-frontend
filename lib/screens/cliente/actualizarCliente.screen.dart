import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/cliente.controller.dart';

class ActualizarCliente2 extends StatefulWidget {
  const ActualizarCliente2({required this.id, required this.dni, required this.rtn, required this.nombre, required this.direccion, required this.telefono, required this.email});
  @override
  State<ActualizarCliente2> createState() => _ActualizarCliente2State();
  final int id;
  final String dni, rtn, nombre,direccion,telefono,email;
}

class _ActualizarCliente2State extends State<ActualizarCliente2> {
  late TextEditingController idController = TextEditingController(text: widget.id.toString());
  late TextEditingController dniController = TextEditingController(text: widget.dni.toString());
  late TextEditingController rtnController = TextEditingController(text: widget.rtn.toString());
  late TextEditingController nombreController = TextEditingController(text: widget.nombre.toString());
  late TextEditingController direccionController = TextEditingController(text: widget.direccion.toString());
  late TextEditingController telefonoController = TextEditingController(text: widget.telefono.toString());
  late TextEditingController emailController = TextEditingController(text: widget.email.toString());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualizar Cliente"),
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
                const SizedBox(height: 3),
                const Text(
                  "Por favor llene los campos",
                  style: TextStyle(fontSize: 15, color: Color(0xff606060)),
                ),
                const SizedBox(height: 10),
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
                            // const Text(
                            //   "ID",
                            //   style: const TextStyle(fontSize: 18),
                            // ),
                            // TextFormField(
                            //   enabled: false,
                            //   controller: idController,
                            //   decoration: const InputDecoration(
                            //     border: const UnderlineInputBorder(),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 40,
                            // ),
                            const Text(
                              "Identificacion/DNI",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: dniController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "RTN (Opcional)",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: rtnController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Nombre",
                              style: const TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: nombreController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Direccion",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: direccionController,
                              decoration: const InputDecoration(
                                  border: const UnderlineInputBorder(),
                                ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Telefono",
                              style: const TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: telefonoController,
                              decoration: const InputDecoration(
                                  border: const UnderlineInputBorder(),
                                ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Email",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  border: const UnderlineInputBorder(),
                                ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextButton(
                              onPressed: null,
                              child: Center(
                                child: ElevatedButton(
                                    onPressed: () =>
                                    setState(() {
                                      
                                        actualizarCliente_Controller(
                                            idController.text,
                                            dniController.text,
                                            emailController.text,
                                            rtnController.text,
                                            nombreController.text,
                                            direccionController.text,
                                            telefonoController.text,
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
