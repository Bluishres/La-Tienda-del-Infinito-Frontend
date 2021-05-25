import 'dart:convert';
import '_models.dart';

class ListaUsuariosDeseado {
  ListaUsuariosDeseado({
    this.id,
    this.usuario,
  });

  final int id;
  final Usuario usuario;

  ListaUsuariosDeseado copyWith({
    int id,
    Usuario usuario,
  }) =>
      ListaUsuariosDeseado(
        id: id ?? this.id,
        usuario: usuario ?? this.usuario,
      );

  factory ListaUsuariosDeseado.fromRawJson(String str) => ListaUsuariosDeseado.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListaUsuariosDeseado.fromJson(Map<String, dynamic> json) => ListaUsuariosDeseado(
    id: json["id"],
    usuario: Usuario.fromJson(json["usuario"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "usuario": usuario.toJson(),
  };
}