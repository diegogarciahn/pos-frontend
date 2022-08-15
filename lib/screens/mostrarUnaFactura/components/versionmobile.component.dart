import 'package:flutter/material.dart';

import '../../../controllers/manipularfactura.controller.dart';
import '../../../models/mostrarUnaFactura.model.dart';

class MostrarUnaFacturaMobile extends StatefulWidget {
  const MostrarUnaFacturaMobile(
      {Key? key, required this.datosFactura, required this.numeroFactura})
      : super(key: key);
  final MostrarUnaFactura datosFactura;
  final String numeroFactura;

  @override
  State<MostrarUnaFacturaMobile> createState() =>
      _MostrarUnaFacturaMobileState();
}

class _MostrarUnaFacturaMobileState extends State<MostrarUnaFacturaMobile> {
  late Totales totales;
  late MostrarUnaFactura datosFactura;
  late Cliente? datosCliente;

  @override
  void initState() {
    totales = calcularTotales(widget.datosFactura.detallesDeVentas);
    datosFactura = widget.datosFactura;
    datosCliente = datosFactura.facturaConDatos.cliente;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double labelSuperior = size.width * 0.026;
    double iconosSize = size.width * 0.06;
    double subtitle = size.width * 0.032;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Número de factura: ${widget.numeroFactura}',
          style: TextStyle(fontSize: size.width * 0.037),
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total de factura',
                    style: TextStyle(
                        fontSize: labelSuperior,
                        color: Color.fromARGB(255, 216, 230, 241))),
                Text('L. ${totales.totalFactura.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: size.width * 0.046, color: Colors.white)),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sub total',
                            style: TextStyle(
                                fontSize: labelSuperior,
                                color: Color.fromARGB(255, 216, 230, 241))),
                        Text(totales.subTotalFactura.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: subtitle, color: Colors.white)),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Importe exonerado',
                            style: TextStyle(
                                fontSize: labelSuperior,
                                color: Color.fromARGB(255, 216, 230, 241))),
                        Text('0.00',
                            style: TextStyle(
                                fontSize: subtitle, color: Colors.white)),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Importe excento',
                            style: TextStyle(
                                fontSize: labelSuperior,
                                color: Color.fromARGB(255, 216, 230, 241))),
                        Text(totales.importeExcento.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: subtitle, color: Colors.white)),
                      ],
                    )),
                  ],
                ),
                Row(children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Importe gravado',
                          style: TextStyle(
                              fontSize: labelSuperior,
                              color: Color.fromARGB(255, 216, 230, 241))),
                      Text(
                          (totales.importeGravado15 + totales.importeGravado18)
                              .toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: subtitle, color: Colors.white)),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ISV',
                          style: TextStyle(
                              fontSize: labelSuperior,
                              color: Color.fromARGB(255, 216, 230, 241))),
                      Text((totales.isv15 + totales.isv18).toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: subtitle, color: Colors.white)),
                    ],
                  )),
                ]),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(Icons.person_outlined,
                                color: Colors.white, size: iconosSize),
                            SizedBox(
                              height: 2,
                            ),
                            Text('Ver Cliente',
                                style: TextStyle(
                                    fontSize: labelSuperior,
                                    color: Color.fromARGB(255, 216, 230, 241))),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(Icons.assignment_ind_outlined,
                                color: Colors.white, size: iconosSize),
                            SizedBox(
                              height: 2,
                            ),
                            Text('Datos de facturación',
                                style: TextStyle(
                                    fontSize: labelSuperior,
                                    color: Color.fromARGB(255, 216, 230, 241))),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(Icons.print_outlined,
                                color: Colors.white, size: iconosSize),
                            SizedBox(
                              height: 2,
                            ),
                            Text('Imprimir',
                                style: TextStyle(
                                    fontSize: labelSuperior,
                                    color: Color.fromARGB(255, 216, 230, 241))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          Expanded(child: _listItemNotif(datosFactura.detallesDeVentas, subtitle))
        ],
      ),
    );
  }

  Widget _listItemNotif(
      List<DetallesDeVenta?> detallesDeVenta, double subtitle) {
    List<Widget> detalles = detallesDeVenta
        .map((e) => CardDetalle(
              datosFactura: (e != null)
                  ? e
                  : DetallesDeVenta(
                      id: -1,
                      cantidad: 0,
                      precioUnitario: '',
                      isvAplicado: '',
                      descuentoAplicado: '',
                      totalDetalleVenta: '',
                      isDelete: false,
                      createdAt: DateTime.parse('0000-00-00 00:00:00'),
                      updatedAt: DateTime.parse('0000-00-00 00:00:00'),
                      idVentas: 0,
                      idProducto: 0,
                      producto: Producto(
                          id: 0,
                          codigoProducto: '',
                          nombreProducto: '',
                          precioProducto: '',
                          cantidadProducto: 0,
                          isvProducto: '',
                          descProducto: '',
                          isExcento: false,
                          isDelete: false,
                          createdAt: DateTime.parse('0000-00-00 00:00:00'),
                          updatedAt: DateTime.parse('0000-00-00 00:00:00'),
                          idTipoProducto: 0)),
              subtitle: subtitle,
            ))
        .toList();
    // .map((e) =>CardWidget(
    //       fromAddress: e.nombreOrig,
    //       toAddress: e.nombreDest,
    //       status: e.activo ? "En Curso" : "Finalizado",
    //       price: e.precio.toInt().toStringAsFixed(1),
    //       registro: e.registro,
    //       hora: e.hora,
    //       latOrig: e.latOrig,
    //       lonOrig: e.lonOrig,
    //       latDest: e.latDest,
    //       lonDest: e.lonDest,
    //     ))
    // .toList();

    return Column(
      children: detalles,
    );
  }

}

class CardDetalle extends StatelessWidget {
  const CardDetalle(
      {Key? key, required this.datosFactura, required this.subtitle})
      : super(key: key);
  final DetallesDeVenta datosFactura;
  final double subtitle;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(datosFactura.producto!.nombreProducto,
            style: TextStyle(fontSize: subtitle, color: Colors.black87)),
        Row(
          children: [
            Text(datosFactura.producto!.codigoProducto,
                style: TextStyle(fontSize: subtitle, color: Colors.black87)),
          ],
        ),
        Container(
          height: 0.5,
          width: size.width,
          color: Colors.black12,
        )
      ],
    );
  }
}
