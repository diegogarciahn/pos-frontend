import 'package:flutter/material.dart';
import 'package:soft_frontend/models/sucursal.model.dart';
import 'package:soft_frontend/models/talonario.model.dart';
import 'package:soft_frontend/screens/talonarios/themes/app_theme.dart';
import 'package:soft_frontend/services/sucursal.service.dart';
import 'package:soft_frontend/services/talonarios.service.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class TalonariosScreen extends StatefulWidget {
  const TalonariosScreen({Key? key}) : super(key: key);

  @override
  State<TalonariosScreen> createState() => _TalonariosScreenState();
}

class _TalonariosScreenState extends State<TalonariosScreen> {
  List<Talonario> talonarios = [];
  List<DetalleSucursal> sucursales = [];
  var rangoInicialController = TextEditingController();
  var rangoFinalController = TextEditingController();
  var caiController = TextEditingController();
  var sucursalController = TextEditingController();
  var fechaLimiteEController = TextEditingController();
  var idSucursal = TextEditingController();
  var nombreSucursal = TextEditingController();
  @override
  void initState() {
    super.initState();
    this._getTalonarios();
  }

  _getTalonarios() async {
    this.talonarios = await getTalonarios();
    this.sucursales = await getSucursales();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text('Mantenimiento | Talonarios'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.01, horizontal: height * 0.02),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      _CreateTalonario(context);
                    },
                    child: Text('Crear Talonario'),
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: AppTheme.primaryColor),
                  )
                ],
              ),
              
            ),
            const Divider(),
            DataTable(
              columns: const [
                DataColumn(
                  label: Text(
                    'ID',
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Rango Inicial',
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Rango Final',
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'CAI',
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Sucursal',
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Fecha Limite E.',
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Activo',
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Opciones',
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(talonarios.length, (index) {
                final talonario = talonarios[index];
                return DataRow(cells: [
                  DataCell(Text(talonario.idTalonario.toString())),
                  DataCell(Text(talonario.rangoInicialFactura)),
                  DataCell(Text(talonario.rangoFinalFactura)),
                  DataCell(Text(talonario.cai)),
                  DataCell(Text(talonario.idSucursal.toString())),
                  DataCell(Text(talonario.fechaLimiteEmision.toString())),
                  DataCell(
                      Text((talonario.active == true) ? 'Verdadero' : 'Falso')),
                  DataCell(Row(
                    children: [
                      TextButton(
                          style: AppTheme.lightTheme.textButtonTheme.style,
                          onPressed: () {
                            _EditarTalonario(context, talonario);
                          },
                          child: Text('Editar')),
                      (talonario.isDelete == false)
                          ? TextButton(
                              style: AppTheme.lightTheme.textButtonTheme.style,
                              onPressed: () {
                                _EliminarTalonario(context, talonario);
                              },
                              child: Text('Eliminar'))
                          : Container(),
                      (talonario.active == false)
                          ? TextButton(
                              style: AppTheme.lightTheme.textButtonTheme.style,
                              onPressed: () {
                                Future<String> activar = activateTalonario(
                                    talonario.idTalonario.toString());
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (buildContext) {
                                      return Dialog(
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    });
                                activar.then((value) {
                                  Navigator.pop(context);
                                  setState(() {
                                    this._getTalonarios();
                                  });
                                  _Alerta(
                                      context,
                                      'Talonario: ' +
                                          talonario.idTalonario.toString() +
                                          ' Desactivado.');
                                });
                              },
                              child: Text('Activar'))
                          : TextButton(
                              style: AppTheme.lightTheme.textButtonTheme.style,
                              onPressed: () {
                                Future<String> desactivar = disactivateTalonario(
                                    talonario.idTalonario.toString());
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (buildContext) {
                                      return Dialog(
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    });
                                desactivar.then((value) {
                                  Navigator.pop(context);
                                  setState(() {
                                    this._getTalonarios();
                                  });
                                  _Alerta(
                                      context,
                                      'Talonario: ' +
                                          talonario.idTalonario.toString() +
                                          ' Desactivado.');
                                });
                              },
                              child: Text('Desactivar'))
                    ],
                  )),
                ]);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _EliminarTalonario(
      BuildContext context, Talonario talonario) {
    return showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            title: Text(
              'Eliminación',
              style: TextStyle(color: AppTheme.primaryColor),
            ),
            content: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Text('¿Está seguro de eliminar el talonario ' +
                      talonario.idTalonario.toString() +
                      '?'),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextButton(
                        style: AppTheme.lightTheme.textButtonTheme.style,
                        onPressed: () {
                          Future<String> delete =
                              deleteTalonario(talonario.idTalonario.toString());
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (buildContext) {
                                return Dialog(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              });
                          delete.then((value) {
                            Navigator.pop(context);
                            setState(() {
                              this._getTalonarios();
                            });
                            _Alerta(
                                context,
                                'Talonario: ' +
                                    talonario.idTalonario.toString() +
                                    ' Eliminado.');
                            Future.delayed(Duration(seconds: 2))
                                .then((value) => Navigator.pop(context));
                          });
                        },
                        child: Text('Confirmar')),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> _EditarTalonario(BuildContext context, Talonario talonario) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    rangoInicialController.text = talonario.rangoInicialFactura;
    rangoFinalController.text = talonario.rangoFinalFactura;
    caiController.text = talonario.cai;
    fechaLimiteEController.text =
        DateFormat("yyyy-MM-dd").format(talonario.fechaLimiteEmision);
    return showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            title: Text(
              'Edición talonario: ' + talonario.idTalonario.toString(),
              style: TextStyle(color: AppTheme.primaryColor),
            ),
            content: SizedBox(

              height: height * 0.45,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TextFormField(
                      controller: rangoInicialController,
                      decoration: InputDecoration(
                        label: Text('Rango Inicial'),
                      ),
                    ),
                    TextFormField(
                      controller: rangoFinalController,
                      decoration: InputDecoration(
                        label: Text('Rango Final'),
                      ),
                    ),
                    TextFormField(
                      controller: caiController,
                      decoration: InputDecoration(
                        label: Text('CAI'),
                      ),
                    ),
                    DateTimeField(
                      controller: fechaLimiteEController,
                      decoration: InputDecoration(label: Text('Fecha Limite E.')),
                      format: DateFormat("yyyy-MM-dd"),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextButton(
                          style: AppTheme.lightTheme.textButtonTheme.style,
                          onPressed: () {
                            if (rangoInicialController.text == "" &&
                                rangoFinalController.text == "" &&
                                caiController.text == "" &&
                                fechaLimiteEController.text == "") {
                              _Alerta(context, 'Debe llenar todos los campos.');
                            } else {
                              print(rangoInicialController.text);
                              print(rangoFinalController.text);
                              print(caiController.text);
                              print(fechaLimiteEController.text);
                              Future<String> editar = updateTalonario(
                                  talonario.idTalonario.toString(),
                                  rangoInicialController.text,
                                  rangoFinalController.text,
                                  caiController.text,
                                  fechaLimiteEController.text);
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (buildContext) {
                                    return Dialog(
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  });
                              editar.then((value) {
                                Navigator.pop(context);
                                setState(() {
                                  this._getTalonarios();
                                });
                                _Alerta(
                                    context,
                                    'Talonario: ' +
                                        talonario.idTalonario.toString() +
                                        ' Editado.');
                                Future.delayed(Duration(seconds: 2))
                                    .then((value) => Navigator.pop(context));
                              });
                            }
                          },
                          child: Text('Confirmar')),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<dynamic> _CreateTalonario(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    rangoInicialController.text = "";
    rangoFinalController.text = "";
    caiController.text = "";
    fechaLimiteEController.text = "";
    return showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            title: Text(
              'Creación talonario ',
              style: TextStyle(color: AppTheme.primaryColor),
            ),
            content: SizedBox(
              height: 325,
              child: Column(
                children: [
                  TextFormField(
                    controller: rangoInicialController,
                    decoration: InputDecoration(
                      hintText: "000-001-01-00112001",
                      label: Text('Rango Inicial'),
                    ),
                  ),
                  TextFormField(
                    controller: rangoFinalController,
                    decoration: InputDecoration(
                      hintText: "000-001-01-00112500",
                      label: Text('Rango Final'),
                    ),
                  ),
                  TextFormField(
                    controller: caiController,
                    decoration: InputDecoration(
                      hintText: "EAF199-B70479-5343AB-538F3E-045C35-C6",
                      label: Text('CAI'),
                    ),
                  ),
                  TextFormField(
                    readOnly: true,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (buildContext) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              title: Text('Sucursales',
                                  style:
                                      TextStyle(color: AppTheme.primaryColor)),
                              content: Container(
                                height: height * 0.25,
                                width: width * 0.15,
                                child: ListView.separated(
                                    itemCount: sucursales.length,
                                    separatorBuilder: (context, index) =>
                                        const Divider(),
                                    itemBuilder: ((context, index) {
                                      final sucursal = sucursales[index];
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: AppTheme.primaryColor),
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.pop(context);
                                            setState(() {
                                              nombreSucursal.text =
                                                  sucursal.nombreSucursal;
                                              idSucursal.text = sucursal
                                                  .idSucursal
                                                  .toString();
                                            });
                                            print(nombreSucursal.text);
                                          },
                                          leading: Icon(
                                            Icons.home,
                                            color: Colors.white,
                                          ),
                                          title: Text(
                                            sucursal.nombreSucursal,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          subtitle: Text('RTN: ' + sucursal.rtn,
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      );
                                    })),
                              ),
                            );
                          });
                    },
                    controller: nombreSucursal,
                    decoration: InputDecoration(
                      hintText: "1",
                      label: Text('Sucursal'),
                    ),
                  ),
                  DateTimeField(
                    controller: fechaLimiteEController,
                    decoration: InputDecoration(label: Text('Fecha Limite E.')),
                    format: DateFormat("yyyy-MM-dd"),
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextButton(
                        style: AppTheme.lightTheme.textButtonTheme.style,
                        onPressed: () {
                          if (rangoInicialController.text == "" &&
                              rangoFinalController.text == "" &&
                              caiController.text == "" &&
                              fechaLimiteEController.text == "" &&
                              idSucursal.text == "") {
                            _Alerta(context, 'Debe llenar todos los campos.');
                          } else {
                            print(rangoInicialController.text);
                            print(rangoFinalController.text);
                            print(caiController.text);
                            print(fechaLimiteEController.text);
                            print(idSucursal.text);
                            Future<String> create = createTalonario(
                                rangoInicialController.text,
                                rangoFinalController.text,
                                caiController.text,
                                idSucursal.text,
                                fechaLimiteEController.text);
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (buildContext) {
                                  return Dialog(
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                });
                            create.then((value) {
                              idSucursal.text = "";
                              nombreSucursal.text = "";
                              Navigator.pop(context);
                              setState(() {
                                this._getTalonarios();
                              });
                              _Alerta(context, value);
                              Future.delayed(Duration(seconds: 2))
                                  .then((value) => Navigator.pop(context));
                            });
                          }
                        },
                        child: Text('Confirmar')),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> _Alerta(BuildContext context, String mensaje) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (buildContext) {
          Future.delayed(Duration(seconds: 2)).then((value) {
            Navigator.pop(context);
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            title: Text(
              'Alerta',
              style: TextStyle(color: AppTheme.primaryColor),
            ),
            content: Text(mensaje),
          );
        });
  }
}
