import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:soft_frontend/models/models.dart';
import 'package:soft_frontend/screens/manipularFactura/components/itemListMobile.component.dart';
import 'package:soft_frontend/screens/mostrarUnaFactura/mostrarunafactura.screen.dart';
import 'package:soft_frontend/screens/manipularFactura/components/cabeceradetabla.component.dart';
import '../../controllers/manipularfactura.controller.dart';

typedef void IntCallback(int opcion);

class ManipularFactura extends StatefulWidget {
  const ManipularFactura({Key? key}) : super(key: key);
  @override
  State<ManipularFactura> createState() => _ManipularFacturaState();
}

class _ManipularFacturaState extends State<ManipularFactura> {
  // Para poder manipular el textField.
  final _textController = new TextEditingController();
  final _textController2 = new TextEditingController();
  // Para inicializar el hintText del dropdown.
  String hintText = 'Número de factura';
  // Para mostrar la lista de facturas al iniciar la pantalla o sin realizar.
  // una búsqueda o filtro.
  List<FacturaBuscada> facturas = [];
  // Para listar facturas después de hacer una búsqueda.
  List<FacturaBuscada> facturasTemp = [];
  // Para saber por que campo se realizará la búsqueda (áreas de búsqueda).
  // Las 5 que aparecen en el dropdown.
  int campos = 1000;
  // Para saber el atributo especifico por el cual que se realiza la búsqueda
  // Ej: Cliente tiene 3: DNI, Nombre y RTN.
  int _atributoSeleccionado = 0;
  // Para mostrar en pantalla el listado de facturas buscadas o filtradas y
  // Ocultar la lista de facturas inicial.
  bool mostrarListaFacturasTemporal = false;
  // Para mostrar en la versión móvil los 5 FAB verticales (Abierto) o solo un FAB (Cerrado).
  bool mostrarOpcionesDeBusquedaMovil = false;
  // Para mostrar el textFiled en la versión móvil.
  bool mostrarCamposDeBusquedaMovil = false;
  // Para ocultar el FAB de búsqueda en la versión móvil al momento de estar
  // en el formulario de búsqueda emergente.
  bool ocultarFAB = false;

  @override
  void initState() {
    super.initState();
    // _cargarFact();
  }

  // Callback para retornar desde el widget CamposBuscados(textField personalizado)
  // El atributo especifico seleccionado.
  set intSele(int value) => setState(() => _atributoSeleccionado = value);

