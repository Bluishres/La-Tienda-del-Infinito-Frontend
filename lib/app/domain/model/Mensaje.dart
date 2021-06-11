// @dart=2.9
import 'dart:convert';

import 'package:shopend/app/domain/commands/_commands.dart';
import 'package:shopend/app/domain/model/_models.dart';

class Mensaje extends CommandBase{
  Mensaje({
    this.autor,
    this.hilo,
    this.fechaCreacion,
    this.id,
    this.mensaje,
  });

  final DateTime fechaCreacion;
  final int id;
  final String mensaje;
  final Usuario autor;
  final Hilo hilo;

  Mensaje copyWith({
    DateTime fechaCreacion,
    int id,
    String mensaje,
    Usuario autor,
    Hilo hilo
  }) =>
      Mensaje(
        autor: autor ?? this.autor,
        hilo: hilo ?? this.hilo,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        id: id ?? this.id,
        mensaje: mensaje ?? this.mensaje,
      );

  factory Mensaje.fromRawJson(String str) => Mensaje.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        fechaCreacion: DateTime.parse(json["fecha_creacion"]),
        id: json["id"],
        mensaje: json["mensaje"],
        autor: Usuario.fromJson(json["autor"]),
        hilo: Hilo.fromJson(json["hilo"])
      );

  Map<String, dynamic> toJson() => {
        "fecha_creacion": fechaCreacion.toIso8601String(),
        "id": id,
        "mensaje": mensaje,
        "autor": autor.toJson(),
        "hilo": hilo.toJson()
      };
}
