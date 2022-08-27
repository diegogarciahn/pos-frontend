import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:soft_frontend/providers/sucursal.provider.dart';
import 'package:soft_frontend/providers/talonarios.provider.dart';

import 'package:soft_frontend/controllers/sucursal.controller.dart';
import 'package:soft_frontend/controllers/talonarios.controller.dart';

import 'package:soft_frontend/models/sucursal.model.dart';

import 'package:soft_frontend/screens/talonarios/themes/app_theme.dart';

import 'package:soft_frontend/screens/talonarios/components/alertcreartalonario.component.dart';
import 'package:soft_frontend/screens/talonarios/components/cabeceratabletalonarios.component.dart';
import 'package:soft_frontend/screens/talonarios/components/listitemtalonarios.component.dart';

class TalonariosScreen extends StatefulWidget {
  const TalonariosScreen({Key? key}) : super(key: key);

  @override
  State<TalonariosScreen> createState() => _TalonariosScreenState();
}

class _TalonariosScreenState extends State<TalonariosScreen> {
  List<DetalleSucursal> sucursales = [];

  @override
  void initState() {
    obtenerTalonariosController(context);
    obtenerSucursalesController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    TalonariosProvider talonariosProvider =
        Provider.of<TalonariosProvider>(context);
    SucursalProvider sucursalProvider = Provider.of<SucursalProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talonarios'),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.01, vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary
              ),
                onPressed: () {
                  Navigator.maybePop(context).then((value) {
                    if (!value) {
                      Navigator.popAndPushNamed(context, 'mantenimiento');
                    }
                  });
                },
                child: Text('Regresar',)),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.013),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      sucursales = sucursalProvider.getListSucursales;
                      alertCrearTalonario(sucursales, context);
                    },
                    child: Text(
                      'Crear Talonario',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(20),
                        )),
                  )
                ],
              ),
            ),
            cabeceraTableTalonarios(context),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, i) {
                  return listItemTalonario(
                      talonariosProvider.getListTalonarios[i], context);
                },
                itemCount: talonariosProvider.getListTalonarios.length,
              ),
            ),
          ],
        ),
      ),
    );
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
