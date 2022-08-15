import 'dart:convert';

import 'package:soft_frontend/models/rolPermiso.model.dart';

class Permiso {
    Permiso({
        required this.id,
        required this.permiso,
        required this.descripcion,
        required this.isDelete,
        required this.createdAt,
        required this.updatedAt,
        required this.rolesPermisos,
    });

    int id;
    String permiso;
    String descripcion;
    bool isDelete;
    DateTime createdAt;
    DateTime updatedAt;
    RolesPermisos rolesPermisos;

    factory Permiso.fromJson(String str) => Permiso.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Permiso.fromMap(Map<String, dynamic> json) => Permiso(
        id: json['id'],
        permiso: json['permiso'],
        descripcion: json['descripcion'],
        isDelete: json['isDelete'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        rolesPermisos: RolesPermisos.fromMap(json['roles_permisos']),
    );

    Map<String, dynamic> toMap() => {
        'id': id,
        'permiso': permiso,
        'descripcion': descripcion,
        'isDelete': isDelete,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'roles_permisos': rolesPermisos.toMap(),
    };
}