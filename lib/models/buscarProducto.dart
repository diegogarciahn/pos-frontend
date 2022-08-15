// To parse this JSON data, do
//
//     final buscarProducto = buscarProductoFromJson(jsonString);

import 'dart:convert';

BuscarProducto buscarProductoFromJson(String str) => BuscarProducto.fromJson(json.decode(str));
String buscarProductoToJson(BuscarProducto data) => json.encode(data.toJson());
Producto2 producto2FromJson(String str) => Producto2.fromJson(json.decode(str));

class BuscarProducto {
  BuscarProducto({
    required this.producto,
  });

  Producto2 producto;

  factory BuscarProducto.fromJson(Map<String, dynamic> json) => BuscarProducto(
    producto: Producto2.fromJson(json["producto"]),
  );

  Map<String, dynamic> toJson() => {
    "producto": producto.toJson(),
  };
}

class Producto2 {
  Producto2({
    required this.id,
    required this.codigoProducto,
    required this.nombreProducto,
    required this.precioProducto,
    required this.cantidadProducto,
    required this.isvProducto,
    required this.descProducto,
    required this.isExcento,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
    required this.idTipoProducto,
    required this.tipoproducto,
  });

  int id;
  String codigoProducto;
  String nombreProducto;
  double precioProducto;
  int cantidadProducto;
  double isvProducto;
  double descProducto;
  bool isExcento;
  bool isDelete;
  DateTime createdAt;
  DateTime updatedAt;
  int idTipoProducto;
  Tipoproducto tipoproducto;

  factory Producto2.fromJson(Map<String, dynamic> json) => Producto2(
    id: json["id"],
    codigoProducto: json["codigoProducto"],
    nombreProducto: json["nombreProducto"],
    precioProducto: json["precioProducto"],
    cantidadProducto: json["cantidadProducto"],
    isvProducto: json["isvProducto"],
    descProducto: json["descProducto"],
    isExcento: json["isExcento"],
    isDelete: json["isDelete"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    idTipoProducto: json["idTipoProducto"],
    tipoproducto: Tipoproducto.fromJson(json["tipoproducto"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "codigoProducto": codigoProducto,
    "nombreProducto": nombreProducto,
    "precioProducto": precioProducto,
    "cantidadProducto": cantidadProducto,
    "isvProducto": isvProducto,
    "descProducto": descProducto,
    "isExcento": isExcento,
    "isDelete": isDelete,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "idTipoProducto": idTipoProducto,
    "tipoproducto": tipoproducto.toJson(),
  };
}

class Tipoproducto {
  Tipoproducto({
    required this.id,
    required this.tipoProducto,
    required this.descripcionProducto,
    required this.isvTipoProducto,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String tipoProducto;
  String descripcionProducto;
  double isvTipoProducto;
  bool isDelete;
  DateTime createdAt;
  DateTime updatedAt;

  factory Tipoproducto.fromJson(Map<String, dynamic> json) => Tipoproducto(
    id: json["id"],
    tipoProducto: json["tipoProducto"],
    descripcionProducto: json["descripcionProducto"],
    isvTipoProducto: json["isvTipoProducto"],
    isDelete: json["isDelete"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tipoProducto": tipoProducto,
    "descripcionProducto": descripcionProducto,
    "isvTipoProducto": isvTipoProducto,
    "isDelete": isDelete,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
