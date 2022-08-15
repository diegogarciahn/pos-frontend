/*import 'package:flutter/material.dart';
import '../../controllers/Arqueo.controller.dart';

class ActualizarArqueCerrandoSesion extends StatefulWidget {
  const ActualizarArqueCerrandoSesion(
      {required this.idUsuario,
      required this.idSesion,
      required this.idArqueo});

  @override
  State<ActualizarArqueCerrandoSesion> createState() =>
      _ActualizarArqueCerrandoSesionState();
  final int idUsuario, idSesion, idArqueo;
}

class _ActualizarArqueCerrandoSesionState
    extends State<ActualizarArqueCerrandoSesion> {
  late TextEditingController idUsuarioController =
      TextEditingController(text: widget.idUsuario.toString());
  late TextEditingController idSesionController =
      TextEditingController(text: widget.idSesion.toString());
  late TextEditingController idArqueoController =
      TextEditingController(text: widget.idArqueo.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cerrar Arqueo'),
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
                            const Text(
                              'Id Usuario',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              enabled: false,
                              controller: idUsuarioController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'Id Sesion',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: idSesionController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder()),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'id Arqueo',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              controller: idArqueoController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder()),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextButton(
                              onPressed: null,
                              child: Center(
                                child: ElevatedButton(
                                    onPressed: () => setState(() {
                                          actualizarArqueoCerrandoSesion_Controller(
                                              idUsuarioController.text,
                                              idSesionController.text,
                                              context);
                                        }),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text('Aceptar'),
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
}*/
