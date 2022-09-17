import 'package:flutter/material.dart';
import 'package:grouped_buttons_ns/grouped_buttons_ns.dart';
import 'package:soft_frontend/controllers/roles.controller.dart';
import 'package:soft_frontend/models/permisos.model.dart';
import 'package:soft_frontend/models/rol.model.dart';
import 'package:soft_frontend/models/rolResponse.model.dart';
import 'package:soft_frontend/services/permiso.service.dart';
import 'package:soft_frontend/services/rol.service.dart';
import 'package:soft_frontend/services/rolpermiso.service.dart';

import '../../models/permiso.model.dart';

class CrearRol extends StatefulWidget {
  @override
  State<CrearRol> createState() => _CrearRolState();
}

class _CrearRolState extends State<CrearRol> {
  List<Permiso2> listpermisos = [];
  List<String> nombrePermisos = [];
  List<String> permisossignados = [];
  List<int> idPermisos = [];
  var idRolController = TextEditingController();
  var rolController = TextEditingController();
  var descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this._getPermiso();
  }

  _getPermiso() async {
    Permisos permisos = await getPermisos();
    listpermisos = permisos.data;
    for (var i = 0; i < permisos.data.length; i++) {
      nombrePermisos.add(permisos.data[i].permiso);
    }
    setState(() {});
  }

  @override
  Widget build(context) =>
      Scaffold(body: LayoutBuilder(builder: (context, constraints) {
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        return Scaffold(
          appBar: AppBar(
            title: Text('Crear Rol'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, 'gestionusuarios/roles');
                },
                child: Text('Regresar',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: constraints.maxWidth < 500
                  ? const EdgeInsets.all(20)
                  : const EdgeInsets.all(30.0),
              color: const Color(0xffF3F3F3),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 3),
                    // const SizedBox(height: 40),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 500,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'CREAR ROL',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'Por favor llene los campos',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff606060)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Rol',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextFormField(
                                  controller: rolController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'rol'),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'Descripcion',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextFormField(
                                  controller: descripcionController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Descripcion de rol'),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                // Container(
                                //   height: 200,
                                //   child: ListView.builder(
                                //     itemCount: permisos.length,
                                //     itemBuilder: (buildContext, index){
                                //       var per = permisos[index];
                                //       return Text(per.permiso);
                                //     },
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 40,
                                // ),
                                SizedBox(
                                  height: 0.5,
                                ),
                                Text(
                                  'Permisos',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 200,
                                  child: SingleChildScrollView(
                                    child: CheckboxGroup(
                                        labels: nombrePermisos,
                                        onChange: (bool isChecked, String label,
                                            int index) {
                                          idPermisos.add(index + 1);
                                        }),
                                  ),
                                ),
                                TextButton(
                                  onPressed: null,
                                  child: Center(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Future<Rol2?> rolCreado = CreaRol_controller(
                                            rolController.text,
                                            descripcionController.text,
                                            context);
                                          rolCreado.then((value) {
                                            print(value!.id.toString());
                                            crearRolPermiso(idPermisos, value.id.toString());
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Text('Aceptar'),
                                        )),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }));
}
