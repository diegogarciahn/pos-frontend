import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/user.controller.dart';
import 'package:soft_frontend/services/rol.service.dart';

class ActualizarUsuario2 extends StatefulWidget {
  const ActualizarUsuario2(
      {required this.id,
      required this.usuario,
      //required this.password,
      required this.email,
      required this.idEmpleado,
      required this.idRol,
      required this.empleado});

  @override
  State<ActualizarUsuario2> createState() => _ActualizarUsuario2State();
  final int id;
  final String usuario, /*password,*/ email, idEmpleado, idRol, empleado;
}

class _ActualizarUsuario2State extends State<ActualizarUsuario2> {
  late TextEditingController idController =
      TextEditingController(text: widget.id.toString());
  late TextEditingController usuarioController =
      TextEditingController(text: widget.usuario);
  //late TextEditingController passwordController =
  //  TextEditingController(text: widget.password);
  late TextEditingController emailController =
      TextEditingController(text: widget.email);
  late TextEditingController idEmpleadoController =
      TextEditingController(text: widget.idEmpleado.toString());
  late TextEditingController idRolController =
      TextEditingController(text: widget.idRol.toString());
  late TextEditingController dniEmpleadoController =
      TextEditingController(text: widget.empleado);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualizar Usuario"),
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
                /* const SizedBox(height: 3),
                const Text(
                  "Por favor llene los campos",
                  style: TextStyle(fontSize: 15, color: Color(0xff606060)),
                ),*/
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
                            const Text(
                              "Usuario",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: usuarioController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'usuario'),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "password",
                              style: TextStyle(fontSize: 18),
                            ),
                            /* TextFormField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: '***********'),
                            ),*/
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Email",
                              style: const TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'example@midominio.com'),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "DNI Empleado",
                              style: const TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              enabled: false,
                              controller: dniEmpleadoController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: '1'),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "ID Rol",
                              style: const TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: idRolController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: '1'),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextButton(
                              onPressed: null,
                              child: Center(
                                child: ElevatedButton(
                                    onPressed: () => setState(() {
                                          actualizarUsuario_Controller(
                                              idController.text,
                                              usuarioController.text,
                                              //passwordController.text,
                                              emailController.text,
                                              //idEmpleadoController.text,
                                              idRolController.text,
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
