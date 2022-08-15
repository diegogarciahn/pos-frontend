// To parse this JSON data, do
//
//     final cliente = clienteFromJson(jsonString);

import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
  Cliente({
    required this.todoslosClientes,
  });

  List<TodoslosCliente> todoslosClientes;

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        todoslosClientes: List<TodoslosCliente>.from(
            json["todoslosClientes"].map((x) => TodoslosCliente.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "todoslosClientes":
            List<dynamic>.from(todoslosClientes.map((x) => x.toJson())),
      };
}

class TodoslosCliente {
  TodoslosCliente({
    required this.id,
    required this.dni,
    required this.email,
    required this.rtn,
    required this.nombreCliente,
    required this.direccion,
    required this.telefonoCliente,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String dni;
  String email;
  String rtn;
  String nombreCliente;
  String direccion;
  String telefonoCliente;
  bool isDelete;
  DateTime createdAt;
  DateTime updatedAt;

  factory TodoslosCliente.fromJson(Map<String, dynamic> json) =>
      TodoslosCliente(
        id: json["id"],
        dni: json["dni"],
        email: json["email"],
        rtn: json["rtn"] ?? 0,
        nombreCliente: json["nombreCliente"],
        direccion: json["direccion"],
        telefonoCliente: json["telefonoCliente"],
        isDelete: json["isDelete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dni": dni,
        "email": email,
        "rtn": rtn,
        "nombreCliente": nombreCliente,
        "direccion": direccion,
        "telefonoCliente": telefonoCliente,
        "isDelete": isDelete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
