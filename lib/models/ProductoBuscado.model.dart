// To parse this JSON data, do
//
//     final productoBuscado = productoBuscadoFromJson(jsonString);

import 'dart:convert';

ProductoBuscado productoBuscadoFromJson(String str) => ProductoBuscado.fromJson(json.decode(str));

String productoBuscadoToJson(ProductoBuscado data) => json.encode(data.toJson());

class ProductoBuscado {
    ProductoBuscado({
        required this.producto,
    });

    Producto producto;

    factory ProductoBuscado.fromJson(Map<String, dynamic> json) => ProductoBuscado(
        producto: Producto.fromJson(json['producto']),
    );

    Map<String, dynamic> toJson() => {
        'producto': producto.toJson(),
    };
}

class Producto {
    Producto({
        required this.id,
        required this.codigoProducto,
        required this.nombreProducto,
        required this.precioProducto,
        required this.cantidadProducto,
        required this.isvProducto,
        required this.descProducto,
        required this.isExcento,
        required this.isDelete,
        this.createdAt,
        this.updatedAt,
        required this.idTipoProducto,
        required this.tipoproducto,
    });

    int id;
    String codigoProducto;
    String nombreProducto;
    String precioProducto;
    int cantidadProducto;
    String isvProducto;
    String descProducto;
    bool isExcento;
    bool isDelete;
    DateTime? createdAt;
    DateTime? updatedAt;
    int idTipoProducto;
    Tipoproducto tipoproducto;

    factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json['id'],
        codigoProducto: json['codigoProducto'],
        nombreProducto: json['nombreProducto'],
        precioProducto: json['precioProducto'],
        cantidadProducto: json['cantidadProducto'],
        isvProducto: json['isvProducto'],
        descProducto: json['descProducto'],
        isExcento: json['isExcento'],
        isDelete: json['isDelete'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        idTipoProducto: json['idTipoProducto'],
        tipoproducto: Tipoproducto.fromJson(json['tipoproducto']),
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'codigoProducto': codigoProducto,
        'nombreProducto': nombreProducto,
        'precioProducto': precioProducto,
        'cantidadProducto': cantidadProducto,
        'isvProducto': isvProducto,
        'descProducto': descProducto,
        'isExcento': isExcento,
        'isDelete': isDelete,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'idTipoProducto': idTipoProducto,
        'tipoproducto': tipoproducto.toJson(),
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
    String isvTipoProducto;
    bool isDelete;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Tipoproducto.fromJson(Map<String, dynamic> json) => Tipoproducto(
        id: json['id'],
        tipoProducto: json['tipoProducto'],
        descripcionProducto: json['descripcionProducto'],
        isvTipoProducto: json['isvTipoProducto'],
        isDelete: json['isDelete'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'tipoProducto': tipoProducto,
        'descripcionProducto': descripcionProducto,
        'isvTipoProducto': isvTipoProducto,
        'isDelete': isDelete,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
    };
}
