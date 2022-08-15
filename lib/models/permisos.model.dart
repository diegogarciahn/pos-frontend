import 'dart:convert';

import 'package:soft_frontend/models/permiso.model.dart';

class Permisos {
    Permisos({
        required this.message,
        required this.data,
    });

    String message;
    List<Permiso2> data;

    factory Permisos.fromJson(String str) => Permisos.fromMap(json.decode(str));

    factory Permisos.fromMap(Map<String, dynamic> json) => Permisos(
        message: json["message"],
        data: List<Permiso2>.from(json["data"].map((x) => Permiso2.fromMap(x))),
    );

}

class Permiso2 {
    Permiso2({
        required this.id,
        required this.permiso,
        required this.descripcion,
        required this.isDelete,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String permiso;
    String descripcion;
    bool isDelete;
    DateTime createdAt;
    DateTime updatedAt;

    factory Permiso2.fromJson(String str) => Permiso2.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Permiso2.fromMap(Map<String, dynamic> json) => Permiso2(
        id: json['id'],
        permiso: json['permiso'],
        descripcion: json['descripcion'],
        isDelete: json['isDelete'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
    );

    Map<String, dynamic> toMap() => {
        'id': id,
        'permiso': permiso,
        'descripcion': descripcion,
        'isDelete': isDelete,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
    };
}