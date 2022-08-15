import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/controllers/manipularfactura.controller.dart';
import 'package:soft_frontend/models/mostrarUnaFactura.model.dart';
import 'package:soft_frontend/screens/mostrarUnaFactura/components/cabeceradetabla.component.dart';
import 'package:soft_frontend/screens/mostrarUnaFactura/components/versiondekstop.component.dart';
import 'package:soft_frontend/screens/mostrarUnaFactura/components/versionmobile.component.dart';
import 'package:url_launcher/url_launcher.dart';

class MostrarFactura extends StatefulWidget {
  MostrarFactura({Key? key, required this.numeroFactura}) : super(key: key);
  final String numeroFactura;

  @override
  State<MostrarFactura> createState() => _MostrarFacturaState();
}

class _MostrarFacturaState extends State<MostrarFactura>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> ocultacion;
  bool oculto = false;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    ocultacion = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.easeOutQuart));
    animationController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('height: ${size.height}');
    return FutureBuilder(
      future: mostrarDatosDeUnaFacturaController(widget.numeroFactura, context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data is MostrarUnaFactura) {
          MostrarUnaFactura datosFactura = snapshot.data;
          // MostrarUnaFacturaDekstop(datosFactura: datosFactura,);
          // final totales = calcularTotales(datosFactura.detallesDeVentas);
          // final campos = datosFactura.facturaConDatos;
          // datosFactura.detallesDeVentas;
          // final datosCliente = datosFactura.facturaConDatos.cliente;
          if (size.width > 800) {
            return MostrarUnaFacturaDekstop(datosFactura: datosFactura, numeroFactura: widget.numeroFactura,);
          } else {
            return MostrarUnaFacturaMobile(datosFactura: datosFactura, numeroFactura: widget.numeroFactura,);
          }
          // return AnimatedBuilder(
          //     animation: animationController,
          //     builder: (context, child) {
          //       return Scaffold(
          //         backgroundColor: Color.fromARGB(255, 235, 235, 235),
          //         body: Container(
          //           margin: EdgeInsets.only(
          //             left: size.width * 0.04,
          //             right: size.width * 0.04,
          //             top: size.height * 0.04,
          //           ),
          //           child: Column(
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Expanded(
          //                     child: Text(
          //                       'Factura',
          //                       style: GoogleFonts.poppins(
          //                           color: Colors.black87,
          //                           fontSize: size.width * 0.015,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                   ),
          //                   ElevatedButton(
          //                     onPressed: () async {
          //                       await launchUrl(Uri.parse(API_URL +
          //                           'descargardactura?numerofactura=${widget.numeroFactura}'));
          //                     },
          //                     child: Text('Reimprimir factura'),
          //                     style: ButtonStyle(
          //                         padding: MaterialStateProperty.all(
          //                             EdgeInsets.symmetric(
          //                                 horizontal: size.width * 0.015,
          //                                 vertical: 24)),
          //                         backgroundColor:
          //                             MaterialStateProperty.all(Colors.green)),
          //                   ),
          //                   SizedBox(
          //                     width: 10,
          //                   ),
          //                   ElevatedButton(
          //                     onPressed: () {
          //                       if (oculto) {
          //                         oculto = false;
          //                         animationController.reverse();
          //                       } else {
          //                         oculto = true;
          //                         animationController.forward();
          //                       }
          //                       // animationController.reverse();
          //                     },
          //                     child: Text((oculto)
          //                         ? 'Mostrar parte superior'
          //                         : 'Ocultar parte superior'),
          //                     style: ButtonStyle(
          //                         padding: MaterialStateProperty.all(
          //                             EdgeInsets.symmetric(
          //                                 horizontal: size.width * 0.015,
          //                                 vertical: 24)),
          //                         backgroundColor: MaterialStateProperty.all(
          //                             Colors.blue[800])),
          //                   ),
          //                   SizedBox(
          //                     width: 10,
          //                   ),
          //                   ElevatedButton(
          //                     onPressed: () {
          //                       Navigator.pop(context);
          //                     },
          //                     child: Text('Regresar'),
          //                     style: ButtonStyle(
          //                       padding: MaterialStateProperty.all(
          //                           EdgeInsets.symmetric(
          //                               horizontal: size.width * 0.015,
          //                               vertical: 24)),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               SizedBox(
          //                 height: 10,
          //               ),
          //               Transform.scale(
          //                 alignment: Alignment.topCenter,
          //                 scaleY: ocultacion.value,
          //                 child: (!animationController.isCompleted)
          //                     ? Container(
          //                         decoration: BoxDecoration(
          //                             color: Colors.white,
          //                             borderRadius: BorderRadius.all(
          //                                 Radius.circular(10))),
          //                         child: Row(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.spaceAround,
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.start,
          //                           children: [
          //                             Expanded(
          //                               flex: 3,
          //                               child: Container(
          //                                 padding: EdgeInsets.symmetric(
          //                                     vertical: 15, horizontal: 15),
          //                                 margin: EdgeInsets.symmetric(
          //                                     horizontal: 10),
          //                                 decoration: BoxDecoration(
          //                                     color: Colors.white,
          //                                     borderRadius: BorderRadius.all(
          //                                         Radius.circular(10))),
          //                                 child: Column(
          //                                   mainAxisAlignment:
          //                                       MainAxisAlignment.start,
          //                                   crossAxisAlignment:
          //                                       CrossAxisAlignment.start,
          //                                   children: [
          //                                     Text(
          //                                       'Datos del cliente',
          //                                       style: GoogleFonts.poppins(
          //                                           color: Colors.blue,
          //                                           fontWeight:
          //                                               FontWeight.w500),
          //                                     ),
          //                                     Divider(),
          //                                     datosSuperiores(
          //                                         'Nombre:',
          //                                         (datosCliente!.nombreCliente
          //                                                     .toString() !=
          //                                                 '')
          //                                             ? datosCliente
          //                                                 .nombreCliente
          //                                                 .toString()
          //                                             : 'NO EXISTE',
          //                                         flex1: 2,
          //                                         flex2: 8),
          //                                     datosSuperiores('RTN:',
          //                                         datosCliente.rtn.toString()),
          //                                     datosSuperiores(
          //                                         'DNI:',
          //                                         (datosCliente.dni != '')
          //                                             ? datosCliente.dni
          //                                                 .toString()
          //                                             : 'NO SE ENCONTRARON DATOS',
          //                                         flex1: 2,
          //                                         flex2: 8),
          //                                     datosSuperiores(
          //                                         'Teléfono:',
          //                                         datosCliente.telefonoCliente
          //                                             .toString()),
          //                                     datosSuperiores(
          //                                         'Correo:',
          //                                         (datosCliente.email != '')
          //                                             ? datosCliente.email
          //                                                 .toString()
          //                                             : 'NO SE ENCONTRARON DATOS'),
          //                                     datosSuperiores(
          //                                         'Dirección:',
          //                                         (datosCliente.direccion != '')
          //                                             ? datosCliente.direccion
          //                                                 .toString()
          //                                             : '----')
          //                                   ],
          //                                 ),
          //                               ),
          //                             ),
          //                             Expanded(
          //                               flex: 4,
          //                               child: Container(
          //                                 padding: EdgeInsets.symmetric(
          //                                     vertical: 15, horizontal: 15),
          //                                 margin: EdgeInsets.symmetric(
          //                                     horizontal: 10),
          //                                 decoration: BoxDecoration(
          //                                     color: Colors.white,
          //                                     borderRadius: BorderRadius.all(
          //                                         Radius.circular(10))),
          //                                 child: Column(
          //                                   mainAxisAlignment:
          //                                       MainAxisAlignment.start,
          //                                   crossAxisAlignment:
          //                                       CrossAxisAlignment.start,
          //                                   children: [
          //                                     Text(
          //                                       'Datos de facturación',
          //                                       style: GoogleFonts.poppins(
          //                                           color: Colors.blue,
          //                                           fontWeight:
          //                                               FontWeight.w500),
          //                                     ),
          //                                     Divider(),
          //                                     datosSuperiores(
          //                                       'Número:',
          //                                       campos.numeroFactura.toString(),
          //                                     ),
          //                                     datosSuperiores(
          //                                       'Fecha de emisión:',
          //                                       campos.fechaFactura
          //                                           .toString()
          //                                           .substring(0, 10),
          //                                     ),
          //                                     datosSuperiores(
          //                                         'CAI:',
          //                                         (campos.talonario!.cai != '')
          //                                             ? campos.talonario!.cai
          //                                             : 'N/A',
          //                                         flex1: 1,
          //                                         flex2: 9),
          //                                     datosSuperiores(
          //                                       'Rango autorizado:',
          //                                       (campos.talonario != null)
          //                                           ? '${campos.talonario!.rangoInicialFactura} - ${campos.talonario!.rangoFinalFactura}'
          //                                           : '------',
          //                                     ),
          //                                     datosSuperiores(
          //                                         'Fecha límite de emisión:',
          //                                         (campos.talonario != null)
          //                                             ? campos.talonario!
          //                                                 .fechaLimiteEmision
          //                                                 .toString()
          //                                                 .substring(0, 10)
          //                                             : '------'),
          //                                     datosSuperiores(
          //                                       'Establecimiento:',
          //                                       (campos.venta!
          //                                                   .establecimiento !=
          //                                               '')
          //                                           ? campos
          //                                               .venta!.establecimiento
          //                                           : 'NO DISPONIBLE',
          //                                     ),
          //                                     datosSuperiores(
          //                                       'Empleado:',
          //                                       (campos.empleado!.nombre != '')
          //                                           ? campos.empleado!.nombre
          //                                           : 'NO SE ENCONTRARON DATOS',
          //                                     ),
          //                                   ],
          //                                 ),
          //                               ),
          //                             ),
          //                             Expanded(
          //                               flex: 3,
          //                               child: Container(
          //                                 padding: EdgeInsets.symmetric(
          //                                     vertical: 15, horizontal: 15),
          //                                 margin: EdgeInsets.symmetric(
          //                                     horizontal: 10, vertical: 10),
          //                                 decoration: BoxDecoration(
          //                                     color: Colors.blue,
          //                                     borderRadius: BorderRadius.all(
          //                                         Radius.circular(10))),
          //                                 child: Column(
          //                                   mainAxisAlignment:
          //                                       MainAxisAlignment.start,
          //                                   crossAxisAlignment:
          //                                       CrossAxisAlignment.start,
          //                                   children: [
          //                                     datosSuperiores(
          //                                         'Sub total exonerado:',
          //                                         (campos.subTotalExonerado != '')?campos.subTotalExonerado:'0.00',
          //                                         color: Colors.white,
          //                                         flex1: 6,
          //                                         flex2: 4,
          //                                         crossAxisAlignment:
          //                                             CrossAxisAlignment.end),
          //                                     datosSuperiores(
          //                                         'Sub total excento:',
          //                                         totales.importeExcento.toStringAsFixed(2),
          //                                         color: Colors.white,
          //                                         flex1: 6,
          //                                         flex2: 4,
          //                                         crossAxisAlignment:
          //                                             CrossAxisAlignment.end),
          //                                     datosSuperiores('Importe gravado:',
          //                                         (totales.importeGravado15+totales.importeGravado18).toStringAsFixed(2),
          //                                         color: Colors.white,
          //                                         flex1: 6,
          //                                         flex2: 4),
          //                                     datosSuperiores('ISV:',
          //                                         (totales.isv15+totales.isv18).toStringAsFixed(2),
          //                                         color: Colors.white,
          //                                         flex1: 6,
          //                                         flex2: 4),
          //                                     datosSuperiores('Sub total:',
          //                                         totales.subTotalFactura.toStringAsFixed(2),
          //                                         color: Colors.white,
          //                                         flex1: 6,
          //                                         flex2: 4),
          //                                     Divider(),
          //                                     Text(
          //                                       'Total de venta:',
          //                                       style: GoogleFonts.poppins(
          //                                           color: Colors.white,
          //                                           fontWeight:
          //                                               FontWeight.w500),
          //                                     ),
          //                                     Text('L. '+totales.totalFactura.toStringAsFixed(2),
          //                                         style: GoogleFonts.poppins(
          //                                             color: Colors.white,
          //                                             fontSize:
          //                                                 size.width * 0.013,
          //                                             fontWeight:
          //                                                 FontWeight.w600))
          //                                   ],
          //                                 ),
          //                               ),
          //                             )
          //                           ],
          //                         ),
          //                       )
          //                     : SizedBox(),
          //               ),
          //               SizedBox(
          //                 height: size.height * 0.03,
          //               ),
          //               Expanded(
          //                   child: Container(
          //                 decoration: BoxDecoration(
          //                     color: Colors.white,
          //                     borderRadius:
          //                         BorderRadius.all(Radius.circular(10))),
          //                 padding: EdgeInsets.symmetric(
          //                     horizontal: size.width * 0.04,
          //                     vertical: size.height * 0.02),
          //                 child: (datosFactura.detallesDeVentas.isNotEmpty)
          //                     ? Column(
          //                         children: [
          //                           CabeceraDeTablaDeProductos(
          //                             size: size,
          //                           ),
          //                           Divider(),
          //                           Expanded(
          //                             child: ListView.separated(
          //                                 physics: BouncingScrollPhysics(),
          //                                 separatorBuilder: (_, i) => Divider(),
          //                                 itemCount: datosFactura
          //                                     .detallesDeVentas.length,
          //                                 itemBuilder: (_, i) => _facturaItemList(datosFactura
          //                                         .detallesDeVentas[i] ??
          //                                     DetallesDeVenta(
          //                                         id: -1,
          //                                         cantidad: 0,
          //                                         precioUnitario: '',
          //                                         isvAplicado: '',
          //                                         descuentoAplicado: '',
          //                                         totalDetalleVenta: '',
          //                                         isDelete: false,
          //                                         createdAt: DateTime.parse(
          //                                             '0000-00-00 00:00:00'),
          //                                         updatedAt: DateTime.parse(
          //                                             '0000-00-00 00:00:00'),
          //                                         idVentas: 0,
          //                                         idProducto: 0,
          //                                         producto: Producto(
          //                                             id: 0,
          //                                             codigoProducto: '',
          //                                             nombreProducto: '',
          //                                             precioProducto: '',
          //                                             cantidadProducto: 0,
          //                                             isvProducto: '',
          //                                             descProducto: '',
          //                                             isExcento: false,
          //                                             isDelete: false,
          //                                             createdAt: DateTime.parse(
          //                                                 '0000-00-00 00:00:00'),
          //                                             updatedAt:
          //                                                 DateTime.parse('0000-00-00 00:00:00'),
          //                                             idTipoProducto: 0)))),
          //                           ),
          //                         ],
          //                       )
          //                     : Center(
          //                         child: Text(
          //                             'No hay productos para esta venta.')),
          //               )),
          //             ],
          //           ),
          //         ),
          //       );
          //     });
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == 2) {
          return Scaffold(
              body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Ocurrió un error, contáctese con el administrador o presione recargar.'),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text('Recargar'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Regresar'),
                    ),
                  ],
                )
              ],
            ),
          ));
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == 'Ocurrió un error interno del servidor') {
          return Scaffold(
              body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ocurrió un error interno del servidor'),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('Recargar'),
                )
              ],
            ),
          ));
        } else {
          return Scaffold(
              body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: size.width * 0.05,
                    height: size.width * 0.05,
                    child: CircularProgressIndicator()),
                Text('Cargando, espere un momento.')
              ],
            ),
          ));
        }
      },
    );
  }

  Container _facturaItemList(DetallesDeVenta idProducto) {
    final producto = idProducto.producto;
    final detalleVenta = idProducto;
    Size size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                (producto != null)
                    ? producto.codigoProducto
                    : 'No especificado',
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                (producto != null)
                    ? producto.nombreProducto
                    : 'NO especificado',
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                detalleVenta.isvAplicado,
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                detalleVenta.cantidad.toString(),
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                detalleVenta.precioUnitario,
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
          ],
        ));
  }

  Row datosSuperiores(String campo, String valor,
      {Color? color,
      int? flex1,
      int? flex2,
      CrossAxisAlignment? crossAxisAlignment}) {
    return Row(
      crossAxisAlignment: (crossAxisAlignment == null)
          ? CrossAxisAlignment.start
          : crossAxisAlignment,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: (flex1 == null) ? 4 : flex1,
            child: Text(campo,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: (color != null) ? color : Colors.black87))),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: (flex2 == null) ? 6 : flex2,
          child: Text(
            valor,
            textAlign: TextAlign.end,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                color: (color != null) ? color : Colors.black87),
          ),
        ),
      ],
    );
  }
}
