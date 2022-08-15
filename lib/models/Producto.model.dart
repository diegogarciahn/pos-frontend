class Producto {
  int? id;
  String? codigoProducto;
  String? nombreProducto;
  String? precioProducto;
  int? cantidadProducto;
  String? isvProducto;
  String? descProducto;
  bool? isExcento;
  String? urlImage;
  int? idTipoProducto;

  Producto({
    this.id,
    this.codigoProducto,
    this.nombreProducto,
    this.precioProducto,
    this.cantidadProducto,
    this.isvProducto,
    this.descProducto,
    this.isExcento,
    this.urlImage,
    this.idTipoProducto
  });


  Producto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codigoProducto = json['codigoProducto'];
    nombreProducto = json['nombreProducto'];
    precioProducto = json['precioProducto'];
    cantidadProducto = json['cantidadProducto'];
    isvProducto = json['isvProducto'];
    descProducto = json['descProducto'];
    isExcento = json['isExcento'];
    urlImage = json['urlImage'];
    idTipoProducto = json['idTipoProducto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codigoProducto'] = this.codigoProducto;
    data['nombreProducto'] = this.nombreProducto;
    data['precioProducto'] = this.precioProducto;
    data['cantidadProducto'] = this.cantidadProducto;
    data['isvProducto'] = this.isvProducto;
    data['descProducto'] = this.descProducto;
    data['isExcento'] = this.isExcento;
    data['urlImage'] = this.urlImage;
    data['idTipoProducto'] = this.idTipoProducto;
    return data;
  }
}