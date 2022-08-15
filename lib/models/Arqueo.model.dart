// To parse this JSON data, do
//
//     final manipularArqueo = manipularArqueoFromJson(jsonString);
import 'dart:convert';

ManipularArqueo manipularArqueoFromJson(String str) =>
    ManipularArqueo.fromJson(json.decode(str));
String manipularArqueoToJson(ManipularArqueo data) =>
    json.encode(data.toJson());

class ManipularArqueo {
  ManipularArqueo({
    required this.arqueos,
  });

  List<Arqueo> arqueos;

  factory ManipularArqueo.fromJson(Map<String, dynamic> json) =>
      ManipularArqueo(
        arqueos:
            List<Arqueo>.from(json['arqueos'].map((x) => Arqueo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'arqueos': List<dynamic>.from(arqueos.map((x) => x.toJson())),
      };
}

class Arqueo {
  Arqueo({
    required this.idArqueo,
    required this.fechaInicio,
    required this.fechaFinal,
    required this.efectivoApertura,
    required this.efectivoCierre,
    required this.otrosPagos,
    required this.ventaCredito,
    required this.ventaTotal,
    required this.efectivoTotal,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
    required this.idUsuario,
    required this.idSesion,
  });

  int idArqueo;
  DateTime fechaInicio;
  DateTime fechaFinal;
  String efectivoApertura;
  String efectivoCierre;
  String otrosPagos;
  String ventaCredito;
  String ventaTotal;
  String efectivoTotal;
  bool isDelete;
  DateTime createdAt;
  DateTime updatedAt;
  int idUsuario;
  int idSesion;

  factory Arqueo.fromJson(Map<String, dynamic> json) => Arqueo(
        idArqueo: json['idArqueo'] ?? -1,
        fechaInicio: DateTime.parse(json['fechaInicio'] ?? -1),
        fechaFinal: DateTime.parse(json['fechaFinal'] ?? '0000-00-00 00:00:00'),
        efectivoApertura: json['efectivoApertura'] ?? -1,
        efectivoCierre: json['efectivoCierre'] ?? '0.00',
        otrosPagos: json['otrosPagos'] ?? '0.00',
        ventaCredito: json['ventaCredito'] ?? '0.00',
        ventaTotal: json['ventaTotal'] ?? '0.00',
        efectivoTotal: json['efectivoTotal'] ?? '0.00',
        isDelete: json['isDelete'] ?? false,
        createdAt: DateTime.parse(json['createdAt'] ?? '0000-00-00 00:00:00'),
        updatedAt: DateTime.parse(json['updatedAt'] ?? '0000-00-00 00:00:00'),
        idUsuario: json['idUsuario'] ?? '0.00',
        idSesion: json['idSesion'] ?? '0.00',
      );

  Map<String, dynamic> toJson() => {
        'idArqueo': idArqueo,
        'fechaInicio':
            '${fechaInicio.year.toString().padLeft(4, '0')}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')}',
        'fechaFinal':
            '${fechaFinal.year.toString().padLeft(4, '0')}-${fechaFinal.month.toString().padLeft(2, '0')}-${fechaFinal.day.toString().padLeft(2, '0')} ',
        'efectivoApertura': efectivoApertura,
        'efectivoCierre': efectivoCierre,
        'otrosPagos': otrosPagos,
        'ventaCredito': ventaCredito,
        'ventaTotal': ventaTotal,
        'efectivoTotal': efectivoTotal,
        'isDelete': isDelete,
        'createdAt':
            '${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}',
        'updatedAt':
            '${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}',
        'idUsuario': idUsuario,
        'idSesion': idSesion,
      };
}
