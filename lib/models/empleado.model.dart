// To parse this JSON data, do
//
//     final empleado = empleadoFromJson(jsonString);

import 'dart:convert';

Empleado empleadoFromJson(String str) => Empleado.fromJson(json.decode(str));

String empleadoToJson(Empleado data) => json.encode(data.toJson());

class Empleado {
    Empleado({
        required this.todoslosEmpleados,
    });

    List<TodoslosEmpleados> todoslosEmpleados;

    factory Empleado.fromJson(Map<String, dynamic> json) => Empleado(
        todoslosEmpleados: List<TodoslosEmpleados>.from(json["todoslosEmpleados"].map((x) => TodoslosEmpleados.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "todoslosEmpleados": List<dynamic>.from(todoslosEmpleados.map((x) => x.toJson())),
    };
}

class TodoslosEmpleados {
    TodoslosEmpleados({
        required this.id,
        required this.dni,
        required this.nombre,
        required this.apellido,
        required this.direccion,
        required this.telefono,
        required this.fechaNacimiento,
        required this.sexo,
        required this.isDelete,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String dni;
    String nombre;
    String apellido;
    String direccion;
    String telefono;
    String fechaNacimiento;
    String sexo;
    bool isDelete;
    DateTime createdAt;
    DateTime updatedAt;

    factory TodoslosEmpleados.fromJson(Map<String, dynamic> json) => TodoslosEmpleados(
        id: json["id"],
        dni: json["dni"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        fechaNacimiento: json["fechaNacimiento"],
        sexo: json["sexo"],
        isDelete: json["isDelete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dni": dni,
        "nombre": nombre,
        "apellido": apellido,
        "direccion": direccion,
        "telefono": telefono,
        "fechaNacimiento": fechaNacimiento,
        "sexo": sexo,
        "isDelete": isDelete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
