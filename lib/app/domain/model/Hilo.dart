import 'dart:convert';
import '_models.dart';

class Hilo {
  Hilo({
    this.fechaCreacion,
    this.id,
    this.listaMensajes,
    this.titulo,
  });

  final DateTime fechaCreacion;
  final int id;
  final List<Mensaje> listaMensajes;
  final String titulo;

  Hilo copyWith({
    DateTime fechaCreacion,
    int id,
    List<Mensaje> listaMensajes,
    String titulo,
  }) =>
      Hilo(
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        id: id ?? this.id,
        listaMensajes: listaMensajes ?? this.listaMensajes,
        titulo: titulo ?? this.titulo,
      );

  factory Hilo.fromRawJson(String str) => Hilo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hilo.fromJson(Map<String, dynamic> json) => Hilo(
    fechaCreacion: DateTime.parse(json["fecha_creacion"]),
    id: json["id"],
    listaMensajes: List<Mensaje>.from(json["lista_mensajes"].map((x) => Mensaje.fromJson(x))),
    titulo: json["titulo"],
  );

  Map<String, dynamic> toJson() => {
    "fecha_creacion": fechaCreacion.toIso8601String(),
    "id": id,
    "lista_mensajes": List<dynamic>.from(listaMensajes.map((x) => x.toJson())),
    "titulo": titulo,
  };
}