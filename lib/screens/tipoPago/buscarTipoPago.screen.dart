import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:soft_frontend/providers/tipopago.provider.dart';

import '../../controllers/tipoDePago.controller.dart';

import 'package:soft_frontend/models/tipoPagoBuscado.model.dart';

import 'package:soft_frontend/screens/tipoPago/components/cabeceratablatipopago.component.dart';
import 'package:soft_frontend/screens/tipoPago/components/listitemtipopago.component.dart';
import 'package:soft_frontend/screens/tipoPago/crearTipoPago.screen.dart';

class BuscarTipoPago extends StatefulWidget {
  const BuscarTipoPago({Key? key}) : super(key: key);

  @override
  State<BuscarTipoPago> createState() => _BuscarTipoPagoState();
}

class _BuscarTipoPagoState extends State<BuscarTipoPago> {
  final _textController = TextEditingController();
  List<TipoPagoBuscado> tipoPagos = [];

  @override
  void initState() {
    traerTipoPagosController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tipoPagoProvider = Provider.of<TipoPagoProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Text('Tipos de Pagos'),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.01, vertical: 8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.maybePop(context).then((value) {
                    if (!value) {
                      Navigator.popAndPushNamed(context, 'mantenimiento');
                    }
                  });
                },
                child: Text(
                  'Regresar',
                ),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).focusColor,
                ),
              ),
            )
          ]),
      // backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.02, horizontal: size.width * 0.03),
            child: Column(
              children: [
                Row(children: [
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => CrearTipoPagos(),
                    )),
                    child: Text('CrearNuevoTipoPago'),
                  ),
                ]),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Expanded(
                    child: Column(
                  children: [
                    cabeceraTableTipoPago(context),
                    Expanded(child: _listViewUsuarios(tipoPagoProvider)),
                  ],
                ))
              ],
            ),
          ),
          if (tipoPagoProvider.loading)
            Container(
                color: Colors.black12,
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      height: 90.0,
                      width: 90.0,
                      child: CircularProgressIndicator()),
                )),
        ],
      ),
    );
  }

  ListView _listViewUsuarios(TipoPagoProvider provider) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: provider.getListTipoPago.length,
      itemBuilder: (_, i) =>
          listItemTipoPago(provider.getListTipoPago[i], context),
    );
  }
}
