import 'dart:convert';

import 'package:soft_frontend/models/ventaBuscada.model.dart';

ManipularVenta manipularVentaFromJson(String str) =>
    ManipularVenta.fromJson(json.decode(str));

String ManipularVentaToJson(ManipularVenta data) => json.encode(data.toJson());

class ManipularVenta {
  ManipularVenta({required this.ventaA});

  List<MostrarVenta> ventaA;

  factory ManipularVenta.fromJson(Map<String, dynamic> json) => ManipularVenta(
        ventaA: List<MostrarVenta>.from(
            json["venta"].map((x) => MostrarVenta.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "venta": List<dynamic>.from(ventaA.map((x) => x.toJson())),
      };
}
