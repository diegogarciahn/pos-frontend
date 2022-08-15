import 'dart:convert';

import 'package:soft_frontend/models/permiso.model.dart';

class Rol {
    Rol({
        required this.id,
        required this.rol,
        required this.descripcion,
        required this.isDelete,
        required this.createdAt,
        required this.updatedAt,
        required this.permisos,
    });

    int id;
    String rol;
    String descripcion;
    bool isDelete;
    DateTime createdAt;
    DateTime updatedAt;
    List<Permiso> permisos;

    factory Rol.fromJson(String str) => Rol.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Rol.fromMap(Map<String, dynamic> json) => Rol(
        id: json['id'],
        rol: json['rol'],
        descripcion: json['descripcion'],
        isDelete: json['isDelete'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        permisos: List<Permiso>.from(json['permisos'].map((x) => Permiso.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        'id': id,
        'rol': rol,
        'descripcion': descripcion,
        'isDelete': isDelete,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'permisos': List<dynamic>.from(permisos.map((x) => x.toMap())),
    };
}