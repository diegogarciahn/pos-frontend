import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_frontend/controllers/ventas.controller.dart';
import 'package:soft_frontend/screens/generarFactura/generarFactura.screen.dart';
import 'package:soft_frontend/models/ventaBuscada.model.dart';
import 'package:soft_frontend/services/mostrarVentas.service.dart';
import 'package:soft_frontend/services/ventas.service.dart';

import '../../models/ventas.model.dart';
import 'components/cabeceraDeTablaVenta.components.dart';

class EscogerVentaPrueb extends StatefulWidget {
  @override
  State<EscogerVentaPrueb> createState() => _EscogerVentaPruebState();
}

class _EscogerVentaPruebState extends State<EscogerVentaPrueb> {
  final TextEditingController? _textEditingController = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();
  List<MostrarVenta> listaVenta = [];
  List<MostrarVenta>? filtroVenta;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController!.dispose();
    super.dispose();
  }

  /*_cargarFact() async {
    this.venta = await traerVentas();
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Modulo Ventas'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, 'inicio');
              },
              child: Text('Regresar',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ],
        ),
        body: FutureBuilder(
          future: listarVentas_Controller(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              VentaBuscada list = snapshot.data;
              listaVenta = list.venta;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(right: size.width * 0.01),
                            child: Text(
                              'Nombre Cliente a Buscar',
                              style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  fontSize: size.width * 0.015,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02),
                            child: TextField(
                              autofocus: true,
                              focusNode: _textFocusNode,
                              onChanged: (value) {
                                setState(() {
                                  filtroVenta = listaVenta
                                      .where((element) => element.nombreCliente
                                          .toString()
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                });
                              },
                              controller: _textEditingController,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.02),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: InputBorder.none,
                                labelText: 'Nombre de Cliente',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * 0.02),
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.02,
                            horizontal: size.height * 0.03),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Column(
                          children: [
                            CabeceraDeTablaVenta(size: size),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        _textEditingController!.text.isNotEmpty
                                            ? filtroVenta!.length
                                            : listaVenta.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  _textEditingController!
                                                          .text.isNotEmpty
                                                      ? filtroVenta![index]
                                                          .totalIsv
                                                          .toString()
                                                      : listaVenta[index]
                                                          .totalIsv
                                                          .toString(),
                                                  style: GoogleFonts.lato(
                                                      fontSize:
                                                          size.width * 0.01,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1,
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  _textEditingController!
                                                          .text.isNotEmpty
                                                      ? filtroVenta![index]
                                                          .totalVenta
                                                          .toString()
                                                      : listaVenta[index]
                                                          .totalVenta
                                                          .toString(),
                                                  style: GoogleFonts.lato(
                                                      fontSize:
                                                          size.width * 0.01,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1,
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  _textEditingController!
                                                          .text.isNotEmpty
                                                      ? filtroVenta![index]
                                                          .totalDescuentoVenta
                                                          .toString()
                                                      : listaVenta[index]
                                                          .totalDescuentoVenta
                                                          .toString(),
                                                  style: GoogleFonts.lato(
                                                      fontSize:
                                                          size.width * 0.01,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1,
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  _textEditingController!
                                                          .text.isNotEmpty
                                                      ? filtroVenta![index]
                                                          .nombreCliente
                                                          .toString()
                                                      : listaVenta[index]
                                                          .nombreCliente
                                                          .toString(),
                                                  style: GoogleFonts.lato(
                                                      fontSize:
                                                          size.width * 0.01,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1,
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  _textEditingController!
                                                          .text.isNotEmpty
                                                      ? filtroVenta![index]
                                                          .dni
                                                          .toString()
                                                      : listaVenta[index]
                                                          .dni
                                                          .toString(),
                                                  style: GoogleFonts.lato(
                                                      fontSize:
                                                          size.width * 0.01,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1,
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  _textEditingController!
                                                          .text.isNotEmpty
                                                      ? filtroVenta![index]
                                                          .rtn
                                                          .toString()
                                                      : listaVenta[index]
                                                          .rtn
                                                          .toString(),
                                                  style: GoogleFonts.lato(
                                                      fontSize:
                                                          size.width * 0.01,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1,
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  _textEditingController!
                                                          .text.isNotEmpty
                                                      ? filtroVenta![index]
                                                          .direccionCliente
                                                          .toString()
                                                      : listaVenta[index]
                                                          .direccionCliente
                                                          .toString(),
                                                  style: GoogleFonts.lato(
                                                      fontSize:
                                                          size.width * 0.01,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1,
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  _textEditingController!
                                                          .text.isNotEmpty
                                                      ? filtroVenta![index]
                                                          .telefonoCliente
                                                          .toString()
                                                      : listaVenta[index]
                                                          .telefonoCliente
                                                          .toString(),
                                                  style: GoogleFonts.lato(
                                                      fontSize:
                                                          size.width * 0.01,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1,
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  _textEditingController!
                                                          .text.isNotEmpty
                                                      ? filtroVenta![index]
                                                          .nombreEmpleado
                                                          .toString()
                                                      : listaVenta[index]
                                                          .nombreEmpleado
                                                          .toString(),
                                                  style: GoogleFonts.lato(
                                                      fontSize:
                                                          size.width * 0.01,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1,
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CrearFactura(
                                                        venta:
                                                            listaVenta[index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text('Procesar'),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: TextButton(
                                                onPressed: () =>
                                                    eliminarVenta_Controller(
                                                        listaVenta[index]
                                                            .id
                                                            .toString(),
                                                        context),
                                                child: Text('Eliminar'),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
