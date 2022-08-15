class TipoPago {
  TipoPago({
    required this.idTipoPago,
    required this.tipoDePago,
    required this.descripcionTipoPago,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
  });

  int idTipoPago;
  String tipoDePago;
  String descripcionTipoPago;
  bool isDelete;
  DateTime createdAt;
  DateTime updatedAt;

  factory TipoPago.fromJson(Map<String, dynamic> json) => TipoPago(
        idTipoPago: json["idTipoPago"],
        tipoDePago: json["tipoDePago"],
        descripcionTipoPago: json["descripcionTipoPago"],
        isDelete: json["isDelete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "idTipoPago": idTipoPago,
        "tipoDePago": tipoDePago,
        "descripcionTipoPago": descripcionTipoPago,
        "isDelete": isDelete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
