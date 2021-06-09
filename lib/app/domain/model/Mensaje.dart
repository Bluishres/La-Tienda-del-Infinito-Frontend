// @dart=2.9
import 'dart:convert';
import '_models.dart';

class Mensaje {
  Mensaje({
    this.fechaCreacion,
    this.id,
    this.mensaje,
  });

  final DateTime fechaCreacion;
  final int id;
  final String mensaje;

  Mensaje copyWith({
    DateTime fechaCreacion,
    int id,
    String mensaje,
  }) =>
      Mensaje(
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
  );

  Map<String, dynamic> toJson() => {
    "fecha_creacion": fechaCreacion.toIso8601String(),
    "id": id,
    "mensaje": mensaje,
  };
}