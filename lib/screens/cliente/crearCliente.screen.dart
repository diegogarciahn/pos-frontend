// ignore_for_file: prefer_const_constructors
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/cliente.controller.dart';
import 'package:soft_frontend/services/cliente.service.dart';

class CrearClientes extends StatefulWidget {
  @override
  State<CrearClientes> createState() => _CrearClientesState();
}

class _CrearClientesState extends State<CrearClientes> {
  var dniController = TextEditingController();
  var rtnController = TextEditingController();
  var nombreController = TextEditingController();
  var direccionController = TextEditingController();
  var telefonoController = TextEditingController();
  var emailController = TextEditingController();

  regresarPantalla(context) {
    String ruta = ModalRoute.of(context)!.settings.name.toString();
    Navigator.maybePop(context).then((value) {
      if (!value) {
        if (ruta == '/venta/crear_cliente') {
          Navigator.popAndPushNamed(context, 'ventas');
        } else {
          Navigator.popAndPushNamed(context, 'traer_clientes');
        }
      }
    });
  }

  @override
  Widget build(context) =>
      Scaffold(body: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                regresarPantalla(context);
              },
            ),
            title: Text('Crear Cliente'),
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
                    const SizedBox(height: 3),
                    const Text(
                      'Por favor llene los campos',
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
                                Text(
                                  'Identificacion/DNI',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: dniController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: '0601200012345'),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'RTN (Opcional)',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextFormField(
                                  controller: rtnController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: '06012005012345'),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'Nombre',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextFormField(
                                  controller: nombreController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Ruben Doblas'),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'Direccion',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextFormField(
                                  controller: direccionController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText:
                                          'Barrio las vegas, Choluteca, Honduras'),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'Telefono',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextFormField(
                                  controller: telefonoController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: '33772797'),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'Email',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Example@dominio.com'),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: null,
                                        child: Center(
                                          child: ElevatedButton(
                                              onPressed: () =>
                                                  crearClienteController(
                                                      dniController.text,
                                                      emailController.text,
                                                      rtnController.text,
                                                      nombreController.text,
                                                      direccionController.text,
                                                      telefonoController.text,
                                                      context),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                child: Text('Aceptar'),
                                              )),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: null,
                                          child: Center(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    regresarPantalla(context);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    child: Text('Cancelar'),
                                                  )))),
                                    ]),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }));
}