  @override
  Widget build(BuildContext context) {
    // print('campos: $campos');
    // print('Atributo: $_atributoSeleccionado');
    Size size = MediaQuery.of(context).size;
    print('size width: ${size.width}');
    return FutureBuilder(
        future: listarFacturas(context),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot.data);
          // Validar si la función listarFacturas terminó de ejecutarse y si recibió data.
          if ((snapshot.connectionState == ConnectionState.done) &&
              (snapshot.data is ManipularFacturaResponse)) {
            ManipularFacturaResponse response = snapshot.data;
            facturas = response.facturas;
            return Scaffold(
              // Validar tamaño de pantalla, si es menor a 800  mostrar APPBAR de lo contrario nada.
              appBar: (size.width < 800)
                  // Menor a 800: Muestra AppBar.
                  ? AppBar(
                      title: Text('Buscar facturas'),
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, 'PrincipalVenta');
                        },
                      ),
                    )
                  // Mayor a 800: No muestra AppBar.
                  : null,
              backgroundColor: Color.fromARGB(255, 243, 243, 243),
              // Validar tamaño de la pantalla, si es menor a 800 (móvil) mostrar floatinActionButton (FAB) de búsqueda.
              floatingActionButton: (size.width < 800)
                  // Menor a 800: Mostrar FAB.
                  // Validar variable ocultarFAB para ocultarFAB aunque la pantalla sea menor a 800 de width.
                  ? (!ocultarFAB)
                      // ocultarFAB Verdadero: Mostrar FAB.
                      // Validar si quiere mostrar el FAB solo o la columna de FAB.
                      ? (!mostrarOpcionesDeBusquedaMovil)
                          // mostrarOpcionesDeBusquedaMovil falso: mostrar el FAB de búsqueda.
                          ? FloatingActionButton(
                              onPressed: () {
                                mostrarOpcionesDeBusquedaMovil = true;
                                setState(() {});
                              },
                              child: Icon(Icons.search))
                          // mostrarOpcionesDeBusquedaMovil verdadero: mostrar la columna de FAB de búsqueda.
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                floatinActionButtonMobileItem(size,
                                    'Por número de factura', Icons.numbers, () {
                                  ocultarFAB = true;
                                  campos = 0;
                                  _atributoSeleccionado = 0;
                                  mostrarOpcionesDeBusquedaMovil = false;
                                  mostrarCamposDeBusquedaMovil = true;
                                  setState(() {});
                                }),
                                floatinActionButtonMobileItem(
                                    size, 'Por cliente', Icons.person, () {
                                  ocultarFAB = true;
                                  campos = 1;
                                  _atributoSeleccionado = 0;
                                  mostrarOpcionesDeBusquedaMovil = false;
                                  mostrarCamposDeBusquedaMovil = true;
                                  setState(() {});
                                }),
                                floatinActionButtonMobileItem(
                                    size, 'Por fecha', Icons.calendar_today,
                                    () {
                                  ocultarFAB = true;
                                  campos = 2;
                                  _atributoSeleccionado = 0;
                                  mostrarOpcionesDeBusquedaMovil = false;
                                  mostrarCamposDeBusquedaMovil = true;
                                  setState(() {});
                                }),
                                floatinActionButtonMobileItem(
                                    size,
                                    'Por talonario',
                                    Icons.library_books_outlined, () {
                                  ocultarFAB = true;
                                  campos = 3;
                                  _atributoSeleccionado = 0;
                                  mostrarOpcionesDeBusquedaMovil = false;
                                  mostrarCamposDeBusquedaMovil = true;
                                  setState(() {});
                                }),
                                floatinActionButtonMobileItem(
                                    size,
                                    'Por empleado',
                                    Icons.assignment_ind_outlined, () {
                                  ocultarFAB = true;
                                  campos = 4;
                                  _atributoSeleccionado = 0;
                                  mostrarOpcionesDeBusquedaMovil = false;
                                  mostrarCamposDeBusquedaMovil = true;
                                  setState(() {});
                                }),
                                FloatingActionButton(
                                    onPressed: () {
                                      mostrarOpcionesDeBusquedaMovil = false;
                                      setState(() {});
                                    },
                                    child: Icon(Icons.close)),
                              ],
                            )
                      // ocultarFAB falso: no mostrar FAB.
                      : null
                  // Mayor a 800: no mostrar FAB.
                  : null,
              body: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                        horizontal: size.width * 0.03),
                    child: Column(
                      children: [
                        // Validar tamaño de la pantalla (ancho), Si es mayor a 800 mostrar titulo y botón regresar.
                        (size.width > 800)
                            // Mayor a 800: mostrar titulo y botón regresar.
                            ? Row(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: size.width * 0.01),
                                      child: Text(
                                        'Buscar Factura',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black87,
                                            fontSize: size.width * 0.015,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.popAndPushNamed(
                                          context, 'PrincipalVenta');
                                    },
                                    child: Text(
                                      'Regresar',
                                      style: GoogleFonts.lato(),
                                    ),
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              horizontal: size.width * 0.015,
                                              vertical: 26)),
                                    ),
                                  )
                                ],
                              )
                            // Menor a 800: No mostrar titulo y botón regresar.
                            : SizedBox(),
                        SizedBox(
                          height: 15,
                        ),
                        // Validar tamaño de la pantalla (ancho), Si es menor a 800 mostrar dropdown, textfield y botón buscar.
                        (size.width > 800)
                            // Mayor a 800: Mostrar dropdown, textfield y botón buscar.
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    DropdownButton(
                                      hint: Text(hintText),
                                      items: const [
                                        DropdownMenuItem(
                                          child: Text(
                                              'Buscar por número de factura'),
                                          value: 0,
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Filtrar por cliente'),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Filtrar por fecha'),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Filtrar por talonario'),
                                          value: 3,
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Filtrar por empleado'),
                                          value: 4,
                                        ),
                                      ],
                                      onChanged: (int? value) {
                                        switch (value) {
                                          case 0:
                                            campos = 0;
                                            _atributoSeleccionado = 0;
                                            hintText =
                                                'Buscar por número de factura';
                                            facturasTemp.clear();
                                            mostrarListaFacturasTemporal =
                                                false;
                                            break;
                                          case 1:
                                            campos = 1;
                                            _atributoSeleccionado = 0;
                                            hintText = 'Filtrar por cliente';
                                            facturasTemp.clear();
                                            mostrarListaFacturasTemporal =
                                                false;
                                            break;
                                          case 2:
                                            campos = 2;
                                            _atributoSeleccionado = 0;
                                            hintText = 'Filtrar por fecha';
                                            facturasTemp.clear();
                                            mostrarListaFacturasTemporal =
                                                false;
                                            break;
                                          case 3:
                                            campos = 3;
                                            _atributoSeleccionado = 0;
                                            hintText = 'Filtrar por talonario';
                                            facturasTemp.clear();
                                            mostrarListaFacturasTemporal =
                                                false;
                                            break;
                                          case 4:
                                            campos = 4;
                                            _atributoSeleccionado = 0;
                                            hintText = 'Filtrar por empleado';
                                            facturasTemp.clear();
                                            mostrarListaFacturasTemporal =
                                                false;
                                            break;
                                          default:
                                        }
                                        _textController.clear();
                                        _textController2.clear();
                                        setState(() {});
                                      },
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.02),
                                      child: CamposDeBusqueda(
                                          textController: _textController,
                                          textController2: _textController2,
                                          campo: campos,
                                          atributoEscogido:
                                              _atributoSeleccionado,
                                          callback: (val) => setState(() =>
                                              _atributoSeleccionado = val)),
                                    )),
                                    Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            // print('campos y atributo de el btn: $campos & $_atributoSeleccionado');
                                            // Valida si el campo de búsqueda está vacío.
                                            await submitSearch(context, size);
                                          },
                                          child: Text(
                                            'Buscar',
                                            style: GoogleFonts.lato(),
                                          ),
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.width * 0.015,
                                                    vertical: 26)),
                                          ),
                                        ),
                                        (mostrarListaFacturasTemporal)
                                            ? SizedBox(
                                                height: 10,
                                              )
                                            : SizedBox(),
                                        (mostrarListaFacturasTemporal)
                                            ? ElevatedButton(
                                                onPressed: () async {
                                                  mostrarListaFacturasTemporal =
                                                      false;
                                                  facturasTemp.clear();
                                                  setState(() {});
                                                },
                                                child: Text(
                                                  'Limpiar',
                                                  style: GoogleFonts.lato(),
                                                ),
                                                style: ButtonStyle(
                                                  padding:
                                                      MaterialStateProperty.all(
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  size.width *
                                                                      0.015,
                                                              vertical: 26)),
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    )
                                  ])
                            // Menor a 800: No mostrar dropdown, textfield y botón buscar.
                            : SizedBox(),
                        // Validar tamaño de la pantalla (ancho), Si es menor a 800 y la variable mostrarListaFacturasTemporal
                        // Es verdadera, mostrar botón limpiar búsqueda, caso contrario, no mostrar botón limpiar búsqueda.
                        (size.width < 800 && mostrarListaFacturasTemporal)
                            // Menor a 800 y mostrarListaFacturasTemporal verdadero: mostrar botón limpiar búsqueda.
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    child: Text('Limpiar búsqueda'),
                                    onPressed: () {
                                      mostrarListaFacturasTemporal = false;
                                      facturasTemp.clear();
                                      setState(() {});
                                    },
                                  ),
                                ],
                              )
                            // Mayor a 800 y mostrarListaFacturasTemporal falso: no mostrar botón limpiar búsqueda.
                            : SizedBox(),
                        // Validar tamaño de la pantalla, Si es mayor a 800 mostrar tabla de facturas dekstop, Si es menor
                        // Mostrar lista de tarjetas para dispositivos móviles.
                        (size.width > 800)
                            // Mayor a 800: mostrar tabla de facturas dekstop (Incluye cabecera de tabla).
                            ? Expanded(
                                child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: size.height * 0.02),
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.02,
                                        horizontal: size.height * 0.03),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Column(
                                      children: [
                                        CabeceraDeTabla(size: size),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Expanded(
                                            child: _listViewUsuarios(
                                                context, size)),
                                      ],
                                    )))
                            // Menor a 800: Mostrar lista de tarjetas para dispositivos móviles.
                            : Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: _listViewUsuarios(context, size),
                                ),
                              )
                      ],
                    ),
                  ),
                  // Validar tamaño de la pantalla, si es menor a 800 y la variable
                  // mostrarOpcionesDeBusquedaMovil es verdadero, mostrará
                  // Un fondo oscuro al mostrar los FAB.
                  ((size.width < 800 && mostrarOpcionesDeBusquedaMovil) ||
                          mostrarCamposDeBusquedaMovil)
                      // Menor a 800 y mostrarOpcionesDeBusquedaMovil verdadero:
                      // Mostrará fondo opaco al estar activo los FAB
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.black12,
                          ),
                        )
                      // Mayor a 800 y mostrarOpcionesDeBusquedaMovil falso:
                      // No mostrará nada (pantalla normal).
                      : SizedBox(),
                  // Validar tamaño de la pantalla, si es menor a 800 y la variable
                  // mostrarCamposDeBusquedaMovil es verdadero, mostrará
                  // Formulario de búsqueda (textfield personalizado).
                  (size.width < 800 && mostrarCamposDeBusquedaMovil)
                      // Menor a 800 y mostrarCamposDeBusquedaMovil verdadero:
                      // Mostrará campos de búsqueda (textfield personalizado).
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04, vertical: 15),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04, vertical: 15),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CamposDeBusqueda(
                                  textController: _textController,
                                  campo: campos,
                                  textController2: _textController2,
                                  atributoEscogido: _atributoSeleccionado,
                                  callback: (val) => setState(
                                      () => _atributoSeleccionado = val)),
                              SizedBox(
                                height: 28,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        await submitSearch(context, size);
                                        _textController.clear();
                                        _textController2.clear();
                                        ocultarFAB = false;
                                        mostrarCamposDeBusquedaMovil = false;
                                        campos = 0;
                                        _atributoSeleccionado = 0;
                                        setState(() {});
                                      },
                                      child: Text('Buscar')),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        ocultarFAB = false;
                                        mostrarCamposDeBusquedaMovil = false;
                                        campos = 0;
                                        _atributoSeleccionado = 0;
                                        setState(() {});
                                      },
                                      child: Text('Cerrar')),
                                ],
                              )
                            ],
                          ),
                        )
                      // No mostrará campos de búsqueda.
                      : SizedBox(),
                ],
              ),
            );
          } else if (snapshot.data == 2 &&
              snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Ocurrió un error al hacer la conexión con el servidor, contáctese con el administrador o presione recargar.'),
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
          } else if (snapshot.data == 500 &&
              snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Ocurrió un error interno en el servidor, contáctese con el administrador o presione recargar.'),
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
        });
  }

  Future<void> submitSearch(BuildContext context, Size size) async {
    if (_textController.text.trim().isNotEmpty) {
      switch (campos) {
        //Búsqueda por cliente.
        case 1:
          // Tipo de atributo de cliente par hacer la búsqueda.
          switch (_atributoSeleccionado) {
            // Por nombre de cliente
            case 0:
              facturasTemp.clear();
              await filtrarFacturasPorNombreCliente(_textController,
                  (val) => setState(() => facturasTemp = val), context);
              break;
            // Por RTN
            case 1:
              facturasTemp.clear();
              await filtrarFacturasPorRTNCliente(_textController,
                  (val) => setState(() => facturasTemp = val), context);
              break;
            // Por DNI
            case 2:
              facturasTemp.clear();
              await filtrarFacturasPorDNICliente(_textController,
                  (val) => setState(() => facturasTemp = val), context);
              break;
            default:
          }
          break;
        //Búsqueda por fecha
        case 2:
          facturasTemp.clear();
          await filtrarFacturasPorFechaController(
              _textController,
              _textController2,
              (val) => setState(() => facturasTemp = val),
              context);
          break;
        //Búsqueda por talonario
        case 3:
          // if (_atributoSeleccionado == 0) {
          //   facturasTemp.clear();
          //   await filtrarFacturasPorIdTalonario(_textController,
          //       (val) => setState(() => facturasTemp = val), context);
          //   // Si la búsqueda es por CAI
          // } else if (_atributoSeleccionado == 1) {
          facturasTemp.clear();
          await filtrarFacturasPorCAI(_textController,
              (val) => setState(() => facturasTemp = val), context);
          // }
          break;
        // Búsqueda por empleado
        case 4:
          facturasTemp.clear();
          await filtrarFacturasPorNombreEmpleado(_textController,
              (val) => setState(() => facturasTemp = val), context);
          break;
        // Búsqueda por número de factura
        default:
          await buscarFacturaPorNumeroFact(_textController, size, context);
      }
      if (facturasTemp.isNotEmpty) {
        mostrarListaFacturasTemporal = true;
        setState(() {});
      }
      // Si el campo de búsqueda está vacío indica la alerta.
    } else {
      dialogMensajeProblema(context, 'El campo de búsqueda está vacío.');
    }
  }

  Widget floatinActionButtonMobileItem(
      Size size, String texto, IconData icono, VoidCallback funcion) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: EdgeInsets.only(right: size.width * 0.02),
              padding: EdgeInsets.symmetric(
                  vertical: 5, horizontal: size.width * 0.02),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 0.01))),
              child: Text(texto)),
          FloatingActionButton(
            onPressed: funcion,
            child: Icon(icono),
          ),
        ],
      ),
    );
  }

  Future<dynamic> dialogMensajeProblema(BuildContext context, String texto) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(texto),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cerrar'))
              ],
            ));
  }

  ListView _listViewUsuarios(context, Size size) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (_, i) =>
          Divider(color: (size.width > 800) ? Colors.grey : Colors.transparent),
      itemCount: (mostrarListaFacturasTemporal)
          ? facturasTemp.length
          : facturas.length,
      itemBuilder: (_, i) => (size.width > 800)
          ? _facturaItemList(
              (mostrarListaFacturasTemporal) ? facturasTemp[i] : facturas[i],
              context)
          : facturaItemListMobile(
              (mostrarListaFacturasTemporal) ? facturasTemp[i] : facturas[i],
              context),
    );
  }

  Container _facturaItemList(FacturaBuscada factura, context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: SelectableText(
                factura.numeroFactura,
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 1,
              child: SelectableText(
                factura.fechaFactura.toString().substring(0, 10),
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 1,
              child: SelectableText(
                factura.totalFactura.toString(),
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 2,
              child: SelectableText(
                factura.nombreEmpleado.toString(),
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 3,
              child: SelectableText(
                (factura.cai ==
                        'No existe un talonario asociado a este CAI por favor comuniquese con el administrador.')
                    ? 'N/A'
                    : factura.cai.toString(),
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 2,
              child: SelectableText(
                factura.nombreCliente.toString(),
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
              flex: 1,
              child: SelectableText(
                factura.rtn.toString(),
                style: GoogleFonts.lato(fontSize: size.width * 0.009),
              ),
            ),
            Expanded(
                flex: 1,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MostrarFactura(
                                  numeroFactura: factura.numeroFactura)));
                    },
                    child: Icon(Icons.visibility)))
          ],
        ));
  }

  int retornarOpcion(int opcion) {
    return opcion;
  }
}

