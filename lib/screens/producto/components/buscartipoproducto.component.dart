import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:soft_frontend/providers/producto.provider.dart';
import 'package:soft_frontend/services/producto.service.dart';


buscarTipoProducto(context) {
  ProductoProvider productoProvider = Provider.of<ProductoProvider>(context, listen: false);
  final TextEditingController _typeAheadController = TextEditingController();
  String idTipoProductoG = '';
    return Container(
        child: TypeAheadField<Tipoproducto2?>(
      hideSuggestionsOnKeyboardHide: false,
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
            hintText: 'Agregar tipo producto',
          ),
          controller: _typeAheadController),
      suggestionsCallback: UserApi.obtenerTipos,
      itemBuilder: (context, Tipoproducto2? suggestion) {
        final tipos = suggestion!;
        return ListTile(
          title: Text(tipos.tipoProducto),
        );
      },
      noItemsFoundBuilder: (context) => Container(
        height: 100,
        child: Center(
          child: Text(
            'No hay tipos de productos.',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      onSuggestionSelected: (Tipoproducto2? suggestion) {
        final tipo = suggestion!;
        idTipoProductoG = tipo.id.toString();
        productoProvider.changeIdTipoProducto = idTipoProductoG;
        print('valor del: ${productoProvider.getidTipoProductoG}');
        _typeAheadController.text = tipo.tipoProducto;
      },
    ));
  }