// To parse this JSON data, do
//
//     final mensajePeticion = mensajePeticionFromJson(jsonString);

import 'dart:convert';

MensajePeticion mensajePeticionFromJson(String str) => MensajePeticion.fromJson(json.decode(str));

String mensajePeticionToJson(MensajePeticion data) => json.encode(data.toJson());

class MensajePeticion {
    MensajePeticion({
        required this.msg,
    });

    String msg;

    factory MensajePeticion.fromJson(Map<String, dynamic> json) => MensajePeticion(
        msg: json['msg'] ?? 'error',
    );

    Map<String, dynamic> toJson() => {
        'msg': msg,
    };
}
