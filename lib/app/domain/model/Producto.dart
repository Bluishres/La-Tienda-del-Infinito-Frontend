
import 'package:la_tienda_del_infinito/app/domain/model/Usuario.dart';

class Producto {

//ATRIBUTOS
final int id;
final String nombre;
final String descripcion;
final double precio;
final int stockDisponible;
final DateTime fechaCreacion;
final List<Usuario> Lista_usuarios;

  //CONSTRUCTOR
  Producto._(
  {this.id,
      this.nombre,
      this.descripcion,
      this.precio,
      this.stockDisponible,
      this.fechaCreacion,
      this.Lista_usuarios,})
      : super();

  //MAPEADOR A OBJETO
  factory Producto.fromJson(Map<String, dynamic> json) => Producto._(
    id: json["id"],
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    precio: json["precio"],
    stockDisponible: json["stockDisponible"],
    fechaCreacion: json["fechaCreacion"],
    Lista_usuarios: json["Lista_usuarios"],
  );

  //MAPEADOR A JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "descripciom": descripcion,
    "precio": precio,
    "stockDisponible": stockDisponible,
    "fechaCreacion": fechaCreacion,
    "Lista_usuarios": Lista_usuarios,
  };


  @override
  // TODO: implement props
  List<Object> get props => [
    id,
    nombre,
    descripcion,
    precio,
    stockDisponible,
    fechaCreacion,
    Lista_usuarios,
  ];


}