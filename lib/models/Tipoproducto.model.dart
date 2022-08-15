class Tipoproducto {
  int? id;
  String? tipoProducto;
  String? descripcionProducto;
  String? isvTipoProducto;

  Tipoproducto(
      {this.id,
        this.tipoProducto,
        this.descripcionProducto,
        this.isvTipoProducto});

  Tipoproducto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipoProducto = json['tipoProducto'];
    descripcionProducto = json['descripcionProducto'];
    isvTipoProducto = json['isvTipoProducto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipoProducto'] = this.tipoProducto;
    data['descripcionProducto'] = this.descripcionProducto;
    data['isvTipoProducto'] = this.isvTipoProducto;
    return data;
  }
}