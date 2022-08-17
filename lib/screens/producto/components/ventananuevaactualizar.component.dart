import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soft_frontend/screens/producto/components/buscartipoproducto.component.dart';
import 'package:soft_frontend/screens/producto/components/ventanaerror.component.dart';

import '../../../controllers/producto.controller.dart';
import 'ventanaexito.component.dart';

int isExceptoN = 0;
String idTipoProductoG = '';
String? pathActualizar = '';
var imagePiker;
bool isExcento2 = false;
String isExcento3 = '';
bool esCorrecto = false;
bool isCorrect = false;
String? path;
ImagePicker picker = ImagePicker();

void ventanaNuevaActualizar(
      BuildContext context,
      String idProductoP,
      String codigoProductoP,
      String nombreProductoP,
      String cantidadProductoP,
      String precioProductoP,
      String isvProductoP,
      String descProductoP,
      String isExcentoP,
      String? path,
      String idTipoProductoP) {
    late TextEditingController idProducto =
        TextEditingController(text: idProductoP);
    late TextEditingController codigoProducto =
        TextEditingController(text: codigoProductoP);
    late TextEditingController nombreProducto =
        TextEditingController(text: nombreProductoP);
    late TextEditingController precioProducto =
        TextEditingController(text: precioProductoP);
    late TextEditingController cantidadProducto =
        TextEditingController(text: cantidadProductoP);
    late TextEditingController isvProducto =
        TextEditingController(text: isvProductoP);
    late TextEditingController descProducto =
        TextEditingController(text: descProductoP);
    late TextEditingController isExcento5 =
        TextEditingController(text: isExcentoP);
    idTipoProductoG = idTipoProductoP;
    late TextEditingController idTipoProducto =
        TextEditingController(text: idTipoProductoP);
    if (isExcentoP.toString() == 'true') {
      isExceptoN = 1;
    } else {
      isExceptoN = 0;
    }
    pathActualizar = path;
    imagePiker = path;
    bool imagenNueva = false;

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 350,
                            height: 350,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Código Producto',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: codigoProducto,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Precio',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: precioProducto,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'ISV',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                        controller: isvProducto,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Excento',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RadioListTile<int>(
                                            value: 1,
                                            groupValue: isExceptoN,
                                            title: Text('Si'),
                                            onChanged: (value) {
                                              setState(() => isExceptoN = 1);
                                              isExcento2 = true;
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile<int>(
                                              value: 0,
                                              groupValue: isExceptoN,
                                              title: Text('No'),
                                              onChanged: (value) {
                                                setState(() => isExceptoN = 0);
                                                isExcento2 = false;
                                              }),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                          Container(
                            width: 350,
                            height: 350,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Nombre del producto',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: nombreProducto,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Cantidad en existencia',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: cantidadProducto,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Descuento',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: descProducto,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Tipo producto',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    buscarTipoProducto(),
                                  ]),
                            ),
                          ),
                        ]),
                    Row(
                      children: [
                        (path == null)
                            ? Container(
                                width: 150,
                                height: 150,
                                child: FadeInImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      './assets/images/no-image.png'),
                                  placeholder: AssetImage(
                                      './assets/images/no-image.png'),
                                ),
                              )
                            : Image.network(
                                path!,
                                width: 100,
                                height: 100,
                              ),
                        TextButton(
                            child: Text('Agregar Imagen'),
                            onPressed: () async {
                              picker = ImagePicker();
                              imagePiker = await picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                path = imagePiker!.path;
                                imagenNueva = true;
                              });
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            width: 100,
                            height: 50,
                            margin: EdgeInsets.all(5),
                            child: RaisedButton(
                              onPressed: () {
                                if (imagenNueva == false) {
                                  isCorrect = controladorActualizarSinProducto(
                                      idProducto.text,
                                      codigoProducto.text,
                                      nombreProducto.text,
                                      precioProducto.text,
                                      cantidadProducto.text,
                                      isvProducto.text,
                                      descProducto.text,
                                      isExcento2.toString(),
                                      idTipoProductoG,
                                      context);
                                  if (isCorrect == true) {
                                    // initState2();
                                    // fetchData();
                                    // setState((){});
                                    Navigator.pop(context);
                                  } else {
                                    ventanaError(context, 'Ocurrio un error al realizar esta acción, intente de nuevo.');
                                  }
                                  // initState2();
                                  // fetchData();
                                  // setState((){});
                                } else {
                                  isCorrect = controladorActualizarConImagen(
                                      idProducto.text,
                                      codigoProducto.text,
                                      nombreProducto.text,
                                      precioProducto.text,
                                      cantidadProducto.text,
                                      isvProducto.text,
                                      descProducto.text,
                                      isExcento2.toString(),
                                      idTipoProductoG,
                                      imagePiker,
                                      context);
                                  if (isCorrect == true) {
                                    ventanaExito(context);
                                    // initState2();
                                    // fetchData();
                                    // setState((){});
                                    Navigator.pop(context);
                                  } else {
                                    ventanaError(context, 'Ocurrio un error al realizar esta acción, intente de nuevo.');
                                  }
                                  // initState2();
                                  // fetchData();
                                  // setState((){});
                                }
                              },
                              child: Text('Guardar'),
                              padding: EdgeInsets.all(10),
                            )),
                        Container(
                            width: 100,
                            height: 50,
                            margin: EdgeInsets.all(5),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancelar'),
                              padding: EdgeInsets.all(10),
                            )),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }