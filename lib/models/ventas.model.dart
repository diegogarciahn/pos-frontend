// To parse this JSON data, do
//
//     final ventas = ventasFromJson(jsonString);

import 'dart:convert';

Ventas ventasFromJson(String str) => Ventas.fromJson(json.decode(str));

String ventasToJson(Ventas data) => json.encode(data.toJson());

class Ventas {
    Ventas({
        required this.todasLasVentas,
    });

    List<TodasLasVenta> todasLasVentas;

    factory Ventas.fromJson(Map<String, dynamic> json) => Ventas(
        todasLasVentas: List<TodasLasVenta>.from(json['todasLasVentas'].map((x) => TodasLasVenta.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'todasLasVentas': List<dynamic>.from(todasLasVentas.map((x) => x.toJson())),
    };
}

class TodasLasVenta {
    TodasLasVenta({
        required this.id,
        required this.totalIsv,
        required this.totalVenta,
        required this.totalDescuentoVenta,
        required this.isDelete,
        required this.puntoDeEmision,
        required this.establecimiento,
        required this.tipo,
        required this.createdAt,
        required this.updatedAt,
        required this.idSesion,
        required this.idUsuario,
        required this.idCliente,
    });

    int id;
    String totalIsv;
    String totalVenta;
    String totalDescuentoVenta;
    bool isDelete;
    String puntoDeEmision;
    String establecimiento;
    String tipo;
    DateTime createdAt;
    DateTime updatedAt;
    String? idSesion;
    String idUsuario;
    String idCliente;

    factory TodasLasVenta.fromJson(Map<String, dynamic> json) => TodasLasVenta(
        id: json['id'],
        totalIsv: json['totalISV'],
        totalVenta: json['totalVenta'],
        totalDescuentoVenta: json['totalDescuentoVenta'],
        isDelete: json['isDelete'],
        puntoDeEmision: json['puntoDeEmision'],
        establecimiento: json['establecimiento'],
        tipo: json['tipo'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        idSesion: json['idSesion'],
        idUsuario: json['idUsuario'],
        idCliente: json['idCliente'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'totalISV': totalIsv,
        'totalVenta': totalVenta,
        'totalDescuentoVenta': totalDescuentoVenta,
        'isDelete': isDelete,
        'puntoDeEmision': puntoDeEmision,
        'establecimiento': establecimiento,
        'tipo': tipo,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'idSesion': idSesion,
        'idUsuario': idUsuario,
        'idCliente': idCliente,
    };
}
