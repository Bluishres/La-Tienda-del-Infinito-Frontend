import 'dart:convert';
import '_models.dart';

class Usuario {
  Usuario({
    this.admin,
    this.apellidos,
    this.direccion,
    this.email,
    this.fechaNacimiento,
    this.fotoPerfil,
    this.hilos,
    this.id,
    this.listaDeseados,
    this.mensajes,
    this.nacionalidad,
    this.nick,
    this.nombre,
    this.password,
    this.tickets,
  });

  final bool admin;
  final String apellidos;
  final String direccion;
  final String email;
  final DateTime fechaNacimiento;
  final String fotoPerfil;
  final List<Hilo> hilos;
  final int id;
  final List<dynamic> listaDeseados;
  final List<Mensaje> mensajes;
  final String nacionalidad;
  final String nick;
  final String nombre;
  final String password;
  List<dynamic> tickets;

  Usuario copyWith({
    bool admin,
    String apellidos,
    String direccion,
    String email,
    DateTime fechaNacimiento,
    String fotoPerfil,
    List<Hilo> hilos,
    int id,
    List<dynamic> listaDeseados,
    List<Mensaje> mensajes,
    String nacionalidad,
    String nick,
    String nombre,
    String password,
    List<dynamic> tickets,
  }) =>
      Usuario(
        admin: admin ?? this.admin,
        apellidos: apellidos ?? this.apellidos,
        direccion: direccion ?? this.direccion,
        email: email ?? this.email,
        fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
        fotoPerfil: fotoPerfil ?? this.fotoPerfil,
        hilos: hilos ?? this.hilos,
        id: id ?? this.id,
        listaDeseados: listaDeseados ?? this.listaDeseados,
        mensajes: mensajes ?? this.mensajes,
        nacionalidad: nacionalidad ?? this.nacionalidad,
        nick: nick ?? this.nick,
        nombre: nombre ?? this.nombre,
        password: password ?? this.password,
        tickets: tickets ?? this.tickets,
      );

  factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        admin: json["admin"],
        apellidos: json["apellidos"],
        direccion: json["direccion"],
        email: json["email"],
        fechaNacimiento: DateTime.parse(json["fecha_Nacimiento"]),
        fotoPerfil: json["foto_Perfil"],
        hilos: List<Hilo>.from(json["hilos"].map((x) => Hilo.fromJson(x))),
        id: json["id"],
        listaDeseados: List<dynamic>.from(json["lista_deseados"].map((x) => x)),
        mensajes: List<Mensaje>.from(
            json["mensajes"].map((x) => Mensaje.fromJson(x))),
        nacionalidad: json["nacionalidad"],
        nick: json["nick"],
        nombre: json["nombre"],
        password: json["password"],
        tickets: List<dynamic>.from(json["tickets"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "admin": admin,
        "apellidos": apellidos,
        "direccion": direccion,
        "email": email,
        "fecha_Nacimiento": fechaNacimiento.toIso8601String(),
        "foto_Perfil": fotoPerfil,
        "hilos": List<dynamic>.from(hilos.map((x) => x.toJson())),
        "id": id,
        "lista_deseados": List<dynamic>.from(listaDeseados.map((x) => x)),
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
        "nacionalidad": nacionalidad,
        "nick": nick,
        "nombre": nombre,
        "password": password,
        "tickets": List<dynamic>.from(tickets.map((x) => x)),
      };

  factory Usuario.createDemo() {
    return Usuario(
        admin: false,
        apellidos: "Fernandez",
        direccion: "Calle Tetuan",
        email: "Prueba@hotmail.com",
        fechaNacimiento: DateTime.now(),
        fotoPerfil: "https://fondosmil.com/fondo/4347.jpg",
        id: 99999,
        nacionalidad: "Española",
        nick: "Bl",
        nombre: "Manuel",
        password: "123456");
  }
}
