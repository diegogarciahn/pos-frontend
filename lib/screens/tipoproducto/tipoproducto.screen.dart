import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:soft_frontend/controllers/tipoproducto.controller.dart';

import 'package:soft_frontend/models/Tipoproducto.model.dart';
import 'package:soft_frontend/providers/tipoproducto.provider.dart';

import 'components/cabeceratipoproductotable.component.dart';
import 'components/listitemtipoproducto.component.dart';
import 'components/ventanacreartipoproducto.component.dart';

class PantallaTipoProducto extends StatefulWidget {
  const PantallaTipoProducto({Key? key}) : super(key: key);

  @override
  State<PantallaTipoProducto> createState() => _PantallaTipoProductoState();
}

class _PantallaTipoProductoState extends State<PantallaTipoProducto> {
  List<Tipoproducto> tiposN = <Tipoproducto>[];
  bool isCorrect = false;

  @override
  void initState() {
    obtenerTipoDeProductosController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tipoProductoProvider = Provider.of<TipoProductoProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary
                ),
                onPressed: () {
                  Navigator.maybePop(context).then((value) {
                    if (!value) {
                      Navigator.popAndPushNamed(
                          context, 'mantenimiento/productos');
                    }
                  });
                },
                child: Text('Regresar',),
              ),
            ),
          ],
          title: Text('Tipos de productos'),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    ventanaCrearTipoProducto(context);
                  },
                  child: Text(
                    'Agregar tipo de producto',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return index == 0
                        ? _searchBar(tipoProductoProvider)
                        : (tiposN.isEmpty)
                            ? listItem(index - 1, context,
                                tipoProductoProvider.getListTipoProducto)
                            : listItem(index - 1, context, tiposN);
                  },
                  itemCount: (tiposN.isEmpty)
                      ? tipoProductoProvider.getListTipoProducto.length + 1
                      : tiposN.length + 1,
                ),
              ),
            ),
          ],
        ));
  }

  _searchBar(TipoProductoProvider provider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(hintText: 'Buscar tipo producto'),
            onChanged: (text) {
              text = text.toLowerCase();
              setState(() {
                tiposN = provider.getListTipoProducto.where((note) {
                  var noteTitle = note.tipoProducto.toString().toLowerCase();
                  return noteTitle.contains(text);
                }).toList();
              });
            },
          ),
        ),
        cabecera(context),
      ],
    );
  }
}
