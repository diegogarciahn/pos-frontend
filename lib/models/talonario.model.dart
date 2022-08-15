import 'dart:convert';

class TalonariosResponse {
  TalonariosResponse({
    this.talonarios,
  });

  List<Talonario>? talonarios;

  factory TalonariosResponse.fromJson(String str) =>
      TalonariosResponse.fromMap(json.decode(str));

  factory TalonariosResponse.fromMap(Map<String, dynamic> json) =>
      TalonariosResponse(
        talonarios: List<Talonario>.from(
            json["talonarios"].map((x) => Talonario.fromMap(x))),
      );
}

class Talonario {
  Talonario({
    required this.idTalonario,
    required this.rangoInicialFactura,
    required this.rangoFinalFactura,
    required this.cai,
    required this.idSucursal,
    required this.fechaLimiteEmision,
    required this.active,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
  });

  int idTalonario;
  String rangoInicialFactura;
  String rangoFinalFactura;
  String cai;
  int idSucursal;
  DateTime fechaLimiteEmision;
  bool active;
  bool isDelete;
  DateTime createdAt;
  DateTime updatedAt;

  factory Talonario.fromJson(String str) => Talonario.fromMap(json.decode(str));

  factory Talonario.fromMap(Map<String, dynamic> json) => Talonario(
        idTalonario: json["idTalonario"],
        rangoInicialFactura: json["rangoInicialFactura"],
        rangoFinalFactura: json["rangoFinalFactura"],
        cai: json["cai"],
        idSucursal: json["idSucursal"],
        fechaLimiteEmision: DateTime.parse(json["fechaLimiteEmision"]),
        active: json["active"],
        isDelete: json["isDelete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
