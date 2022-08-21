import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:soft_frontend/controllers/producto.controller.dart';
import 'package:soft_frontend/providers/producto.provider.dart';
import 'package:soft_frontend/screens/producto/components/buscartipoproducto.component.dart';
import 'package:soft_frontend/screens/producto/components/ventanaerror.component.dart';

int isExceptoN = 0;
String idTipoProductoG = '';
String? pathActualizar = '';
// ignore: prefer_typing_uninitialized_variables
var imagePiker;
bool isExcento2 = false;
String isExcento3 = '';
bool esCorrecto = false;
bool isCorrect = false;
String? path;
ImagePicker picker = ImagePicker();
int isExcento = 3;

void ventanaNueva(BuildContext context) {
  var codigoProductoController = TextEditingController();
  var nombreProductoController = TextEditingController();
  var precioProductoController = TextEditingController();
  var cantidadProductoController = TextEditingController();
  var isvProductoController = TextEditingController();
  var descProductoController = TextEditingController();
  ProductoProvider productoProvider =
      Provider.of<ProductoProvider>(context, listen: false);

  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Los campos con un (*) son obligatorios.'),
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Código Producto *',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: codigoProductoController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Precio *',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: precioProductoController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'ISV *',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RadioListTile<int>(
                                            value: 0,
                                            groupValue: isExcento,
                                            title: Text('Excento'),
                                            onChanged: (value) {
                                              setState(() => isExcento = 0);
                                              isvProductoController.text = '0';
                                              isExcento2 = true;
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile<int>(
                                            value: 1,
                                            groupValue: isExcento,
                                            title: Text('15%'),
                                            onChanged: (value) {
                                              setState(() => isExcento = 1);
                                              isExcento2 = false;
                                              isvProductoController.text = '15';
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile<int>(
                                              value: 2,
                                              groupValue: isExcento,
                                              title: Text('18%'),
                                              onChanged: (value) {
                                                setState(() => isExcento = 2);
                                                isExcento2 = false;
                                                isvProductoController.text =
                                                    '18';
                                              }),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Nombre del producto *',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: nombreProductoController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Cantidad en existencia *',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: cantidadProductoController,
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
                                      controller: descProductoController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Tipo producto *',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    buscarTipoProducto(context),
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
                                color: Colors.transparent,
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
                                if (imagePiker != null) {
                                  path = imagePiker!.path;
                                }
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              String idTipoProd = productoProvider.getidTipoProductoG;
              print('aqui va el id producto: $idTipoProd');
              if (codigoProductoController.text.isEmpty |
                  nombreProductoController.text.isEmpty |
                  precioProductoController.text.isEmpty |
                  cantidadProductoController.text.isEmpty |
                  isvProductoController.text.isEmpty |
                  (idTipoProd == '') |
                  (isExcento >= 3)) {
                ventanaError(context,
                    mensaje:
                        'Por favor llene todos los campos requeridos.');
              } else {
                final respuesta = await crearProductoController(
                    codigoProductoController.text,
                    nombreProductoController.text,
                    precioProductoController.text,
                    cantidadProductoController.text,
                    isvProductoController.text,
                    (descProductoController.text.isNotEmpty)
                        ? descProductoController.text
                        : '0',
                    isExcento2.toString(),
                    idTipoProd,
                    (imagePiker != null) ? imagePiker : '',
                    context);
                print(respuesta);
              }
            },
            child: Text('Guardar'),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(20)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              productoProvider.changeIdTipoProducto = '';
              Navigator.pop(context);
            },
            child: Text('Cancelar'),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(20)),
            ),
          ),
        ],
      );
    },
  );
}
