import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:soft_frontend/models/unPagoBuscado.model.dart';
import 'package:soft_frontend/models/tipoPagoBuscado.model.dart';
import 'package:soft_frontend/screens/generarFactura/generarFactura.screen.dart';
import 'package:soft_frontend/screens/tipoPago/crearTipoPago.screen.dart';
import 'package:soft_frontend/screens/tipoPago/editarTipoPago.screen.dart';
import '../../controllers/tipoDePago.controller.dart';
import '../../models/tipoPago.model.dart';
import '../../services/tipoPago.service.dart';
import '../talonarios/themes/app_theme.dart';

class BuscarTipoPago extends StatefulWidget {
  @override
  State<BuscarTipoPago> createState() => _BuscarTipoPagoState();
}

class _BuscarTipoPagoState extends State<BuscarTipoPago> {
  final _textController = TextEditingController();
  List<TipoPagoBuscado> tipoPagos = [];

  @override
  void initState() {
    super.initState();
    this._cargarFact();
  }

  _cargarFact() async {
    this.tipoPagos = await traerPago();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Manipular Tipo de Pagos')),
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02, horizontal: size.width * 0.03),
        child: Column(
          children: [
            Row(children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(right: size.width * 0.01),
                  child: Text(
                    '                                                                                                                                                                                                                ',
                    style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontSize: size.width * 0.015,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              TextButton(
                onPressed: null,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => CrearTipoPagos(),
                    )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text('CrearNuevoTipoPago'),
                    ),
                  ),
                ),
              ),
            ]),
            Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                        horizontal: size.height * 0.03),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'TipoDePago',
                                style: GoogleFonts.lato(
                                    fontSize: size.width * 0.01,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'descripcionTipoPago',
                                style: GoogleFonts.lato(
                                    fontSize: size.width * 0.01,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                '',
                                style: GoogleFonts.lato(
                                    fontSize: size.width * 0.01,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                '',
                                style: GoogleFonts.lato(
                                    fontSize: size.width * 0.01,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Expanded(child: _listViewUsuarios()),
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (_, i) => Divider(),
      itemCount: tipoPagos.length,
      itemBuilder: (_, i) => _pagoItemList(tipoPagos[i]),
    );
  }

  Container _pagoItemList(TipoPagoBuscado tipoPago) {
    Size size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                tipoPago.tipoDePago.toString(),
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                tipoPago.descripcionTipoPago.toString(),
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => EditarTipoPagos(
                    tipoPago: tipoPago,
                  ),
                ),
              ),
              child: Text('Editar'),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (buildContext) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        title: Text(
                          'Eliminación',
                          style: TextStyle(color: Colors.blue),
                        ),
                        content: SizedBox(
                          height: 90,
                          child: Column(
                            children: [
                              Text('¿Está seguro de eliminar el tipo de pago?'),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextButton(
                                  style:
                                      AppTheme.lightTheme.textButtonTheme.style,
                                  onPressed: () {
                                    eliminarTipoPago_Controller(
                                            tipoPago.idTipoPago.toString(),
                                            context)
                                        .then((value) => this._cargarFact());
                                    Navigator.pop(context);
                                  },
                                  child: Text('Confirmar'),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Text('Eliminar'),
            ),
          ],
        ));
  }
}
