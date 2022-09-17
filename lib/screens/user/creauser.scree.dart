import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/user.controller.dart';
import 'package:soft_frontend/services/user.service.dart';

class CrearUser extends StatefulWidget {
  const CrearUser({
    required this.id,
    //required this.email,
  });
  @override
  State<CrearUser> createState() => _CrearUserState();
  final int id;
}

class _CrearUserState extends State<CrearUser> {
  var idController = TextEditingController();
  var usuarioController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  //late TextEditingController emailEmpleadoController =
  //  TextEditingController(text: widget.email);
  late TextEditingController dniEmpleadoController =
      TextEditingController(text: widget.id.toString());
  var idRolController = TextEditingController(text: '2');

  @override
  Widget build(context) =>
      Scaffold(body: LayoutBuilder(builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(
            title: Text('Crear Usuario'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, 'gestionusuarios/usuarios');
                },
                child: Text('Regresar',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: constraints.maxWidth < 500
                  ? const EdgeInsets.all(20)
                  : const EdgeInsets.all(30.0),
              color: const Color(0xffF3F3F3),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'gestionusuarios/usuarios');
                          },
                          child: Container(
                              width: size.width * 0.15,
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                "Mostrar Usuarios",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFFFFFFFF)),
                              )),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF3D95E7)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Crear Usuario',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            //textAlign: Center(),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Por favor llene los campos',
                            style: TextStyle(
                                fontSize: 15, color: Color(0xff606060)),
                          ),
                          const SizedBox(height: 40),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // child: Center(
                      children: [
                        /* const Text(
                          "Crear Usuario",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          //textAlign: Center(),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          "Por favor llene los campos",
                          style:
                              TextStyle(fontSize: 15, color: Color(0xff606060)),
                        ),*/
                        const SizedBox(height: 40),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                              width: 500,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(40),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Usuario",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      TextFormField(
                                        controller: usuarioController,
                                        decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: 'usuario'),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        "Password",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      TextFormField(
                                        controller: passwordController,
                                        decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: '**********'),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        "Email",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      TextFormField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: 'Email'),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      /* Text(
                                        "ID Empleado",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      TextFormField(
                                        enabled: false,
                                        controller: dniEmpleadoController,
                                        decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: '1'),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        "IdRol",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      TextFormField(
                                        controller: idRolController,
                                        decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: '1'),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),*/
                                      TextButton(
                                        onPressed: null,
                                        child: Center(
                                          child: ElevatedButton(
                                              onPressed: () =>
                                                  crearUsuario_Controller(
                                                      idController.text,
                                                      usuarioController.text,
                                                      passwordController.text,
                                                      emailController.text,
                                                      dniEmpleadoController
                                                          .text,
                                                      idRolController.text,
                                                      context),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                child: Text('Aceptar'),
                                              )),
                                        ),
                                      ),
                                    ]),
                              )),
                        ),
                      ],
                      //),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }));
}
