import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:soft_frontend/controllers/talonarios.controller.dart';

import '../../../globals/globals.components.dart';
import '../../../models/talonario.model.dart';
import '../themes/app_theme.dart';

alertActualizarTalonario(BuildContext context, Talonario talonario) {
  double height = MediaQuery.of(context).size.height;
  var rangoInicialController = TextEditingController();
  var rangoFinalController = TextEditingController();
  var caiController = TextEditingController();
  var fechaLimiteEController = TextEditingController();
  rangoInicialController.text = talonario.rangoInicialFactura;
  rangoFinalController.text = talonario.rangoFinalFactura;
  caiController.text = talonario.cai;
  fechaLimiteEController.text =
      DateFormat('yyyy-MM-dd').format(talonario.fechaLimiteEmision);
  return showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          title: Text(
            'Editar talonario',
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
            ),
          ),
          actions: [
            TextButton(
                style: AppTheme.lightTheme.textButtonTheme.style,
                onPressed: () {
                  if ((talonario.rangoInicialFactura ==
                          rangoInicialController.text) &&
                      (talonario.rangoFinalFactura ==
                          rangoFinalController.text) &&
                      (talonario.cai == caiController.text) &&
                      (talonario.fechaLimiteEmision
                              .toString()
                              .substring(0, 10) ==
                          fechaLimiteEController.text)) {
                    alertError(context,
                        mensaje:
                            'Debe realizar al menos un cambio para realizar una actualización.');
                  } else {
                    actualizarTalonariosController(
                        talonario.idTalonario.toString(),
                        rangoInicialController.text,
                        rangoFinalController.text,
                        caiController.text,
                        fechaLimiteEController.text,
                        context);
                  }
                },
                child: Text('Confirmar')),
            TextButton(
                style: AppTheme.lightTheme.textButtonTheme.style,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar'))
          ],
        );
      });
}
