//To parse this JSON data, do
//
// final ventaBuscada = ventaBuscadaFromJson(jsonString);

import 'dart:convert';

VentaBuscada ventaBuscadaFromJson(String str) =>
    VentaBuscada.fromJson(json.decode(str));

String ventaBuscadaToJson(VentaBuscada data) => json.encode(data.toJson());

class VentaBuscada {
  VentaBuscada({
    required this.venta,
  });

  List<MostrarVenta> venta;

  factory VentaBuscada.fromJson(Map<String, dynamic> json) => VentaBuscada(
        venta: List<MostrarVenta>.from(
            json['venta'].map((x) => MostrarVenta.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'venta': List<dynamic>.from(venta.map((x) => x.toJson())),
      };
}

class MostrarVenta {
  MostrarVenta({
    required this.id,
    required this.totalIsv,
    required this.totalVenta,
    required this.totalDescuentoVenta,
    required this.puntoDeEmision,
    required this.establecimiento,
    required this.tipo,
    required this.idSesion,
    required this.idUsuario,
    required this.idCliente,
    required this.isActive,
    required this.nombreCliente,
    required this.dni,
    required this.rtn,
    required this.direccionCliente,
    required this.telefonoCliente,
    required this.idEmpleado,
    required this.nombreEmpleado,
  });

  int id;
  String totalIsv;
  String totalVenta;
  String totalDescuentoVenta;
  String puntoDeEmision;
  String establecimiento;
  String tipo;
  int idSesion;
  int idUsuario;
  int idCliente;
  bool isActive;
  String nombreCliente;
  String dni;
  String rtn;
  String direccionCliente;
  String telefonoCliente;
  int idEmpleado;
  String nombreEmpleado;

  factory MostrarVenta.fromJson(Map<String, dynamic> json) => MostrarVenta(
        id: json['id'] ?? '0.00',
        totalIsv: json['totalISV'] ?? '0.00',
        totalVenta: json['totalVenta'] ?? '0.00',
        totalDescuentoVenta: json['totalDescuentoVenta'] ?? '0.00',
        puntoDeEmision: json['puntoDeEmision'] ?? '0.00',
        establecimiento: json['establecimiento'] ?? '0.00',
        tipo: json['tipo'] ?? '0.00',
        idSesion: json['idSesion'] ?? '0.00',
        idUsuario: json['idUsuario'] ?? '0.00',
        idCliente: json['idCliente'] ?? '0.00',
        isActive: json['isActive'] ?? '0.00',
        nombreCliente: json['nombreCliente'] ?? '0.00',
        dni: json['dni'] ?? '0.00',
        rtn: json['rtn'] ?? '0.00',
        direccionCliente: json['direccionCliente'] ?? '0.00',
        telefonoCliente: json['telefonoCliente'] ?? '0.00',
        idEmpleado: json['idEmpleado'] ?? '0.00',
        nombreEmpleado: json['nombreEmpleado'] ?? '0.00',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'totalISV': totalIsv,
        'totalVenta': totalVenta,
        'totalDescuentoVenta': totalDescuentoVenta,
        'puntoDeEmision': puntoDeEmision,
        'establecimiento': establecimiento,
        'tipo': tipo,
        'idSesion': idSesion,
        'idUsuario': idUsuario,
        'idCliente': idCliente,
        'isActive': isActive,
        'nombreCliente': nombreCliente,
        'dni': dni,
        'rtn': rtn,
        'direccionCliente': direccionCliente,
        'telefonoCliente': telefonoCliente,
        'idEmpleado': idEmpleado,
        'nombreEmpleado': nombreEmpleado,
      };
}
