import 'package:flutter/material.dart';
import 'package:soft_frontend/models/tipoPago.model.dart';
import 'package:soft_frontend/screens/tipoPago/buscarTipoPago.screen.dart';

import '../../controllers/tipoDePago.controller.dart';
import '../../models/tipoPagoBuscado.model.dart';
import '../../services/tipoPago.service.dart';

class EditarTipoPagos extends StatefulWidget {
  final TipoPagoBuscado tipoPago;
  const EditarTipoPagos({Key? key, required this.tipoPago}) : super(key: key);
  @override
  State<EditarTipoPagos> createState() => _EditarTipoPagosState();
}

class _EditarTipoPagosState extends State<EditarTipoPagos> {
  var idTipoPagoController = TextEditingController();
  var tipoDePagoController = TextEditingController();
  var descripcionTipoPagoController = TextEditingController();

  @override
  Widget build(context) {
    print(widget.tipoPago.idTipoPago);
    print(widget.tipoPago.tipoDePago);
    print(widget.tipoPago.descripcionTipoPago);
    idTipoPagoController.text = widget.tipoPago.idTipoPago.toString();
    tipoDePagoController.text = widget.tipoPago.tipoDePago;
    descripcionTipoPagoController.text = widget.tipoPago.descripcionTipoPago;

    return Scaffold(
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
                      "Editar Tipo De Pago",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      "Por favor modifique los campos",
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
                                Visibility(
                                  visible: false,
                                  child: Text(
                                    "id De Pago",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: TextFormField(
                                    controller: idTipoPagoController,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder()),
                                  ),
                                ),
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
                                        onPressed: () =>
                                            actualizarTipoPago_Controller(
                                                idTipoPagoController.text,
                                                tipoDePagoController.text,
                                                descripcionTipoPagoController
                                                    .text,
                                                context),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Text('Editar'),
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
}
