import 'package:flutter/material.dart';
import '../../controllers/Arqueo.controller.dart';

class CrearArqueo extends StatefulWidget {
  const CrearArqueo({Key? key}) : super(key: key);

  @override
  State<CrearArqueo> createState() => _CrearArqueoState();
}

class _CrearArqueoState extends State<CrearArqueo> {
  var efectivoAperturaController = TextEditingController();

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
                    'Crear un Arqueo',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Por favor ingrese la cantidad de dinero en efectivo que recibe al momento de abrir la caja.',
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
                                'Efectivo Apertura',
                                style: TextStyle(fontSize: 18),
                              ),
                              TextFormField(
                                controller: efectivoAperturaController,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder()),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: null,
                                    child: Center(
                                      child: ElevatedButton(
                                          onPressed: () =>
                                              crearArqueo_Controller(
                                                  efectivoAperturaController
                                                      .text,
                                                  context),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Text('Aceptar'),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                    onPressed: null,
                                    child: Center(
                                      child: ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  'pantalla_principal'),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Text('Cancelar'),
                                          )),
                                    ),
                                  ),
                                ],
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
