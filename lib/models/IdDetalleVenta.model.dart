// To parse this JSON data, do
//
//     final idDetalleVenta = idDetalleVentaFromJson(jsonString);

import 'dart:convert';

IdDetalleVenta idDetalleVentaFromJson(String str) => IdDetalleVenta.fromJson(json.decode(str));

String idDetalleVentaToJson(IdDetalleVenta data) => json.encode(data.toJson());

class IdDetalleVenta {
    IdDetalleVenta({
        required this.id,
    });

    int id;

    factory IdDetalleVenta.fromJson(Map<String, dynamic> json) => IdDetalleVenta(
        id: json['id'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
    };
}
