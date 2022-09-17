import 'package:flutter/material.dart';

import '../../../controllers/cliente.controller.dart';
import '../../../models/cliente.model.dart';
import '../actualizarCliente.screen.dart';

Widget item(TodoslosCliente lista, context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(flex: 2, child: Text(lista.dni)),
        Expanded(flex: 2, child: Text(lista.nombreCliente)),
        Expanded(flex: 2, child: Text(lista.direccion)),
        Expanded(flex: 2, child: Text(lista.email)),
        Expanded(
            flex: 1,
            child: ElevatedButton(
              child: const Text('Actualizar'),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ActualizarCliente2(
                    id: lista.id,
                    dni: lista.dni,
                    rtn: lista.rtn,
                    nombre: lista.nombreCliente,
                    direccion: lista.direccion,
                    telefono: lista.telefonoCliente,
                    email: lista.email,
                  );
                }));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10)
              ),
            ),),
            SizedBox(
              width: size.width * 0.01,
            ),
        Expanded(
            flex: 1,
            child: ElevatedButton(
              child: Text('Eliminar'),
              onPressed: () {
                _showDialog(context, lista.id.toString());
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10),
                primary: Colors.red
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
          title: Text('ELiminar Cliente'),
          content: Text('¿Quieres eliminar el cliente?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Si'),
              onPressed: () {
                eliminarClienteController(id, context);
                Navigator.pop(context);
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