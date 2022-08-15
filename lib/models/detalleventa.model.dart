// To parse this JSON data, do
//
//     final detalleDeVentasXid = detalleDeVentasXidFromJson(jsonString);

import 'dart:convert';

DetalleDeVentasXid detalleDeVentasXidFromJson(String str) => DetalleDeVentasXid.fromJson(json.decode(str));

String detalleDeVentasXidToJson(DetalleDeVentasXid data) => json.encode(data.toJson());

class DetalleDeVentasXid {
    DetalleDeVentasXid({
        required this.detalleDeVentaNueva,
    });

    List<DetalleDeVentaNueva> detalleDeVentaNueva;

    factory DetalleDeVentasXid.fromJson(Map<String, dynamic> json) => DetalleDeVentasXid(
        detalleDeVentaNueva: List<DetalleDeVentaNueva>.from(json["detalleDeVentaNueva"].map((x) => DetalleDeVentaNueva.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "detalleDeVentaNueva": List<dynamic>.from(detalleDeVentaNueva.map((x) => x.toJson())),
    };
}

class DetalleDeVentaNueva {
    DetalleDeVentaNueva({
        required this.id,
        required this.cantidad,
        required this.precioUnitario,
        required this.isvAplicado,
        required this.descuentoAplicado,
        required this.totalDetalleVenta,
        required this.isDelete,
        required this.createdAt,
        required this.updatedAt,
        required this.idVentas,
        required this.idProducto,
        required this.producto,
    });

    int id;
    int cantidad;
    String precioUnitario;
    String isvAplicado;
    String descuentoAplicado;
    String totalDetalleVenta;
    bool isDelete;
    DateTime createdAt;
    DateTime updatedAt;
    int idVentas;
    int idProducto;
    Producto producto;

    factory DetalleDeVentaNueva.fromJson(Map<String, dynamic> json) => DetalleDeVentaNueva(
        id: json["id"],
        cantidad: json["cantidad"],
        precioUnitario: json["precioUnitario"],
        isvAplicado: json["isvAplicado"],
        descuentoAplicado: json["descuentoAplicado"],
        totalDetalleVenta: json["totalDetalleVenta"],
        isDelete: json["isDelete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        idVentas: json["idVentas"],
        idProducto: json["idProducto"],
        producto: Producto.fromJson(json["producto"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cantidad": cantidad,
        "precioUnitario": precioUnitario,
        "isvAplicado": isvAplicado,
        "descuentoAplicado": descuentoAplicado,
        "totalDetalleVenta": totalDetalleVenta,
        "isDelete": isDelete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "idVentas": idVentas,
        "idProducto": idProducto,
        "producto": producto.toJson(),
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
        required this.createdAt,
        required this.updatedAt,
        required this.idTipoProducto,
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
    DateTime createdAt;
    DateTime updatedAt;
    int idTipoProducto;

    factory Producto.fromJson(Map<String, dynamic> json) => Producto(
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
    };
}
