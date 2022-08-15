// To parse this JSON data, do
//
//     final facturaBuscada = facturaBuscadaFromJson(jsonString);

import 'dart:convert';

FacturaBuscada facturaBuscadaFromJson(String str) => FacturaBuscada.fromJson(json.decode(str));

String facturaBuscadaToJson(FacturaBuscada data) => json.encode(data.toJson());

class FacturaBuscada {
    FacturaBuscada({
        required this.idFactura,
        required this.numeroFactura,
        this.fechaFactura,
        this.descuentoTotalFactura,
        this.isvTotalFactura,
        this.totalFactura,
        this.subTotalFactura,
        this.cantidadLetras,
        this.idEmpleado,
        this.nombreEmpleado,
        this.tipoPago,
        this.cai,
        this.nombreCliente,
        this.rtn,
        this.direccionCliente,
        this.telefonoCliente,
    });

    int? idFactura;
    String numeroFactura;
    DateTime? fechaFactura;
    String? descuentoTotalFactura;
    String? isvTotalFactura;
    String? totalFactura;
    String? subTotalFactura;
    String? cantidadLetras;
    int? idEmpleado;
    String? nombreEmpleado;
    String? tipoPago;
    String? cai;
    String? nombreCliente;
    String? rtn;
    String? direccionCliente;
    String? telefonoCliente;

    factory FacturaBuscada.fromJson(Map<String, dynamic> json) => FacturaBuscada(
        idFactura: json['idFactura'] ?? -1,
        numeroFactura: json['numeroFactura'] ?? -1,
        fechaFactura: DateTime.parse(json['fechaFactura'] ?? '0000-00-00 00:00:00'),
        descuentoTotalFactura: json['descuentoTotalFactura'] ?? '0.00',
        isvTotalFactura: json['isvTotalFactura'] ?? '0.00',
        totalFactura: json['totalFactura'] ?? '0.00',
        subTotalFactura: json['subTotalFactura'] ?? '0.00',
        cantidadLetras: json['cantidadLetras'] ?? '0.00',
        idEmpleado: json['idEmpleado'] ?? '0.00',
        nombreEmpleado: json['nombreEmpleado'] ?? '0.00',
        tipoPago: json['tipoPago'] ?? '',
        cai: json['cai'] ?? '',
        nombreCliente: json['nombreCliente'] ?? '',
        rtn: json['rtn'] ?? '',
        direccionCliente: json['direccionCliente'] ?? '',
        telefonoCliente: json['telefonoCliente'] ?? '',
    );

    Map<String, dynamic> toJson() => {
        'idFactura': idFactura,
        'numeroFactura': numeroFactura,
        'fechaFactura': '${fechaFactura!.year.toString().padLeft(4, '0')}-${fechaFactura!.month.toString().padLeft(2, '0')}-${fechaFactura!.day.toString().padLeft(2, '0')}',
        'descuentoTotalFactura': descuentoTotalFactura,
        'isvTotalFactura': isvTotalFactura,
        'totalFactura': totalFactura,
        'subTotalFactura': subTotalFactura,
        'cantidadLetras': cantidadLetras,
        'idEmpleado': idEmpleado,
        'nombreEmpleado': nombreEmpleado,
        'tipoPago': tipoPago,
        'cai': cai,
        'nombreCliente': nombreCliente,
        'rtn': rtn,
        'direccionCliente': direccionCliente,
        'telefonoCliente': telefonoCliente,
    };
}
