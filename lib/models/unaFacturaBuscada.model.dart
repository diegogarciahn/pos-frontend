// To parse this JSON data, do
//
//     final unaFacturaBuscada = unaFacturaBuscadaFromJson(jsonString);

import 'dart:convert';

UnaFacturaBuscada unaFacturaBuscadaFromJson(String str) => UnaFacturaBuscada.fromJson(json.decode(str));

String unaFacturaBuscadaToJson(UnaFacturaBuscada data) => json.encode(data.toJson());

class UnaFacturaBuscada {
    UnaFacturaBuscada({
        required this.unafactura,
    });

    Unafactura unafactura;

    factory UnaFacturaBuscada.fromJson(Map<String, dynamic> json) => UnaFacturaBuscada(
        unafactura: Unafactura.fromJson(json['unafactura']),
    );

    Map<String, dynamic> toJson() => {
        'unafactura': unafactura.toJson(),
    };
}

class Unafactura {
    Unafactura({
        required this.idFactura,
        required this.numeroFactura,
        required this.fechaFactura,
        required this.descuentoTotalFactura,
        required this.isvTotalFactura,
        required this.totalFactura,
        required this.subTotalExonerado,
        required this.subTotalFactura,
        required this.cantidadLetras,
        required this.isDelete,
        required this.estado,
        required this.createdAt,
        required this.updatedAt,
        required this.idTipoPago,
        required this.idCliente,
        required this.idUsuario,
        required this.idEmpleado,
        required this.idVenta,
        required this.idTalonario,
        required this.idNumero,
        this.empleado,
        this.tipopago,
        this.talonario,
        this.cliente,
    });

    int idFactura;
    String numeroFactura;
    DateTime fechaFactura;
    String descuentoTotalFactura;
    String isvTotalFactura;
    String totalFactura;
    String subTotalExonerado;
    String subTotalFactura;
    String cantidadLetras;
    bool isDelete;
    bool estado;
    dynamic createdAt;
    DateTime updatedAt;
    int idTipoPago;
    int idCliente;
    int idUsuario;
    int idEmpleado;
    int idVenta;
    int idTalonario;
    int idNumero;
    Empleado? empleado;
    Tipopago? tipopago;
    Talonario? talonario;
    Cliente? cliente;

    factory Unafactura.fromJson(Map<String, dynamic> json) => Unafactura(
        idFactura: json['idFactura'] ?? 0,
        numeroFactura: json['numeroFactura'] ?? '0',
        fechaFactura: DateTime.parse(json['fechaFactura'] ?? '0000-00-00 00:00:00'),
        descuentoTotalFactura: json['descuentoTotalFactura'] ?? '0.00',
        isvTotalFactura: json['isvTotalFactura'] ?? '0.00',
        totalFactura: json['totalFactura'] ?? '0.00',
        subTotalExonerado: json['subTotalExonerado'] ?? '0.00',
        subTotalFactura: json['subTotalFactura'] ?? '0.00',
        cantidadLetras: json['cantidadLetras'] ?? 'NO ESPECIFICADO',
        isDelete: json['isDelete'],
        estado: json['estado'],
        createdAt: json['createdAt'] ?? '0000-00-00 00:00:00',
        updatedAt: DateTime.parse(json['updatedAt'] ?? '0000-00-00 00:00:00'),
        idTipoPago: json['idTipoPago'],
        idCliente: json['idCliente'],
        idUsuario: json['idUsuario'],
        idEmpleado: json['idEmpleado'],
        idVenta: json['idVenta'],
        idTalonario: json['idTalonario'],
        idNumero: json['idNumero'],
        empleado: Empleado?.fromJson(json['empleado']),
        tipopago: Tipopago?.fromJson(json['tipopago']),
        talonario: Talonario?.fromJson(json['talonario']),
        cliente: Cliente?.fromJson(json['cliente']),
    );

    Map<String, dynamic> toJson() => {
        'idFactura': idFactura,
        'numeroFactura': numeroFactura,
        'fechaFactura': '${fechaFactura.year.toString().padLeft(4, '0')}-${fechaFactura.month.toString().padLeft(2, '0')}-${fechaFactura.day.toString().padLeft(2, '0')}',
        'descuentoTotalFactura': descuentoTotalFactura,
        'isvTotalFactura': isvTotalFactura,
        'totalFactura': totalFactura,
        'subTotalExonerado': subTotalExonerado,
        'subTotalFactura': subTotalFactura,
        'cantidadLetras': cantidadLetras,
        'isDelete': isDelete,
        'estado': estado,
        'createdAt': createdAt,
        'updatedAt': updatedAt.toIso8601String(),
        'idTipoPago': idTipoPago,
        'idCliente': idCliente,
        'idUsuario': idUsuario,
        'idEmpleado': idEmpleado,
        'idVenta': idVenta,
        'idTalonario': idTalonario,
        'idNumero': idNumero,
        'empleado': empleado?.toJson(),
        'tipopago': tipopago?.toJson(),
        'talonario': talonario?.toJson(),
        'cliente': cliente?.toJson(),
    };
}

class Cliente {
    Cliente({
        required this.nombreCliente,
        required this.direccion,
        required this.dni,
        required this.email,
        required this.rtn,
        required this.telefonoCliente,
    });

    String nombreCliente;
    String direccion;
    String dni;
    String email;
    String rtn;
    String telefonoCliente;

    factory Cliente.fromJson(Map<String, dynamic>? json) => Cliente(
        nombreCliente: json?['nombreCliente'] ?? '',
        direccion: json?['direccion'] ?? '',
        dni: json?['dni'] ?? '',
        email: json?['email'] ?? 'NO ESPECIFICADO',
        rtn: json?['rtn'] ?? '',
        telefonoCliente: json?['telefonoCliente'],
    );

    Map<String, dynamic> toJson() => {
        'nombreCliente': nombreCliente,
        'direccion': direccion,
        'dni': dni,
        'email': email,
        'rtn': rtn,
        'telefonoCliente': telefonoCliente,
    };
}

class Empleado {
    Empleado({
        required this.id,
        required this.nombre,
        required this.apellido,
    });

    int? id;
    String? nombre;
    String? apellido;

    factory Empleado.fromJson(Map<String, dynamic>? json) => Empleado(
        id: json?['id'] ?? -1,
        nombre: json?['nombre'] ?? '',
        apellido: json?['apellido'] ?? '',
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'apellido': apellido,
    };
}

class Talonario {
    Talonario({
        required this.cai,
    });

    String? cai;

    factory Talonario.fromJson(Map<String, dynamic>? json) => Talonario(
        cai: json?['cai'] ?? '',
    );

    Map<String, dynamic> toJson() => {
        'cai': cai,
    };
}

class Tipopago {
    Tipopago({
        required this.tipoDePago,
    });

    String? tipoDePago;

    factory Tipopago.fromJson(Map<String, dynamic>? json) => Tipopago(
        tipoDePago: json?['tipoDePago'] ?? '',
    );

    Map<String, dynamic> toJson() => {
        'tipoDePago': tipoDePago,
    };
}
