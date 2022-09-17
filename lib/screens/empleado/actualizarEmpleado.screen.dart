import 'package:flutter/material.dart';

import '../../controllers/empleado.controller.dart';

class ActualizarEmpleados extends StatefulWidget {
  const ActualizarEmpleados({required this.id, required this.dni, required this.nombre, required this.apellido, required this.direccion, required this.telefono, required this.fechaNacimiento, required this.sexo});
  @override
  State<ActualizarEmpleados> createState() => _ActualizarEmpleadosState();
  final int id;
  final String dni, nombre, apellido,direccion,telefono,fechaNacimiento, sexo;
}

class _ActualizarEmpleadosState extends State<ActualizarEmpleados> {
  late TextEditingController idController = TextEditingController(text: widget.id.toString());
  late TextEditingController dniController = TextEditingController(text: widget.dni.toString());
  late TextEditingController nombreController = TextEditingController(text: widget.nombre.toString());
  late TextEditingController apellidoController = TextEditingController(text: widget.apellido.toString());
  late TextEditingController direccionController = TextEditingController(text: widget.direccion.toString());
  late TextEditingController telefonoController = TextEditingController(text: widget.telefono.toString());
  late TextEditingController fechaNacimientoController = TextEditingController(text: widget.fechaNacimiento.toString());
  late TextEditingController sexoController = TextEditingController(text: widget.sexo.toString());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualizar Empleado"),
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
                const Text(
                  "Actualizar Empleado",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                const Text(
                  "Por favor llene los campos",
                  style: TextStyle(fontSize: 15, color: Color(0xff606060)),
                ),
                const SizedBox(height: 40),
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
                              "Nombre",
                              style: TextStyle(fontSize: 18),
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
                              "Apellido",
                              style: const TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: apellidoController,
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
                              "Fecha de Nacimiento",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: fechaNacimientoController,
                              decoration: const InputDecoration(
                                  border: const UnderlineInputBorder(),
                              ),
                            ),const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Sexo",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: sexoController,
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
                                      
                                        actualizaEmpleadoController(
                                            idController.text,
                                            dniController.text,
                                            nombreController.text,
                                            apellidoController.text,
                                            direccionController.text,
                                            telefonoController.text,
                                            fechaNacimientoController.text,
                                            sexoController.text,
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
