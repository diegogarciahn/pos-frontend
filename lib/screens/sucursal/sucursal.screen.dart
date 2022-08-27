import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/sucursal.controller.dart';
import 'package:soft_frontend/services/sucursal.service.dart';

import '../../models/sucursal.model.dart';

class SucursalScreen extends StatefulWidget {
  const SucursalScreen({Key? key}) : super(key: key);

  @override
  State<SucursalScreen> createState() => _SucursalScreenState();
}

class _SucursalScreenState extends State<SucursalScreen> {
  late Future<Sucursal> sucursal;
  var nombreSucursal = TextEditingController();
  var lemaSucursal = TextEditingController();
  var direccion = TextEditingController();
  var telefono = TextEditingController();
  var email = TextEditingController();
  var rtn = TextEditingController();
  var logo = TextEditingController();

  @override
  void initState() {
    super.initState();
    esperarToken(context);
    sucursal = getSucursal(1);
    sucursal.then((value) {
      print(value.sucursal.nombreSucursal);
      setState(() {
        nombreSucursal.text = value.sucursal.nombreSucursal;
        lemaSucursal.text = value.sucursal.lemaSucursal;
        direccion.text = value.sucursal.direccion;
        telefono.text = value.sucursal.telefono;
        email.text = value.sucursal.email;
        rtn.text = value.sucursal.rtn;
        logo.text = value.sucursal.logo;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Edición de sucursal'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.01, vertical: 8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).focusColor,
                ),
                onPressed: () {
                  Navigator.maybePop(context).then((value) {
                    if (!value) {
                      Navigator.popAndPushNamed(context, 'mantenimiento');
                    }
                  });
                },
                child: Text('Regresar')),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: textFormFieldPersonalizado(
                        nombreSucursal, 'Nombre de sucursal'),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Expanded(
                      child: textFormFieldPersonalizado(
                          lemaSucursal, 'Lema de sucursal')),
                ],
              ),
              textFormFieldPersonalizado(direccion, 'Dirección'),
              Row(
                children: [
                  Expanded(
                      child: textFormFieldPersonalizado(telefono, 'Teléfono')),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Expanded(child: textFormFieldPersonalizado(email, 'E-mail')),
                ],
              ),
              textFormFieldPersonalizado(rtn, 'R.T.N.'),
              textFormFieldPersonalizado(logo, 'URL logo'),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Future<String> actualizar = updateSucursal(
                            1,
                            nombreSucursal.text,
                            lemaSucursal.text,
                            direccion.text,
                            telefono.text,
                            email.text,
                            rtn.text,
                            logo.text);
                        actualizar.then((value) {
                          setState(() {
                            getSucursal(1);
                          });
                          _Alerta(context, value);
                        });
                      },
                      child: Text('Guardar')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textFormFieldPersonalizado(
      TextEditingController controller, String labelText) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
            label: Text(labelText), border: OutlineInputBorder()),
        controller: controller,
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
              style: TextStyle(),
            ),
            content: Text(mensaje),
          );
        });
  }
}
