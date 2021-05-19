

import '_models.dart';

class Producto {

//ATRIBUTOS
final int id;
final String nombre;
final String descripcion;
final double precio;
final int stockDisponible;
final DateTime fechaCreacion;
final List<UserModel> listaUsuarios;

  //CONSTRUCTOR
  Producto._(
  {this.id,
      this.nombre,
      this.descripcion,
      this.precio,
      this.stockDisponible,
      this.fechaCreacion,
      this.listaUsuarios,})
      : super();

  //MAPEADOR A OBJETO
  factory Producto.fromJson(Map<String, dynamic> json) => Producto._(
    id: json["id"],
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    precio: json["precio"],
    stockDisponible: json["stockDisponible"],
    fechaCreacion: json["fechaCreacion"],
    listaUsuarios: json["listaUsuarios"],
  );

  //MAPEADOR A JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "descripciom": descripcion,
    "precio": precio,
    "stockDisponible": stockDisponible,
    "fechaCreacion": fechaCreacion,
    "listaUsuarios": listaUsuarios,
  };


  List<Object> get props => [
    id,
    nombre,
    descripcion,
    precio,
    stockDisponible,
    fechaCreacion,
    listaUsuarios,
  ];


}