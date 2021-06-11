// @dart=2.9
import 'dart:convert';

import 'package:shopend/app/domain/commands/_commands.dart';

import '_models.dart';

class Hilo extends CommandBase{
  Hilo({this.creador,
    this.fechaCreacion,
    this.id,
    this.titulo,
  });

  final DateTime fechaCreacion;
  final int id;
  final String titulo;
  final Usuario creador;

  Hilo copyWith({
    DateTime fechaCreacion,
    int id,
    String titulo,
    String creador
  }) =>
      Hilo(
        creador: creador ?? this.creador,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        id: id ?? this.id,
        titulo: titulo ?? this.titulo,
      );

  factory Hilo.fromRawJson(String str) => Hilo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hilo.fromJson(Map<String, dynamic> json) => Hilo(
        fechaCreacion: json["fecha_creacion"] == ""
            ? DateTime.parse("0000-00-00")
            : DateTime.parse(json["fecha_creacion"]),
        id: json["id"],
        titulo: json["titulo"],
        creador: Usuario.fromJson(json["creador"])
      );

  Map<String, dynamic> toJson() => {
        "fecha_creacion": fechaCreacion == null ? "" : fechaCreacion.toString(),
        "id": id,
        "titulo": titulo,
        "creador": creador.toJson()
      };
}
