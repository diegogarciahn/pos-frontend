import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soft_frontend/controllers/talonarios.controller.dart';

import '../../../models/sucursal.model.dart';
import '../themes/app_theme.dart';

alertCrearTalonario(List<DetalleSucursal> sucursales, context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  var rangoInicialController = TextEditingController();
  var rangoFinalController = TextEditingController();
  var caiController = TextEditingController();
  var nombreSucursal = TextEditingController();
  var idSucursal = TextEditingController();
  var fechaLimiteEController = TextEditingController();

  return showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          title: Text(
            'Creación talonario ',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: rangoInicialController,
                decoration: InputDecoration(
                  hintText: '000-001-01-00112001',
                  labelText: 'Rango Inicial',
                ),
              ),
              TextFormField(
                controller: rangoFinalController,
                decoration: InputDecoration(
                  hintText: '000-001-01-00112500',
                  label: Text('Rango Final'),
                ),
              ),
              TextFormField(
                controller: caiController,
                decoration: InputDecoration(
                  hintText: 'EAF199-B70479-5343AB-538F3E-045C35-C6',
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
                          title: Text('Sucursales',
                              style: TextStyle(color: AppTheme.primaryColor)),
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
                                        // setState(() {
                                        nombreSucursal.text =
                                            sucursal.nombreSucursal;
                                        idSucursal.text =
                                            sucursal.idSucursal.toString();
                                        // });
                                        print(nombreSucursal.text);
                                      },
                                      leading: Icon(
                                        Icons.home,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                        sucursal.nombreSucursal,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text('RTN: ' + sucursal.rtn,
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  );
                                })),
                          ),
                        );
                      });
                },
                controller: nombreSucursal,
                decoration: InputDecoration(
                  hintText: '1',
                  label: Text('Sucursal'),
                ),
              ),
              DateTimeField(
                controller: fechaLimiteEController,
                decoration: InputDecoration(label: Text('Fecha Limite E.')),
                format: DateFormat('yyyy-MM-dd'),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
            ],
          ),
          actions: [
            TextButton(
                style: AppTheme.lightTheme.textButtonTheme.style,
                onPressed: () {
                  crearTalonarioController(
                      rangoInicialController.text,
                      rangoFinalController.text,
                      caiController.text,
                      idSucursal.text,
                      fechaLimiteEController.text,
                      context);
                  // if (rangoInicialController.text == '' &&
                  //     rangoFinalController.text == '' &&
                  //     caiController.text == '' &&
                  //     fechaLimiteEController.text == '' &&
                  //     idSucursal.text == '') {
                  //   _Alerta(context, 'Debe llenar todos los campos.');
                  // } else {
                  //   print(rangoInicialController.text);
                  //   print(rangoFinalController.text);
                  //   print(caiController.text);
                  //   print(fechaLimiteEController.text);
                  //   print(idSucursal.text);
                  //   Future<String> create = createTalonario(
                  //       rangoInicialController.text,
                  //       rangoFinalController.text,
                  //       caiController.text,
                  //       idSucursal.text,
                  //       fechaLimiteEController.text);
                  //   showDialog(
                  //       barrierDismissible: false,
                  //       context: context,
                  //       builder: (buildContext) {
                  //         return Dialog(
                  //           child: Center(
                  //               child: CircularProgressIndicator()),
                  //         );
                  //       });
                  //   create.then((value) {
                  //     idSucursal.text = '';
                  //     nombreSucursal.text = '';
                  //     Navigator.pop(context);
                  //     setState(() {
                  //       // this._getTalonarios();
                  //     });
                  //     _Alerta(context, value);
                  //     Future.delayed(Duration(seconds: 2))
                  //         .then((value) => Navigator.pop(context));
                  //   });
                  // }
                },
                child: Text('Confirmar')),
            TextButton(
                style: AppTheme.lightTheme.textButtonTheme.style,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar')),
          ],
        );
      });
}