class CamposDeBusqueda extends StatefulWidget {
  const CamposDeBusqueda({
    Key? key,
    required TextEditingController textController,
    required this.campo,
    required this.textController2,
    required this.callback,
    required this.atributoEscogido,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final TextEditingController textController2;
  final int campo;
  final IntCallback callback;
  final int atributoEscogido;

  @override
  State<CamposDeBusqueda> createState() => _CamposDeBusquedaState();
}

class _CamposDeBusquedaState extends State<CamposDeBusqueda> {
  String label = 'Nombre de cliente';
  late int opciones;
  bool primera = true;
  bool primera2 = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    opciones = widget.atributoEscogido;
    // print('opciones desde el build: $opciones');
    if (widget.campo == 1) {
      if (opciones == 0) {
        label = 'Nombre de cliente';
      } else if (opciones == 1) {
        label = 'RTN';
      } else if (opciones == 2) {
        label = 'DNI';
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget._textController,
            onChanged: (value) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: label,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  opciones = 0;
                  widget.callback(opciones);
                  setState(() {});
                },
                child: Text('Nombre de cliente'),
                style: ButtonStyle(
                  backgroundColor: (opciones == 0)
                      ? MaterialStateProperty.all(Colors.blue)
                      : MaterialStateProperty.all(Colors.grey),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  opciones = 1;
                  widget.callback(opciones);
                  setState(() {});
                },
                child: Text('RTN'),
                style: ButtonStyle(
                  backgroundColor: (opciones == 1)
                      ? MaterialStateProperty.all(Colors.blue)
                      : MaterialStateProperty.all(Colors.grey),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  opciones = 2;
                  widget.callback(opciones);
                  setState(() {});
                },
                child: Text('DNI'),
                style: ButtonStyle(
                  backgroundColor: (opciones == 2)
                      ? MaterialStateProperty.all(Colors.blue)
                      : MaterialStateProperty.all(Colors.grey),
                ),
              ),
            ],
          )
        ],
      );
    } else if (widget.campo == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget._textController,
            onChanged: (value) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Fecha 1',
              hintText: 'YYYY-MM-DD',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: widget.textController2,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Fecha2',
              hintText: 'YYYY-MM-DD',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
                text: 'Puede realizar la búsqueda especificando la ',
                children: <TextSpan>[
                  TextSpan(
                      text: 'fecha 1',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  TextSpan(text: ' o la '),
                  TextSpan(
                      text: 'fecha 1',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  TextSpan(text: ' y '),
                  TextSpan(
                      text: 'fecha 2.',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  TextSpan(text: ' El formato'),
                  TextSpan(
                      text: ' YYYY-MM-DD ',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  TextSpan(text: 'tiene la siguiente forma'),
                  TextSpan(
                      text: ' 2022-12-28 ',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                ]),
          )
        ],
      );
    } else if (widget.campo == 3) {
      return TextField(
        controller: widget._textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'CAI',
        ),
      );
      // if (opciones == 0) {
      //   label = 'Id de talonario';
      // } else if (opciones == 1) {
      //   label = 'CAI';
      // }
      // return Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     TextField(
      //       controller: widget._textController,
      //       decoration: InputDecoration(
      //         border: OutlineInputBorder(),
      //         labelText: label,
      //       ),
      //     ),
      //     SizedBox(height: 15),
      //     Row(
      //       children: [
      //         ElevatedButton(
      //           onPressed: () {
      //             opciones = 0;
      //             widget.callback(opciones);
      //             setState(() {});
      //           },
      //           child: Text('Id de talonario'),
      //           style: ButtonStyle(
      //             backgroundColor: (opciones == 0)
      //                 ? MaterialStateProperty.all(Colors.blue)
      //                 : MaterialStateProperty.all(Colors.grey),
      //           ),
      //         ),
      //         SizedBox(
      //           width: 10,
      //         ),
      //         ElevatedButton(
      //           onPressed: () {
      //             opciones = 1;
      //             widget.callback(opciones);
      //             setState(() {});
      //           },
      //           child: Text('CAI'),
      //           style: ButtonStyle(
      //             backgroundColor: (opciones == 1)
      //                 ? MaterialStateProperty.all(Colors.blue)
      //                 : MaterialStateProperty.all(Colors.grey),
      //           ),
      //         ),
      //       ],
      //     )
      //   ],
      // );
    } else if (widget.campo == 4) {
      return TextField(
        controller: widget._textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Nombre de empleado',
        ),
      );
    } else {
      return TextField(
        controller: widget._textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Número de factura',
        ),
      );
    }
  }
}
