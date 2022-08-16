import 'dart:convert';

TipoPagoBuscado tipoPagoBuscadoFromJson(String str) =>
    TipoPagoBuscado.fromJson(json.decode(str));

String tipoPagoBuscadoToJson(TipoPagoBuscado data) =>
    json.encode(data.toJson());

class TipoPagoBuscado {
  TipoPagoBuscado({
    required this.idTipoPago,
    required this.tipoDePago,
    required this.descripcionTipoPago,
  });

  int idTipoPago;
  String tipoDePago;
  String descripcionTipoPago;

  factory TipoPagoBuscado.fromJson(Map<String, dynamic> json) =>
      TipoPagoBuscado(
        idTipoPago: json['idTipoPago'],
        tipoDePago: json['tipoDePago'],
        descripcionTipoPago: json['descripcionTipoPago'],
      );

  Map<String, dynamic> toJson() => {
        'idTipoPago': idTipoPago,
        'tipoDePago': tipoDePago,
        'descripcionTipoPago': descripcionTipoPago,
      };
}
