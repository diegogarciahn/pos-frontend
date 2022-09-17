import 'package:flutter/material.dart';

import '../../../controllers/roles.controller.dart';
import '../../../models/gestionrol.model.dart';
import '../updaterol.screen.dart';

Widget itemTableRoles(TodosLosRol lista, context, Size size) {
    return Row(
      children: [
        Expanded(flex: 3, child: Text(lista.rol)),
        Expanded(flex: 4, child: Text(lista.descripcion)),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                  flex: 5,
                  child: ElevatedButton(
                      child: const Text('Actualizar'),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                          return ActualizarRole2(
                              id: lista.id,
                              rol: lista.rol,
                              descripcion: lista.descripcion);
                        }));
                      })),
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: size.width * 0.01),
                    child: ElevatedButton(
                      child: Text('Eliminar'),
                      onPressed: () {
                        _showDialog(context, lista.id.toString());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        print(id);
        return AlertDialog(
          title: Text('Baja Rol'),
          content: Text('¿Quieres eliminar el rol?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Si'),
              onPressed: () {
                eliminarrol_Controller(id, context);
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