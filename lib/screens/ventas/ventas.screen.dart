// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/ventas.controller.dart';
import 'package:soft_frontend/models/IdDetalleVenta.model.dart';
import 'package:soft_frontend/models/IdVenta.model.dart';
import 'package:soft_frontend/models/ProductoBuscado.model.dart';
import 'package:soft_frontend/models/detalleventa.model.dart';
import 'package:soft_frontend/models/ventas.model.dart';

import 'package:soft_frontend/services/cliente.service.dart';
import 'package:soft_frontend/models/cliente.model.dart';
import 'package:soft_frontend/models/cliente.model.dart';
import 'package:soft_frontend/services/detalleventa.service.dart';
import 'package:soft_frontend/screens/arqueo/mostrarArqueo.screen.dart';

import '../../controllers/Arqueo.controller.dart';
import '../../controllers/detalleventa.controller.dart';
import '../../services/ventas.service.dart';

class VentanaVenta extends StatefulWidget {
  const VentanaVenta({Key? key}) : super(key: key);

  @override
  State<VentanaVenta> createState() => _VentanaVentaState();
}



class _VentanaVentaState extends State<VentanaVenta> {
  var rtnController = TextEditingController();
  var dniController = TextEditingController();
  var nombreCliente = TextEditingController();
  var telCliente = TextEditingController();
  var codProductoController = TextEditingController();
  var cantidadProducController = TextEditingController();
  var total = "0";
  var subTotal = "0";
  var descuentos = "0";
  var impuestos = "0";
  var totalISVController = TextEditingController();
  var totalVentaController = TextEditingController();
  var totalDescuentoVentaController = TextEditingController();
  bool botonesHabilitados = false;
  int idVentaActual = -1;
  int idDetalleActual = 0;
  late DetalleDeVentasXid datosDetalle;
  double subtotal = 0;
  int isExcento = 0;
  bool isExcento2 = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Nueva Venta'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, 'PrincipalVentas');
            },
            child: Text('Regresar',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          TextButton(
            onPressed: () {
              _showDialogCerrarSesion(context);
            },
            child: Text('Cerrar Turno',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: SingleChildScrollView(

                     scrollDirection: Axis.horizontal,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: TextButton(
                            onPressed: null,
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (botonesHabilitados) {
                                    null;
                                  } else {

                                    Navigator.pushNamed(
                                        context, 'crear_cliente');

                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text('Agregar Cliente'),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: (!botonesHabilitados)
                                      ? MaterialStateProperty.all(Colors.blue)
                                      : MaterialStateProperty.all(
                                          Color.fromARGB(255, 194, 194, 194)),
                                  elevation: (botonesHabilitados)
                                      ? MaterialStateProperty.all(0)
                                      : MaterialStateProperty.all(5.0),
                                  // foregroundColor: MaterialStateProperty.all(Colors.black)
                                  overlayColor: (botonesHabilitados)
                                      ? MaterialStateProperty.all(
                                          Color.fromARGB(255, 194, 194, 194))
                                      : MaterialStateProperty.all(
                                          Color.fromARGB(255, 35, 156, 255)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.2,
                                child: TextFormField(
                                  controller: dniController,
                                  decoration: InputDecoration(
                                      labelText: 'Identidad del Cliente'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () async {

                              final respuesta = await habilitarVenta(dniController,
                                  nombreCliente, telCliente, context);

                              if (respuesta is IdVenta) {
                                idVentaActual = respuesta.id;
                                botonesHabilitados = true;
                                setState(() {});
                              } else {
                                botonesHabilitados = false;
                                setState(() {});
                              }
                            },
                            child: const Icon(Icons.search)),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.2,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: nombreCliente,
                                  decoration: InputDecoration(
                                      labelText: 'Nombre del Cliente'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.2,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: telCliente,
                                  decoration: InputDecoration(
                                      labelText: 'Telefono del Cliente'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                          width: size.width * 0.2,
                          child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "Excento",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                        ),
                        Container(
                          width: size.width * 0.20,
                          child: Row(
                            children: [
                              Expanded(
                                child: RadioListTile<int>(
                                value: 1,
                                groupValue: isExcento,
                                title: Text('Si', style: TextStyle(fontSize: 15),
                                ),
                                onChanged: (value) { setState(() => isExcento = 1);
                                isExcento2 = true;
                                },
                              ),
                            ),
                              Expanded(
                              child: RadioListTile<int>(
                              value: 0,
                              groupValue: isExcento,
                              title: Text('No',  style: TextStyle(fontSize: 15)),
                              onChanged: (value) {
                              setState(() => isExcento = 0);
                              isExcento2 = false;
                              }
                            ),
                          ),
                      ],
                    ),
                        ),

                          Container(
                            width: size.width * 0.2,
                            child: TextFormField(
                              controller: codProductoController,
                              decoration: InputDecoration(
                                  labelText: 'Codigo De Producto'),
                            ),
                          ),
                          Container(
                            width: size.width * 0.2,
                            child: TextFormField(
                              controller: cantidadProducController,
                              decoration:
                                  InputDecoration(labelText: 'Cantidad'),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (botonesHabilitados) {
                                      _showDialog(context);
                                    } else {
                                      null;
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Text('Anular'),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: (botonesHabilitados)
                                        ? MaterialStateProperty.all(Colors.red)
                                        : MaterialStateProperty.all(
                                            Color.fromARGB(255, 194, 194, 194)),
                                    elevation: (!botonesHabilitados)
                                        ? MaterialStateProperty.all(0)
                                        : MaterialStateProperty.all(5.0),
                                    // foregroundColor: MaterialStateProperty.all(Colors.black)
                                    overlayColor: (!botonesHabilitados)
                                        ? MaterialStateProperty.all(
                                            Color.fromARGB(255, 194, 194, 194))
                                        : MaterialStateProperty.all(
                                            Color.fromARGB(255, 255, 72, 59)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (botonesHabilitados) {
                                      final response =
                                          await buscarProductoController(
                                              codProductoController,
                                              cantidadProducController,
                                              isExcento2,
                                              idVentaActual,
                                              context);
                                      if (response == DetalleDeVentasXid) {
                                        // idDetalleActual = response.id;
                                        datosDetalle = response;
                                        print('object');

                                        setState(() {});
                                      } else {
                                        print('object2');
                                        Future<List<String>> _total =
                                            mostrarTotales(idVentaActual);
                                        _total.then((value) {
                                          print(value);
                                          total = value[0];
                                          impuestos = value[1];
                                          descuentos = value[2];
                                          subTotal = value[3];
                                          setState(() {});
                                        });
                                      }
                                    } else {
                                      //null;
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Text('Agregar Producto'),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: (botonesHabilitados)
                                        ? MaterialStateProperty.all(Colors.blue)
                                        : MaterialStateProperty.all(
                                            Color.fromARGB(255, 194, 194, 194)),
                                    elevation: (!botonesHabilitados)
                                        ? MaterialStateProperty.all(0)
                                        : MaterialStateProperty.all(5.0),
                                    // foregroundColor: MaterialStateProperty.all(Colors.black)
                                    overlayColor: (!botonesHabilitados)
                                        ? MaterialStateProperty.all(
                                            Color.fromARGB(255, 194, 194, 194))
                                        : MaterialStateProperty.all(
                                            Color.fromARGB(255, 35, 156, 255)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (botonesHabilitados) {
                                  Future<String> editar = actualizarVenta(
                                      idVentaActual.toString(),
                                      impuestos,
                                      total,
                                      descuentos);
                                  editar.then((value) {
                                    print('asjasd');

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Venta añadida con exito')));

                                    Navigator.pushReplacementNamed(
                                        context, 'mostrar_ventas');
                                  });
                                } else {
                                  null;
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text('Realizar Venta'),
                              ),
                              style: ButtonStyle(
                                backgroundColor: (botonesHabilitados)
                                    ? MaterialStateProperty.all(Colors.green)
                                    : MaterialStateProperty.all(
                                        Color.fromARGB(255, 194, 194, 194)),
                                elevation: (!botonesHabilitados)
                                    ? MaterialStateProperty.all(0)
                                    : MaterialStateProperty.all(5.0),
                                // foregroundColor: MaterialStateProperty.all(Colors.black)
                                overlayColor: (!botonesHabilitados)
                                    ? MaterialStateProperty.all(
                                        Color.fromARGB(255, 194, 194, 194))
                                    : MaterialStateProperty.all(
                                        Color.fromARGB(255, 84, 194, 88)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Descuento',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    descuentos,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Sub Total',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    subTotal,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Impuesto',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    impuestos,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Total a Cancelar',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    total,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Codigo',
                                      style: TextStyle(
                                          fontSize: size.width * 0.009,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Nombre del Producto',
                                      style: TextStyle(
                                          fontSize: size.width * 0.009,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Precio',
                                      style: TextStyle(
                                          fontSize: size.width * 0.009,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Cantidad',
                                      style: TextStyle(
                                          fontSize: size.width * 0.009,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'ISV',
                                      style: TextStyle(
                                          fontSize: size.width * 0.009,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Descuento',
                                      style: TextStyle(
                                          fontSize: size.width * 0.009,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Total',
                                      style: TextStyle(
                                          fontSize: size.width * 0.009,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Opciones',
                                      style: TextStyle(
                                          fontSize: size.width * 0.009,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            Container(
                                width: size.width * 0.7,
                                height: size.height * 0.6,
                                child: (idVentaActual != -1)
                                    ? Expanded(
                                        child: FutureBuilder(
                                            future: mostrardetalleventa(
                                                idVentaActual),
                                            builder: (context,
                                                AsyncSnapshot<dynamic>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                      ConnectionState.done &&
                                                  snapshot.data
                                                      is DetalleDeVentasXid) {
                                                DetalleDeVentasXid
                                                    datosDetalle2 =
                                                    snapshot.data;
                                                return ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: datosDetalle2
                                                      .detalleDeVentaNueva
                                                      .length,
                                                  itemBuilder: (_, i) =>
                                                      _facturaItemList(datosDetalle2
                                                          .detalleDeVentaNueva[i]),
                                                );
                                              } else {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                            }),
                                      )
                                    : SizedBox()),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _facturaItemList(DetalleDeVentaNueva idProducto) {
    final producto = idProducto;
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
                    ? producto.producto.codigoProducto
                    : 'No especificado',
                style: TextStyle(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                (producto != null)
                    ? producto.producto.nombreProducto
                    : 'NO especificado',
                style: TextStyle(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                detalleVenta.precioUnitario,
                style: TextStyle(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                detalleVenta.cantidad.toString(),
                style: TextStyle(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                detalleVenta.isvAplicado,
                style: TextStyle(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                detalleVenta.descuentoAplicado,
                style: TextStyle(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                detalleVenta.totalDetalleVenta,
                style: TextStyle(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
                flex: 1,
                child: TextButton(
                  child: Text('Eliminar'),
                  onPressed: () {
                    Future<DetalleDeVentasXid?> eliminarDetalle =
                        eliminarDetalle_Controller(
                            detalleVenta.id.toString(), context);
                    eliminarDetalle.then((value) {
                      Future<List<String>> _total =
                          mostrarTotales(idVentaActual);
                      _total.then((value) {
                        print(value);
                        total = value[0];
                        impuestos = value[1];
                        descuentos = value[2];
                        subTotal = value[3];
                        setState(() {});
                      });
                    });

                    // _showDialog(context, lista.id.toString());
                  },
                )),
          ],
        ));
  }

  void _showDialogCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cerrar Turno'),
          content: Text('¿Quieres cerrar el Turno?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Si'),
              onPressed: () {
                actualizarArqueoCerrandoSesion_Controller(context);
              },
            ),
            ElevatedButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Cerrar Sesion"),
          content: Text("¿Esta seguro que quiere anular la venta?"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Si"),
              onPressed: () {
                eliminarVenta_Controller(idVentaActual.toString(), context);
              },
            ),
            ElevatedButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
