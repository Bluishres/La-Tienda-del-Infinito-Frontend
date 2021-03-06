// @dart=2.9
import 'dart:convert';

import 'package:shopend/app/domain/commands/_commands.dart';

class Producto extends CommandBase {
  Producto(
      {this.descripcion,
      this.fechaCreacion,
      this.id,
      this.nombre,
      this.precio,
      this.stockDisponible,
      this.imagen});

  final String descripcion;
  final DateTime fechaCreacion;
  final int id;
  final String nombre;
  final String precio;
  final int stockDisponible;
  final String imagen;

  Producto copyWith(
          {String descripcion,
          DateTime fechaCreacion,
          int id,
          String nombre,
          String precio,
          int stockDisponible,
          String imagen}) =>
      Producto(
          descripcion: descripcion ?? this.descripcion,
          fechaCreacion: fechaCreacion ?? this.fechaCreacion,
          id: id ?? this.id,
          nombre: nombre ?? this.nombre,
          precio: precio ?? this.precio,
          stockDisponible: stockDisponible ?? this.stockDisponible,
          imagen: imagen ?? this.imagen);

  factory Producto.fromRawJson(String str) =>
      Producto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
      descripcion: json["descripcion"],
      fechaCreacion: json["fecha_creacion"] == ""
          ? DateTime.parse(json["0000-00-00"])
          : DateTime.parse(json["fecha_creacion"]),
      id: json["id"],
      nombre: json["nombre"],
      precio: json["precio"],
      stockDisponible: json["stock_disponible"],
      imagen: json["imagen"]);

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "fecha_creacion": fechaCreacion == null ? "" : fechaCreacion.toString(),
        "id": id,
        "nombre": nombre,
        "precio": precio,
        "stock_disponible": stockDisponible,
        "imagen": imagen
      };

  List<Producto> createSampleList() {
    List _heroType = <Producto>[];
    return _heroType
      ..add(Producto(
          descripcion:
              'Antes de ser elevada por el cine y por innumerables series de novelas a uno de los puestos privilegiados del imaginario actual, la leyenda del vampiro alcanz?? un gran reconocimiento en este cl??sico de la literatura de terror. En ella se sintetizan magistralmente las pulsiones m??s profundas del ser humano: la vida y la muerte, la sexualidad y el bien y el mal.',
          fechaCreacion: DateTime.now(),
          imagen:
              'https://www.planetadelibros.com/usuaris/libros/fotos/49/m_libros/48640_1_Dracula.jpg',
          nombre: 'Libro Dr??cula -  Bram Stoker',
          precio: '10.90',
          stockDisponible: 10,
          id: 0))
      ..add(Producto(
          descripcion:
              'Un malvado emperador rob??tico se ha lanzado a la conquista de mundos interdimensionales, y el universo de Ratchet y Clank es su pr??ximo objetivo. Desempolva el espectacular armamento de este d??o din??mico y lucha para impedir un desastre dimensional.',
          fechaCreacion: DateTime.now(),
          imagen:
              'https://image.api.playstation.com/vulcan/ap/rnd/202101/2921/CrGbGyUFNdkZKbg9DM2qPTE1.jpg',
          nombre: 'Videojuego Ratchet and Clank: Rift Apart PS5',
          precio: '79.99',
          stockDisponible: 15,
          id: 1))
      ..add(Producto(
          descripcion:
              'Un malvado emperador rob??tico se ha lanzado a la conquista de mundos interdimensionales, y el universo de Ratchet y Clank es su pr??ximo objetivo. Desempolva el espectacular armamento de este d??o din??mico y lucha para impedir un desastre dimensional.',
          fechaCreacion: DateTime.now(),
          imagen:
              'https://image.api.playstation.com/vulcan/ap/rnd/202101/2921/CrGbGyUFNdkZKbg9DM2qPTE1.jpg',
          nombre: 'Videojuego Ratchet and Clank: Rift Apartww PS5',
          precio: '79.99',
          stockDisponible: 15,
          id: 1))
      ..add(Producto(
          descripcion:
              'Un malvado emperador rob??tico se ha lanzado a la conquista de mundos interdimensionales, y el universo de Ratchet y Clank es su pr??ximo objetivo. Desempolva el espectacular armamento de este d??o din??mico y lucha para impedir un desastre dimensional.',
          fechaCreacion: DateTime.now(),
          imagen:
              'https://image.api.playstation.com/vulcan/ap/rnd/202101/2921/CrGbGyUFNdkZKbg9DM2qPTE1.jpg',
          nombre: 'Videojuego Ratchet and Clank: Rifta Apart PS5',
          precio: '79.99',
          stockDisponible: 15,
          id: 1))
      ..add(Producto(
          descripcion:
              'Un malvado emperador rob??tico se ha lanzado a la conquista de mundos interdimensionales, y el universo de Ratchet y Clank es su pr??ximo objetivo. Desempolva el espectacular armamento de este d??o din??mico y lucha para impedir un desastre dimensional.',
          fechaCreacion: DateTime.now(),
          imagen:
              'https://image.api.playstation.com/vulcan/ap/rnd/202101/2921/CrGbGyUFNdkZKbg9DM2qPTE1.jpg',
          nombre: 'Videojuego Ratchet and Cdlank: Rift Apart PS5',
          precio: '79.99',
          stockDisponible: 15,
          id: 1))
      ..add(Producto(
          descripcion:
              'Un malvado emperador rob??tico se ha lanzado a la conquista de mundos interdimensionales, y el universo de Ratchet y Clank es su pr??ximo objetivo. Desempolva el espectacular armamento de este d??o din??mico y lucha para impedir un desastre dimensional.',
          fechaCreacion: DateTime.now(),
          imagen:
              'https://image.api.playstation.com/vulcan/ap/rnd/202101/2921/CrGbGyUFNdkZKbg9DM2qPTE1.jpg',
          nombre: 'Videojuego Ratchet afnd Clank: Rift Apart PS5',
          precio: '79.99',
          stockDisponible: 15,
          id: 1));
  }
}
