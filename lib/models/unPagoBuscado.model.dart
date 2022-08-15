import 'dart:convert';

UnTipoPago UnTipoPagoBuscadoFromJson(String str) =>
    UnTipoPago.fromJson(json.decode(str));

String UnTipoPagoBuscadoToJson(UnTipoPago data) => json.encode(data.toJson());

class UnTipoPago {
  UnTipoPago({
    required this.tipopagos,
  });

  List<Tipopago> tipopagos;

  factory UnTipoPago.fromJson(Map<String, dynamic> json) => UnTipoPago(
        tipopagos: List<Tipopago>.from(
            json["tipopagos"].map((x) => Tipopago.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tipopagos": List<dynamic>.from(tipopagos.map((x) => x.toJson())),
      };
}

class Tipopago {
  Tipopago({
    required this.idTipoPago,
    required this.tipoDePago,
    required this.descripcionTipoPago,
  });

  int idTipoPago;
  String tipoDePago;
  String descripcionTipoPago;

  factory Tipopago.fromJson(Map<String, dynamic> json) => Tipopago(
        idTipoPago: json["idTipoPago"],
        tipoDePago: json["tipoDePago"],
        descripcionTipoPago: json["descripcionTipoPago"],
      );

  Map<String, dynamic> toJson() => {
        "idTipoPago": idTipoPago,
        "tipoDePago": tipoDePago,
        "descripcionTipoPago": descripcionTipoPago,
      };
}
