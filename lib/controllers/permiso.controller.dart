import '../models/permiso.model.dart';
import '../services/permiso.service.dart';

//bloc
//provider
//

Future<bool> PermisoController(String permiso, String descripcion) async {
  Permiso? permisos = await crearPermiso(permiso, descripcion);
  if (permisos != null) {
    return true;
  } else {
    return false;
  }
}
