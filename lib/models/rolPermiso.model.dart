import 'dart:convert';

class RolesPermisos {
    RolesPermisos({
        required this.createdAt,
        required this.updatedAt,
        required this.idRol,
        required this.idPermiso,
    });

    DateTime createdAt;
    DateTime updatedAt;
    int idRol;
    int idPermiso;

    factory RolesPermisos.fromJson(String str) => RolesPermisos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RolesPermisos.fromMap(Map<String, dynamic> json) => RolesPermisos(
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        idRol: json['idRol'],
        idPermiso: json['idPermiso'],
    );

    Map<String, dynamic> toMap() => {
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'idRol': idRol,
        'idPermiso': idPermiso,
    };
}