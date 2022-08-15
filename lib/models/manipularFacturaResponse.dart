// To parse this JSON data, do
//
//     final ManipularFacturaResponse = ManipularFacturaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:soft_frontend/models/facturaBuscada.model.dart';

ManipularFacturaResponse manipularFacturaResponseFromJson(String str) => ManipularFacturaResponse.fromJson(json.decode(str));

String manipularFacturaResponseToJson(ManipularFacturaResponse data) => json.encode(data.toJson());

class ManipularFacturaResponse {
    ManipularFacturaResponse({
        required this.facturas,
    });

    List<FacturaBuscada> facturas;

    factory ManipularFacturaResponse.fromJson(Map<String, dynamic> json) => ManipularFacturaResponse(
        facturas: List<FacturaBuscada>.from(json["facturas"].map((x) => FacturaBuscada.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "facturas": List<dynamic>.from(facturas.map((x) => x.toJson())),
    };
}