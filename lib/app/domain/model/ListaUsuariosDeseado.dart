// @dart=2.9
import 'dart:convert';
import '_models.dart';

class ListaUsuariosDeseado {
  ListaUsuariosDeseado({
    this.id,
    this.usuario,
    this.producto
  });

  final int id;
  final Usuario usuario;
  final Producto producto;

  ListaUsuariosDeseado copyWith({
    int id,
    Usuario usuario,
    Producto producto
  }) =>
      ListaUsuariosDeseado(
        id: id ?? this.id,
        usuario: usuario ?? this.usuario,
        producto: producto ?? this.producto
      );

  factory ListaUsuariosDeseado.fromRawJson(String str) => ListaUsuariosDeseado.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListaUsuariosDeseado.fromJson(Map<String, dynamic> json) => ListaUsuariosDeseado(
    id: json["id"],
    usuario: Usuario.fromJson(json["usuario"]),
    producto: Producto.fromJson(json["producto"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "usuario": usuario.toJson(),
    "producto": producto.toJson()
  };
}