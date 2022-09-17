import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/empleado.controller.dart';
import '../../../models/empleado.model.dart';
import '../../user/creauser.scree.dart';
import '../actualizarEmpleado.screen.dart';

Widget itemTableEmpleados(TodoslosEmpleados lista, context, Size size) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(lista.dni)),
        Expanded(flex: 2, child: Text(lista.nombre)),
        Expanded(flex: 2, child: Text(lista.apellido)),
        Expanded(flex: 2, child: Text(lista.direccion)),
        Expanded(flex: 2, child: Text(lista.telefono)),
        Expanded(flex: 1, child: Text(lista.sexo)),
        Expanded(
            flex: 1,
            child: ElevatedButton(
              child: Text('Actualizar', style: GoogleFonts.lato(
                fontSize: 11
              ), textAlign: TextAlign.center),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ActualizarEmpleados(
                    id: lista.id,
                    dni: lista.dni,
                    nombre: lista.nombre,
                    apellido: lista.apellido,
                    direccion: lista.direccion,
                    telefono: lista.telefono,
                    fechaNacimiento: lista.fechaNacimiento,
                    sexo: lista.sexo,
                  );
                }));
              },
            )),
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: size.width* 0.002),
              child: ElevatedButton(
                child: Text('Crear usuario', style: GoogleFonts.lato(
                  fontSize: 11
                ), textAlign: TextAlign.center),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return CrearUser(
                      id: lista.id,
                      //email: lista.direccion,
                    );
                  }));
                },
              ),
            )),
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: size.width* 0.002),
              child: ElevatedButton(
                child: Text('Eliminar', style: GoogleFonts.lato(
                  fontSize: 11
                ), textAlign: TextAlign.center),
                onPressed: () {
                  _showDialog(context, lista.id.toString());
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red
                ),
              ),
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
        title: Text('ELiminar Empleado'),
        content: Text('¿Quieres eliminar el Empleado?'),
        actions: <Widget>[
          ElevatedButton(
            child: Text('Si'),
            onPressed: () {
              eliminarEmpleadoController(id, context);
            },
          ),
          ElevatedButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}