import 'package:flutter/material.dart';
import 'package:soft_frontend/controllers/Arqueo.controller.dart';
import 'package:soft_frontend/models/Arqueo.model.dart';
import 'package:soft_frontend/screens/arqueo/components/cabeceraDeTablaArqueo.component.dart';
import 'package:soft_frontend/screens/arqueo/components/itemDeTablaArqueo.component.dart';
import 'package:soft_frontend/screens/globals.components/buttonregresarappbar.component.dart';

class MostrarArqueos extends StatefulWidget {
  const MostrarArqueos({Key? key}) : super(key: key);

  @override
  State<MostrarArqueos> createState() => _MostrarArqueosState();
}

class _MostrarArqueosState extends State<MostrarArqueos> {
  final TextEditingController? _textEditingController = TextEditingController();
  List<Arqueo> listaArqueos = [];
  List<Arqueo> filtroArqueos = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Modulo Arqueo'),
          actions: <Widget>[buttonAppBarRegresar(context, 'inicio')],
        ),
        body: FutureBuilder(
          future: listarArqueos_Controller(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              ManipularArqueo list = snapshot.data;
              listaArqueos = list.arqueos;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(right: size.width * 0.01),
                            child: Text(
                              'Buscar Arqueo por IdUsuario',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: size.width * 0.015,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02),
                          child: TextField(
                            autofocus: true,
                            onChanged: (value) {
                              setState(() {
                                filtroArqueos = listaArqueos
                                    .where((element) => element.idUsuario
                                        .toString()
                                        .contains(value))
                                    .toList();
                              });
                            },
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'Id de Usuario',
                            ),
                          ),
                        )),
                        /*TextButton(
                          onPressed: null,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                _showDialogCrearArqueo(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Text('Crear Nuevo Arqueo'),
                              ),
                            ),
                          ),
                        ),*/
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.height * 0.02),
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.02,
                                horizontal: size.height * 0.03),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Column(
                              children: [
                                cabeceraTableArqueos(context),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: _textEditingController!
                                                  .text.isNotEmpty
                                              ? filtroArqueos.length
                                              : listaArqueos.length,
                                          itemBuilder: (context, index) =>
                                              itemTableArqueo(
                                                  (filtroArqueos.isEmpty)
                                                      ? listaArqueos[index]
                                                      : filtroArqueos[index],
                                                  size)),
                                    ),
                                  ),
                                ),
                              ],
                            ))),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  void _showDialogEliminar(BuildContext context, String idArqueo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        print(idArqueo);
        return AlertDialog(
          title: Text('ELiminar Arqueo'),
          content: Text('¿Quieres eliminar el arqueo?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Si'),
              onPressed: () {
                eliminarArqueo_Controller(idArqueo, context);
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

  void _showDialogCrearArqueo(BuildContext context) {
    var efectivoAperturaController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 350,
                          height: 250,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'Efectivo de Apertura',
                                    style: TextStyle(
                                        fontSize: size.width * 0.01,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                  ),
                                ),
                                TextFormField(
                                  controller: efectivoAperturaController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Efectivo de Apertura',
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /*Expanded(
                                          flex: 1,
                                          child: ElevatedButton(
                                            child: Text('Crear Arqueo'),
                                            onPressed: () {
                                              crearArqueo_Controller(
                                                  efectivoAperturaController
                                                      .text
                                                      .trim(),
                                                  context);
                                            },
                                          ),
                                        ),*/
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: ElevatedButton(
                                            child: Text('Cancelar'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  void _showDialogActualizar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Actualizar Arqueo'),
          content: Text('¿Quieres actualizar el arqueo?'),
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
}
