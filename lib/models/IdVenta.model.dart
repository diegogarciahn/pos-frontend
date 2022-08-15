// To parse this JSON data, do
//
//     final idVenta = idVentaFromJson(jsonString);

import 'dart:convert';

IdVenta idVentaFromJson(String str) => IdVenta.fromJson(json.decode(str));

String idVentaToJson(IdVenta data) => json.encode(data.toJson());

class IdVenta {
    IdVenta({
        required this.id,
    });

    int id;

    factory IdVenta.fromJson(Map<String, dynamic> json) => IdVenta(
        id: json['id'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
    };
}
