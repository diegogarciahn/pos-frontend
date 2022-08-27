import 'package:flutter/material.dart';
import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/controllers/manipularfactura.controller.dart';
import 'package:soft_frontend/models/mostrarUnaFactura.model.dart';
import 'package:soft_frontend/screens/mostrarUnaFactura/components/cabeceradetabla.component.dart';
import 'package:url_launcher/url_launcher.dart';

import 'datosCabeceraDekstop.component.dart';

class MostrarUnaFacturaDekstop extends StatefulWidget {
  const MostrarUnaFacturaDekstop({Key? key, required this.datosFactura, required this.numeroFactura})
      : super(key: key);
  final MostrarUnaFactura datosFactura;
  final String numeroFactura;

  @override
  State<MostrarUnaFacturaDekstop> createState() =>
      _MostrarUnaFacturaDekstopState();
}

class _MostrarUnaFacturaDekstopState extends State<MostrarUnaFacturaDekstop>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> ocultacion;
  late final campos;
  late final totales;
  late final datosCliente;
  late final datosFactura;
  bool oculto = false;

  @override
  void initState() {
    totales = calcularTotales(widget.datosFactura.detallesDeVentas);
    campos = widget.datosFactura.facturaConDatos;
    datosCliente = widget.datosFactura.facturaConDatos.cliente;
    datosFactura = widget.datosFactura;
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
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 235, 235, 235),
            body: Container(
              margin: EdgeInsets.only(
                left: size.width * 0.04,
                right: size.width * 0.04,
                top: size.height * 0.04,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Factura',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: size.width * 0.015,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await launchUrl(Uri.parse(API_URL +
                              'descargardactura?numerofactura=${widget.numeroFactura}'));
                        },
                        child: Text('Reimprimir factura'),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: size.width * 0.015,
                                    vertical: 24)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (oculto) {
                            oculto = false;
                            animationController.reverse();
                          } else {
                            oculto = true;
                            animationController.forward();
                          }
                          // animationController.reverse();
                        },
                        child: Text((oculto)
                            ? 'Mostrar parte superior'
                            : 'Ocultar parte superior'),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: size.width * 0.015,
                                    vertical: 24)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue[800])),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Regresar'),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: size.width * 0.015,
                                  vertical: 24)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Transform.scale(
                    alignment: Alignment.topCenter,
                    scaleY: ocultacion.value,
                    child: (!animationController.isCompleted)
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Datos del cliente',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Divider(),
                                        datosSuperiores(
                                            'Nombre:',
                                            (datosCliente!.nombreCliente
                                                        .toString() !=
                                                    '')
                                                ? datosCliente.nombreCliente
                                                    .toString()
                                                : 'NO EXISTE',
                                            flex1: 2,
                                            flex2: 8),
                                        datosSuperiores('RTN:',
                                            datosCliente.rtn.toString()),
                                        datosSuperiores(
                                            'DNI:',
                                            (datosCliente.dni != '')
                                                ? datosCliente.dni.toString()
                                                : 'NO SE ENCONTRARON DATOS',
                                            flex1: 2,
                                            flex2: 8),
                                        datosSuperiores(
                                            'Teléfono:',
                                            datosCliente.telefonoCliente
                                                .toString()),
                                        datosSuperiores(
                                            'Correo:',
                                            (datosCliente.email != '')
                                                ? datosCliente.email.toString()
                                                : 'NO SE ENCONTRARON DATOS'),
                                        datosSuperiores(
                                            'Dirección:',
                                            (datosCliente.direccion != '')
                                                ? datosCliente.direccion
                                                    .toString()
                                                : '----')
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Datos de facturación',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Divider(),
                                        datosSuperiores(
                                          'Número:',
                                          campos.numeroFactura.toString(),
                                        ),
                                        datosSuperiores(
                                          'Fecha de emisión:',
                                          campos.fechaFactura
                                              .toString()
                                              .substring(0, 10),
                                        ),
                                        datosSuperiores(
                                            'CAI:',
                                            (campos.talonario!.cai != '')
                                                ? campos.talonario!.cai
                                                : 'N/A',
                                            flex1: 1,
                                            flex2: 9),
                                        datosSuperiores(
                                          'Rango autorizado:',
                                          (campos.talonario != null)
                                              ? '${campos.talonario!.rangoInicialFactura} - ${campos.talonario!.rangoFinalFactura}'
                                              : '------',
                                        ),
                                        datosSuperiores(
                                            'Fecha límite de emisión:',
                                            (campos.talonario != null)
                                                ? campos.talonario!
                                                    .fechaLimiteEmision
                                                    .toString()
                                                    .substring(0, 10)
                                                : '------'),
                                        datosSuperiores(
                                          'Establecimiento:',
                                          (campos.venta!.establecimiento != '')
                                              ? campos.venta!.establecimiento
                                              : 'NO DISPONIBLE',
                                        ),
                                        datosSuperiores(
                                          'Empleado:',
                                          (campos.empleado!.nombre != '')
                                              ? campos.empleado!.nombre
                                              : 'NO SE ENCONTRARON DATOS',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        datosSuperiores(
                                            'Sub total exonerado:',
                                            (campos.subTotalExonerado != '')
                                                ? campos.subTotalExonerado
                                                : '0.00',
                                            color: Colors.white,
                                            flex1: 6,
                                            flex2: 4,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end),
                                        datosSuperiores(
                                            'Sub total excento:',
                                            totales.importeExcento
                                                .toStringAsFixed(2),
                                            color: Colors.white,
                                            flex1: 6,
                                            flex2: 4,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end),
                                        datosSuperiores(
                                            'Importe gravado:',
                                            (totales.importeGravado15 +
                                                    totales.importeGravado18)
                                                .toStringAsFixed(2),
                                            color: Colors.white,
                                            flex1: 6,
                                            flex2: 4),
                                        datosSuperiores(
                                            'ISV:',
                                            (totales.isv15 + totales.isv18)
                                                .toStringAsFixed(2),
                                            color: Colors.white,
                                            flex1: 6,
                                            flex2: 4),
                                        datosSuperiores(
                                            'Sub total:',
                                            totales.subTotalFactura
                                                .toStringAsFixed(2),
                                            color: Colors.white,
                                            flex1: 6,
                                            flex2: 4),
                                        Divider(),
                                        Text(
                                          'Total de venta:',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                            'L. ' +
                                                totales.totalFactura
                                                    .toStringAsFixed(2),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 0.013,
                                                fontWeight: FontWeight.w600))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : SizedBox(),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                        vertical: size.height * 0.02),
                    child: (datosFactura.detallesDeVentas.isNotEmpty)
                        ? Column(
                            children: [
                              CabeceraDeTablaDeProductos(
                                size: size,
                              ),
                              Divider(),
                              Expanded(
                                child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    separatorBuilder: (_, i) => Divider(),
                                    itemCount:
                                        datosFactura.detallesDeVentas.length,
                                    itemBuilder: (_, i) => _facturaItemList(
                                        datosFactura.detallesDeVentas[i] ??
                                            DetallesDeVenta(
                                                id: -1,
                                                cantidad: 0,
                                                precioUnitario: '',
                                                isvAplicado: '',
                                                descuentoAplicado: '',
                                                totalDetalleVenta: '',
                                                isDelete: false,
                                                createdAt: DateTime.parse(
                                                    '0000-00-00 00:00:00'),
                                                updatedAt: DateTime.parse(
                                                    '0000-00-00 00:00:00'),
                                                idVentas: 0,
                                                idProducto: 0,
                                                producto: Producto(
                                                    id: 0,
                                                    codigoProducto: '',
                                                    nombreProducto: '',
                                                    precioProducto: '',
                                                    cantidadProducto: 0,
                                                    isvProducto: 0,
                                                    descProducto: '',
                                                    isExcento: false,
                                                    isDelete: false,
                                                    createdAt: DateTime.parse(
                                                        '0000-00-00 00:00:00'),
                                                    updatedAt: DateTime.parse(
                                                        '0000-00-00 00:00:00'),
                                                    idTipoProducto: 0)
                                                    )
                                                    )
                                                    ),
                              ),
                            ],
                          )
                        : Center(
                            child: Text('No hay productos para esta venta.')),
                  )),
                ],
              ),
            ),
          );
        });
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
                style: TextStyle(fontSize: size.width * 0.012),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                (producto != null)
                    ? producto.nombreProducto
                    : 'NO especificado',
                style: TextStyle(fontSize: size.width * 0.012),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                detalleVenta.isvAplicado.toString(),
                style: TextStyle(fontSize: size.width * 0.012),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                detalleVenta.cantidad.toString(),
                style: TextStyle(fontSize: size.width * 0.012),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                detalleVenta.precioUnitario,
                style: TextStyle(fontSize: size.width * 0.012),
              ),
            ),
          ],
        ));
  }
}
