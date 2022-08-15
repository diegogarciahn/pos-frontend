import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_frontend/models/ventaBuscada.model.dart';
import 'package:soft_frontend/screens/generarFactura/components/alertaimpresion.component.dart';
import '../../controllers/generarfactura.controller.dart';
import '../../models/tipoPagoBuscado.model.dart';
import '../../services/tipoPago.service.dart';
import 'escogerVenta.screen.dart';

class CrearFactura extends StatefulWidget {
  final MostrarVenta venta;
  const CrearFactura({Key? key, required this.venta}) : super(key: key);

  @override
  State<CrearFactura> createState() => _CrearFacturaState();
}

bool _hasBeenPressed = false;

class _CrearFacturaState extends State<CrearFactura> {
  List<TipoPagoBuscado> tipoPagos = [];
  var idVentaController = TextEditingController();
  var totalISVController = TextEditingController();
  var totalVentaController = TextEditingController();
  var totalDecuentoVentaController = TextEditingController();
  var puntoEmisionController = TextEditingController();
  var establecimientoController = TextEditingController();
  var subTotalExoneradoController = TextEditingController();
  var cantidadLetrasController = TextEditingController();
  var idTipoPagoController = TextEditingController();
  var idUsuarioController = TextEditingController();
  var idClienteController = TextEditingController();
  var nombreClienteController = TextEditingController();
  var rtnClienteController = TextEditingController();
  var dniClienteController = TextEditingController();
  var direccionClienteController = TextEditingController();
  var telefonoClienteController = TextEditingController();
  var idEmpleadoController = TextEditingController();
  var nombreEmpleadoController = TextEditingController();
  var estadoController = TextEditingController();
  //colocar fecha de hoy en un controlador
  var FechaController = TextEditingController();
  @override
  void initState() {
    super.initState();
    this._cargarFact();
  }

  _cargarFact() async {
    this.tipoPagos = await traerPago();
    setState(() {});
  }

  Widget build(BuildContext context) {
    estadoController.text = '1';
    idVentaController.text = widget.venta.id.toString();
    totalISVController.text = widget.venta.totalIsv.toString();
    totalVentaController.text = widget.venta.totalVenta.toString();
    totalDecuentoVentaController.text =
        widget.venta.totalDescuentoVenta.toString();
    puntoEmisionController.text = widget.venta.puntoDeEmision.toString();
    establecimientoController.text = widget.venta.establecimiento.toString();
    idUsuarioController.text = widget.venta.idUsuario.toString();
    idClienteController.text = widget.venta.idCliente.toString();
    nombreClienteController.text = widget.venta.nombreCliente.toString();
    dniClienteController.text = widget.venta.dni.toString();
    rtnClienteController.text = widget.venta.rtn.toString();
    direccionClienteController.text = widget.venta.direccionCliente.toString();
    idEmpleadoController.text = widget.venta.idEmpleado.toString();
    nombreEmpleadoController.text = widget.venta.nombreEmpleado.toString();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Procesar Tipo de pago para la factura'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seleccione un metodo de pago: ',
                    style: GoogleFonts.adamina(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Divider(),
                ],
              ),
            ),
            Expanded(child: _listViewTipoPag()),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                TextButton(
                  onPressed: null,
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          crearFactura_Controller(idVentaController.text,
                                  idTipoPagoController.text, context)
                              .then((value) {
                            dialogOpcionDeImpresion(context, value!, 1);

                            // descargarFacturaOriginal(context,
                            //     value!.insertfactura.numeroFactura, 1, 1);
                          }
                                  // => Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => ManipularFactura(),
                                  //       ),
                                  //     )
                                  );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text('Procesar Factura'),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListView _listViewTipoPag() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (_, i) => Divider(),
      itemCount: tipoPagos.length,
      itemBuilder: (_, i) => _pagoItemList(tipoPagos[i]),
    );
  }

  Container _pagoItemList(TipoPagoBuscado tipoPago) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RaisedButton(
              color: _hasBeenPressed
                  ? Color.fromARGB(255, 255, 255, 255)
                  : Color.fromARGB(255, 227, 233, 239),
              onPressed: () => {
                setState(() {
                  idTipoPagoController.text = tipoPago.idTipoPago.toString();
                  _hasBeenPressed = !_hasBeenPressed;
                })
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  tipoPago.idTipoPago.toString() +
                      '    -    ' +
                      tipoPago.tipoDePago,
                  style: GoogleFonts.adamina(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ));
  }
}
