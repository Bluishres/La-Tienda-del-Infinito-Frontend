// @dart=2.9
import 'dart:convert';

import 'package:shopend/app/domain/commands/_commands.dart';

import '_models.dart';

class Ticket extends CommandBase {
  Ticket(
      {this.fecha,
      this.id,
      this.importe,
      this.unidades,
      this.usuario,
      this.producto});

  final DateTime fecha;
  final int id;
  final double importe;
  final int unidades;
  final Usuario usuario;
  final Producto producto;

  Ticket copyWith(
          {DateTime fecha,
          int id,
          double importe,
          int unidades,
          Usuario usuario,
          Producto producto}) =>
      Ticket(
          fecha: fecha ?? this.fecha,
          id: id ?? this.id,
          importe: importe ?? this.importe,
          unidades: unidades ?? this.unidades,
          usuario: usuario ?? this.usuario,
          producto: producto ?? this.producto);

  factory Ticket.fromRawJson(String str) => Ticket.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        fecha: json["fecha"] == ""
            ? DateTime.parse("0000-00-00")
            : DateTime.parse(json["fecha"]),
        id: json["id"],
        importe: json["importe"],
        unidades: json["unidades"],
        usuario: Usuario.fromJson(json["usuario"]),
        producto: Producto.fromJson(json["producto"]),
      );

  Map<String, dynamic> toJson() => {
        "fecha": fecha == null ? "" : fecha.toString(),
        "id": id,
        "importe": importe,
        "unidades": unidades,
        "usuario": usuario.toJson(),
        "producto": producto.toJson()
      };
}
