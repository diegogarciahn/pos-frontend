/*import 'package:flutter/material.dart';

import '../../models/Arqueo.model.dart';
import '../../services/Arqueo.service.dart';

class BuscarArqueoIdUsuario extends StatefulWidget {
  const BuscarArqueoIdUsuario({Key? key}) : super(key: key);

  @override
  State<BuscarArqueoIdUsuario> createState() => _BuscarArqueoIdUsuarioState();
}

class _BuscarArqueoIdUsuarioState extends State<BuscarArqueoIdUsuario> {
  var idUsuarioController = TextEditingController();
  List<Arqueo> listaArqueos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(context) =>
      Scaffold(body: LayoutBuilder(builder: (context, constraints) {
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
                  const Text(
                    'Buscar un Arqueo',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Por favor llene los campos',
                    style: TextStyle(fontSize: 15, color: Color(0xff606060)),
                  ),
                  const SizedBox(height: 40),
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
                                'Id Usuario',
                                style: TextStyle(fontSize: 18),
                              ),
                              TextFormField(
                                controller: idUsuarioController,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder()),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              TextButton(
                                onPressed: null,
                                child: Center(
                                  child: ElevatedButton(
                                      onPressed: () => filtrarArqueoIdUsuario_Controller(
                                          idUsuarioController.text,context),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Text('Buscar'),
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
        );
      }));
}
*/