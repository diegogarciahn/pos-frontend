import 'dart:convert';

class Sucursal {
  Sucursal({
    required this.sucursal,
  });

  DetalleSucursal sucursal;

  factory Sucursal.fromJson(String str) => Sucursal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sucursal.fromMap(Map<String, dynamic> json) => Sucursal(
        sucursal: DetalleSucursal.fromMap(json["sucursal"]),
      );

  Map<String, dynamic> toMap() => {
        "sucursal": sucursal.toMap(),
      };
}

class Sucursales {
  Sucursales({
    required this.sucursales,
  });

  List<DetalleSucursal> sucursales;

  factory Sucursales.fromJson(String str) =>
      Sucursales.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sucursales.fromMap(Map<String, dynamic> json) => Sucursales(
        sucursales: List<DetalleSucursal>.from(
            json["sucursales"].map((x) => DetalleSucursal.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "sucursales": List<dynamic>.from(sucursales.map((x) => x.toMap())),
      };
}

class DetalleSucursal {
  DetalleSucursal({
    required this.idSucursal,
    required this.nombreSucursal,
    required this.lemaSucursal,
    required this.direccion,
    required this.telefono,
    required this.email,
    required this.rtn,
    required this.logo,
    required this.createdAt,
    required this.updatedAt,
  });

  int idSucursal;
  String nombreSucursal;
  String lemaSucursal;
  String direccion;
  String telefono;
  String email;
  String rtn;
  String logo;
  DateTime createdAt;
  DateTime updatedAt;

  factory DetalleSucursal.fromJson(String str) =>
      DetalleSucursal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetalleSucursal.fromMap(Map<String, dynamic> json) => DetalleSucursal(
        idSucursal: json["idSucursal"],
        nombreSucursal: json["nombreSucursal"],
        lemaSucursal: json["lemaSucursal"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        email: json["email"],
        rtn: json["rtn"],
        logo: json["logo"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "idSucursal": idSucursal,
        "nombreSucursal": nombreSucursal,
        "lemaSucursal": lemaSucursal,
        "direccion": direccion,
        "telefono": telefono,
        "email": email,
        "rtn": rtn,
        "logo": logo,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
