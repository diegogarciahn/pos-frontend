import 'dart:convert';

import 'package:soft_frontend/models/tipoPagoBuscado.model.dart';

ManipularTipoPago manipularTipoPagoFromJson(String str) =>
    ManipularTipoPago.fromJson(json.decode(str));

String ManipularTipoPagoToJson(ManipularTipoPago data) =>
    json.encode(data.toJson());

class ManipularTipoPago {
  ManipularTipoPago({required this.tipoPago});

  List<TipoPagoBuscado> tipoPago;

  factory ManipularTipoPago.fromJson(Map<String, dynamic> json) =>
      ManipularTipoPago(
        tipoPago: List<TipoPagoBuscado>.from(
            json["tipopagos"].map((x) => TipoPagoBuscado.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tipopagos": List<dynamic>.from(tipoPago.map((x) => x.toJson())),
      };
}
