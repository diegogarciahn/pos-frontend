// To parse this JSON data, do
//
//     final rolResponse = rolResponseFromMap(jsonString);

import 'dart:convert';

class RolResponse {
    RolResponse({
        required this.message,
        required this.data,
    });

    String message;
    Rol2 data;

    factory RolResponse.fromJson(String str) => RolResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RolResponse.fromMap(Map<String, dynamic> json) => RolResponse(
        message: json["message"],
        data: Rol2.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "data": data.toMap(),
    };
}

class Rol2 {
    Rol2({
        required this.isDelete,
        required this.id,
        required this.rol,
        required this.descripcion,
        required this.updatedAt,
        required this.createdAt,
    });

    bool isDelete;
    int id;
    String rol;
    String descripcion;
    DateTime updatedAt;
    DateTime createdAt;

    factory Rol2.fromJson(String str) => Rol2.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Rol2.fromMap(Map<String, dynamic> json) => Rol2(
        isDelete: json["isDelete"],
        id: json["id"],
        rol: json["rol"],
        descripcion: json["descripcion"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toMap() => {
        "isDelete": isDelete,
        "id": id,
        "rol": rol,
        "descripcion": descripcion,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
    };
}
