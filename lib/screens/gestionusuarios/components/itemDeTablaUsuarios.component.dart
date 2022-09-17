import 'package:flutter/material.dart';

import '../../../controllers/user.controller.dart';
import '../../../models/gestionUsuario.model.dart';
import '../../user/updateuser.screen.dart';


Widget item(TodosLosUsuarios lista, size, context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(lista.usuario)),
          Expanded(flex: 2, child: Text(lista.email)),
          Expanded(flex: 2, child: Text(lista.empleado.dni)),
          Expanded(flex: 2, child: Text(lista.role.rol)),
          //Expanded(flex: 2, child: Text(lista.idEmpleado.toString())),
          //Expanded(flex: 2, child: Text(lista.idRol.toString())),
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: size.width * 0.005),
                child: ElevatedButton(
                    child: const Text('Actualizar'),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext context) {
                        return ActualizarUsuario2(
                            id: lista.id,
                            usuario: lista.usuario,
                            //password: lista.password,
                            email: lista.email,
                            idEmpleado: lista.idEmpleado.toString(),
                            idRol: lista.idRol.toString(),
                            empleado: lista.empleado.dni);
                      }));
                    }),
              )),
          Expanded(
              flex: 1,
              child: ElevatedButton(
                child: Text('Eliminar'),
                onPressed: () {
                  _showDialog(context, lista.id.toString(), lista.usuario);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red
                ),
              )),
        ],
      ),
    );
  }

void _showDialog(BuildContext context, String id, usuario) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        print(id);
        return AlertDialog(
          title: Text('Eliminar usuario'),
          content: Text('¿Está seguro que deesea eliminar el usuario $usuario?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Si'),
              onPressed: () {
                eliminarUsuarioController(id, context);
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