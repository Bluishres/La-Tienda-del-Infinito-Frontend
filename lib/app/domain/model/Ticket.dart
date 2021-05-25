import 'dart:convert';
import '_models.dart';

class Ticket {
  Ticket({
    this.fecha,
    this.id,
    this.importe,
    this.unidades,
    this.usuario,
  });

  final DateTime fecha;
  final int id;
  final int importe;
  final int unidades;
  final Usuario usuario;

  Ticket copyWith({
    DateTime fecha,
    int id,
    int importe,
    int unidades,
    Usuario usuario,
  }) =>
      Ticket(
        fecha: fecha ?? this.fecha,
        id: id ?? this.id,
        importe: importe ?? this.importe,
        unidades: unidades ?? this.unidades,
        usuario: usuario ?? this.usuario,
      );

  factory Ticket.fromRawJson(String str) => Ticket.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    fecha: DateTime.parse(json["fecha"]),
    id: json["id"],
    importe: json["importe"],
    unidades: json["unidades"],
    usuario: Usuario.fromJson(json["usuario"]),
  );

  Map<String, dynamic> toJson() => {
    "fecha": fecha.toIso8601String(),
    "id": id,
    "importe": importe,
    "unidades": unidades,
    "usuario": usuario.toJson(),
  };
}
