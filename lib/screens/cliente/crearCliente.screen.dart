import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/cliente.controller.dart';
import 'package:soft_frontend/screens/globals.components/buttonregresarappbar.component.dart';

class CrearClientes extends StatefulWidget {
  const CrearClientes({Key? key}) : super(key: key);

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

  // Esta función sirve para saber desde dónde fue llamada esta pantalla.
  // Si fue llamada desde venta regresará a la pantalla de venta, caso contrario
  // regresará a la pantalla de clientes del modulo de mantenimiento.
  regresarPantalla(context) {
    String ruta = ModalRoute.of(context)!.settings.name.toString();
    Navigator.maybePop(context).then((value) {
      if (!value) {
        if (ruta == '/venta/crear_cliente') {
          Navigator.popAndPushNamed(context, 'ventas');
        } else {
          Navigator.popAndPushNamed(context, 'mantenimiento/clientes');
        }
      }
    });
  }

  @override
  Widget build(context) =>
      Scaffold(body: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Crear Cliente'),
            actions: [
              buttonAppBarRegresar(context, '', funcion: () => regresarPantalla(context)),
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
                                TextButton(
                                  onPressed: null,
                                  child: Center(
                                    child: ElevatedButton(
                                        onPressed: () =>
                                            crearClienteController(
                                                dniController,
                                                emailController,
                                                rtnController,
                                                nombreController,
                                                direccionController,
                                                telefonoController,
                                                context),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10),
                                          child: Text('Crear'),
                                        )),
                                  ),
                                ),
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
