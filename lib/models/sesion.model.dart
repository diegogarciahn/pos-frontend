
import 'dart:convert';

class Sesion {
    Sesion({
        required this.fecha,
        required this.isDelete,
        required this.id,
        required this.idUsuario,
        required this.token,
        required this.updatedAt,
        required this.createdAt,
    });

    DateTime fecha;
    bool isDelete;
    int id;
    int idUsuario;
    String token;
    DateTime updatedAt;
    DateTime createdAt;

    factory Sesion.fromJson(String str) => Sesion.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Sesion.fromMap(Map<String, dynamic> json) => Sesion(
        fecha: DateTime.parse(json['fecha']),
        isDelete: json['isDelete'],
        id: json['id'],
        idUsuario: json['idUsuario'],
        token: json['token'],
        updatedAt: DateTime.parse(json['updatedAt']),
        createdAt: DateTime.parse(json['createdAt']),
    );

    Map<String, dynamic> toMap() => {
        'fecha': fecha.toIso8601String(),
        'isDelete': isDelete,
        'id': id,
        'idUsuario': idUsuario,
        'token': token,
        'updatedAt': updatedAt.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
    };
}