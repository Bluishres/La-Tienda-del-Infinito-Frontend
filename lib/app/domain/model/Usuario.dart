// @dart=2.9
import 'dart:convert';

import 'package:shopend/app/domain/commands/_commands.dart';

class Usuario extends CommandBase {
  Usuario(
      {this.admin,
      this.apellidos,
      this.direccion,
      this.email,
      this.fechaNacimiento,
      this.fotoPerfil,
      this.id,
      this.nacionalidad,
      this.nick,
      this.nombre,
      this.password});

  final bool admin;
  final String apellidos;
  final String direccion;
  final String email;
  final DateTime fechaNacimiento;
  final String fotoPerfil;
  final int id;
  final String nacionalidad;
  final String nick;
  final String nombre;
  final String password;

  Usuario copyWith({
    bool admin,
    String apellidos,
    String direccion,
    String email,
    DateTime fechaNacimiento,
    String fotoPerfil,
    int id,
    String nacionalidad,
    String nick,
    String nombre,
    String password,
  }) =>
      Usuario(
        admin: admin ?? this.admin,
        apellidos: apellidos ?? this.apellidos,
        direccion: direccion ?? this.direccion,
        email: email ?? this.email,
        fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
        fotoPerfil: fotoPerfil ?? this.fotoPerfil,
        id: id ?? this.id,
        nacionalidad: nacionalidad ?? this.nacionalidad,
        nick: nick ?? this.nick,
        nombre: nombre ?? this.nombre,
        password: password ?? this.password,
      );

  factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      admin: json["admin"],
      apellidos: json["apellidos"],
      direccion: json["direccion"],
      email: json["email"],
      fechaNacimiento: json["fecha_Nacimiento"] == ""
          ? DateTime.parse("0000-00-00")
          : DateTime.parse(json["fecha_Nacimiento"]),
      fotoPerfil: json["foto_Perfil"],
      id: json["id"],
      nacionalidad: json["nacionalidad"],
      nick: json["nick"],
      nombre: json["nombre"],
      password: json["password"]);

  @override
  Map<String, dynamic> toJson() => {
        "admin": admin,
        "apellidos": apellidos == null ? "" : apellidos,
        "direccion": direccion == null ? "" : direccion,
        "email": email,
        "fecha_Nacimiento":
            fechaNacimiento == null ? "" : fechaNacimiento.toString(),
        "foto_Perfil": fotoPerfil == null ? "" : fotoPerfil,
        "id": id == null ? 0 : id,
        "nacionalidad": nacionalidad == null ? "" : nacionalidad,
        "nick": nick,
        "nombre": nombre == null ? "" : nombre,
        "password": password
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
