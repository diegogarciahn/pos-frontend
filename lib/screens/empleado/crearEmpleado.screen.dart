import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/empleado.controller.dart';
import 'package:soft_frontend/screens/globals.components/buttonregresarappbar.component.dart';
//import 'package:soft_frontend/services/cliente.service.dart';

class CrearEmpleadosScreen extends StatefulWidget {
  @override
  State<CrearEmpleadosScreen> createState() => _CrearEmpleadosScreenState();
}

class _CrearEmpleadosScreenState extends State<CrearEmpleadosScreen> {
  var dniController = TextEditingController();
  var nombreController = TextEditingController();
  var apellidoController = TextEditingController();
  var direccionController = TextEditingController();
  var telefonoController = TextEditingController();
  var fechaNacimientoController = TextEditingController();
  var sexoController = TextEditingController();

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Crear Empleado'),
        actions: [buttonAppBarRegresar(context, 'gestionusuarios/empleados')],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
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
                    'llenar todos los campos',
                    style: TextStyle(fontSize: 15, color: Color(0xff606060)),
                  ),
                  const SizedBox(height: 20),
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
                                'DNI',
                                style: TextStyle(fontSize: 18),
                              ),
                              TextFormField(
                                controller: dniController,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: '061019901789'),
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
                                    hintText: 'Carlos'),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                'Apellido',
                                style: TextStyle(fontSize: 18),
                              ),
                              TextFormField(
                                controller: apellidoController,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Carrasco'),
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
                                    hintText: 'Barrio las brisas'),
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
                                    hintText: '33707090'),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                'Fecha de Nacimiento',
                                style: TextStyle(fontSize: 18),
                              ),
                              TextFormField(
                                controller: fechaNacimientoController,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: '2020-07-22'),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                'Sexo',
                                style: TextStyle(fontSize: 18),
                              ),
                              TextFormField(
                                controller: sexoController,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'M ó F'),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              // DropdownButton(
                              //   items: _lista.map((String a){
                              //     return DropdownMenuItem(
                              //       value: a,
                              //       child: Text(a));

                              //   }).toList(),
                              //   onChanged: (_value)=>{
                              //     setState(() {
                              //       _vista = _value;
                              //     })
                              //   },
                              //   hint: Text(_vista),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: null,
                                      child: Center(
                                        child: ElevatedButton(
                                            onPressed: () =>
                                                crearEmpleado_Controller(
                                                    dniController.text,
                                                    nombreController.text,
                                                    apellidoController.text,
                                                    direccionController.text,
                                                    telefonoController.text,
                                                    fechaNacimientoController
                                                        .text,
                                                    sexoController.text,
                                                    context),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              child: Text('Crear'),
                                            )),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: null,
                                        child: Center(
                                            child: ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.popAndPushNamed(
                                                        context,
                                                        'gestionusuarios/empleados'),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: Text('Cancelar'),
                                                )))),
                                  ]),
                            ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }));
}
