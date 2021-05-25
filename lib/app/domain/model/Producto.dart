import 'dart:convert';
import '_models.dart';

class Producto {
  Producto({
    this.descripcion,
    this.fechaCreacion,
    this.id,
    this.listaUsuariosDeseados,
    this.nombre,
    this.precio,
    this.stockDisponible,
    this.tickets,
  });

  final String descripcion;
  final DateTime fechaCreacion;
  final int id;
  final List<ListaUsuariosDeseado> listaUsuariosDeseados;
  final String nombre;
  final String precio;
  final int stockDisponible;
  final List<Ticket> tickets;

  Producto copyWith({
    String descripcion,
    DateTime fechaCreacion,
    int id,
    List<ListaUsuariosDeseado> listaUsuariosDeseados,
    String nombre,
    String precio,
    int stockDisponible,
    List<Ticket> tickets,
  }) =>
      Producto(
        descripcion: descripcion ?? this.descripcion,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        id: id ?? this.id,
        listaUsuariosDeseados: listaUsuariosDeseados ?? this.listaUsuariosDeseados,
        nombre: nombre ?? this.nombre,
        precio: precio ?? this.precio,
        stockDisponible: stockDisponible ?? this.stockDisponible,
        tickets: tickets ?? this.tickets,
      );

  factory Producto.fromRawJson(String str) => Producto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
    descripcion: json["descripcion"],
    fechaCreacion: DateTime.parse(json["fecha_creacion"]),
    id: json["id"],
    listaUsuariosDeseados: List<ListaUsuariosDeseado>.from(json["lista_usuarios_deseados"].map((x) => ListaUsuariosDeseado.fromJson(x))),
    nombre: json["nombre"],
    precio: json["precio"],
    stockDisponible: json["stock_disponible"],
    tickets: List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "descripcion": descripcion,
    "fecha_creacion": fechaCreacion.toIso8601String(),
    "id": id,
    "lista_usuarios_deseados": List<dynamic>.from(listaUsuariosDeseados.map((x) => x.toJson())),
    "nombre": nombre,
    "precio": precio,
    "stock_disponible": stockDisponible,
    "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
  };
}