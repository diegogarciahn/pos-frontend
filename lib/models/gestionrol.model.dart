import 'dart:convert';

Role rolFromJson(String str) => Role.fromJson(json.decode(str));
String rolToJson(Role data) => json.encode(data.toJson());

class Role {
  Role({
    required this.todoslosRoles,
  });

  List<TodosLosRol> todoslosRoles;
  factory Role.fromJson(Map<String, dynamic> json) => Role(
        todoslosRoles: List<TodosLosRol>.from(
            json['todoslosRoles'].map((x) => TodosLosRol.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        'todoslosRoles':
            List<dynamic>.from(todoslosRoles.map((x) => x.toJson())),
      };
}

class TodosLosRol {
  TodosLosRol({
    required this.id,
    required this.rol,
    required this.descripcion,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String rol;
  String descripcion;
  bool isDelete;
  DateTime createdAt;
  DateTime updatedAt;

  factory TodosLosRol.fromJson(Map<String, dynamic> json) => TodosLosRol(
        id: json['id'] ?? 0,
        rol: json['rol'] ?? '',
        descripcion: json['descripcion'] ?? '',
        isDelete: json['isDelete'] ?? false,
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'rol': rol,
        'descripcion': descripcion,
        'isDelete': isDelete,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
