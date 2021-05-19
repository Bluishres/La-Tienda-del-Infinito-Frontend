import 'dart:convert';

import 'package:flutter/cupertino.dart';

class UserModel {
  UserModel({
    this.admin,
    this.apellidos,
    this.direccion,
    this.email,
    this.fechaNacimiento,
    this.fotoPerfil,
    this.id,
    this.nacionalidad,
    @required this.nick,
    this.nombre,
    this.password,
  });

  bool admin;
  String apellidos;
  String direccion;
  String email;
  DateTime fechaNacimiento;
  String fotoPerfil;
  int id;
  String nacionalidad;
  String nick;
  String nombre;
  String password;

  UserModel copyWith({
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
      UserModel(
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

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    admin: json["admin"],
    apellidos: json["apellidos"],
    direccion: json["direccion"],
    email: json["email"],
    fechaNacimiento: DateTime.parse(json["fecha_Nacimiento"]),
    fotoPerfil: json["foto_Perfil"],
    id: json["id"],
    nacionalidad: json["nacionalidad"],
    nick: json["nick"],
    nombre: json["nombre"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "admin": admin,
    "apellidos": apellidos,
    "direccion": direccion,
    "email": email,
    "fecha_Nacimiento": fechaNacimiento.toIso8601String(),
    "foto_Perfil": fotoPerfil,
    "id": id,
    "nacionalidad": nacionalidad,
    "nick": nick,
    "nombre": nombre,
    "password": password,
  };
  factory UserModel.createDemo() {
    return UserModel(
      id: 99999,
      nick: "manuelguz",
      password: '123456',
      email: 'personal@gmail.com',
      nombre: "Manuel",
      apellidos: "Guzman",
      direccion: "C/ Republica argentina, 25",
      fechaNacimiento: DateTime.now().subtract(Duration(days: 5000)),
      admin: true,
      fotoPerfil: 'https://url/profile_photo_23434.png',
    );
  }
}
