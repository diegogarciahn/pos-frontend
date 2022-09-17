// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_frontend/controllers/empleado.controller.dart';
import 'package:soft_frontend/providers/empleado.provider.dart';
import 'package:soft_frontend/screens/empleado/components/cabeceraDeTablaEmpleados.component.dart';
import 'package:soft_frontend/screens/globals.components/buttonregresarappbar.component.dart';

import 'components/itemDeTablaEmpleados.component.dart';

class TodosLosEmpleados2 extends StatefulWidget {
  const TodosLosEmpleados2({Key? key}) : super(key: key);

  @override
  State<TodosLosEmpleados2> createState() => _TodosLosEmpleados2State();
}

class _TodosLosEmpleados2State extends State<TodosLosEmpleados2> {

  @override
  void initState() {
    obtenerEmpleadosController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final empleadoProvider = Provider.of<EmpleadoProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Modulo Empleados'),
            actions: [buttonAppBarRegresar(context, 'gestionusuarios')]),
        body: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'gestionusuarios/empleados/crearempleado');
                    },
                    child: const Text(
                      'Crear Empleado',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              cabeceraTableEmpleados(context),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: ListView.separated(
                      itemBuilder: (_, i) =>
                          itemTableEmpleados(empleadoProvider.listEmpleados[i], context, size),
                      itemCount: empleadoProvider.listEmpleados.length,
                      separatorBuilder: (_, i) => const Divider(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
