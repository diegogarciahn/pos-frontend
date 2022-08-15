import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/models/models.dart';



  RolesPermisos? rolPermiso = null;
  List<RolesPermisos?> RolesPermisosCreado = [];

class ListRolesPermisos {
  ListRolesPermisos(this.rolespermisos);
  List<RolPermiso> rolespermisos;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'lista' : rolespermisos,
  };
}

class RolPermiso {
  RolPermiso(this.idRol, this.idPermiso);
  String idRol;
  int idPermiso;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'idRol': idRol,
    'idPermiso': idPermiso,
  };
  
}

Future crearRolPermiso(List<int> listaIdPermiso, String idRolA) async {
  List<RolPermiso> listaRolesPermisos = [];
  for (var i = 0; i < listaIdPermiso.length; i++) {
    listaRolesPermisos.add(RolPermiso(idRolA, listaIdPermiso[i]));
  }

  late ListRolesPermisos listafinal = ListRolesPermisos(listaRolesPermisos);

  final requestBody = json.encoder.convert(listafinal);
  print(requestBody);

  try {
    Map<String,String> headers = {'Content-Type':'application/json'};
    var response = await http.post(Uri.parse(API_URL + 'rolpermiso/crearrolpermiso'),
    headers: headers,
        body: requestBody);
    print(response.body);
    if (response.statusCode == 200) {
      print(RolesPermisos);
      print("PIJUDOOOO");
      //return clienteCreado;
    } else if (response.statusCode == 400) {
      print("Cagaste 400");
    } else {
      // return clienteCreado;
    }
    return RolesPermisosCreado;
  } catch (e) {
    print(e);
    return RolesPermisosCreado;
  } finally {
    http.Client().close();
  }
}
