import 'package:flutter/material.dart';
import 'package:soft_frontend/services/tipoPago.service.dart';

import '../../controllers/tipoDePago.controller.dart';
import 'buscarTipoPago.screen.dart';

class CrearTipoPagos extends StatefulWidget {
  @override
  State<CrearTipoPagos> createState() => _CrearTipoPagosState();
}

class _CrearTipoPagosState extends State<CrearTipoPagos> {
  var tipoDePagoController = TextEditingController();
  var descripcionTipoPagoController = TextEditingController();

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(title: const Text('Tipo de Pagos')),
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
                  const Text(
                    "Crear un nuevo Tipo De Pago",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    "Por favor llene los campos",
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
                                "Tipo De Pago",
                                style: TextStyle(fontSize: 18),
                              ),
                              TextFormField(
                                controller: tipoDePagoController,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder()),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "Descripcion del tipo de pago",
                                style: TextStyle(fontSize: 18),
                              ),
                              TextFormField(
                                controller: descripcionTipoPagoController,
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
                                      onPressed: () => crearTipoPago_Controller(
                                          tipoDePagoController.text,
                                          descripcionTipoPagoController.text,
                                          context),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Text('Continuar'),
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
