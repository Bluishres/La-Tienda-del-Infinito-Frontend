
import 'Hilo.dart';
import 'Mensaje.dart';
import 'Producto.dart';

class Usuario {

//ATRIBUTOS
final int id;
final String nick;
final String password;
final String email;
String nombre;
String apellidos;
String nacionalidad;
DateTime fechaNacimiento;
String direccion;
final bool isAdmin;
String fotoPerfil;
final List<Hilo> listaHilos;
final List<Producto> listaDeseados;
final List<Producto> historialCompra;
final List<Mensaje> mensajesUsuario;

  //CONSTRUCTOR
  Usuario._(
  {this.id,
      this.nick,
      this.password,
      this.email,
      this.nombre,
      this.apellidos,
      this.nacionalidad,
      this.fechaNacimiento,
      this.direccion,
      this.isAdmin,
      this.fotoPerfil,
      this.listaHilos,
      this.historialCompra,
      this.listaDeseados,
      this.mensajesUsuario})
      : super();

  //MAPEADOR A OBJETO
  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario._(
    id: json["id"],
    nick: json["nick"],
    password: json["password"],
    email: json["email"],
    nombre: json["nombre"],
    apellidos: json["apellidos"],
    nacionalidad: json["nacionalidad"],
    fechaNacimiento: json["fechaNacimiento"],
    direccion: json["direccion"],
    isAdmin: json["isAdmin"],
    fotoPerfil: json["fotoPerfil"],
    //TODO:fix..
    listaHilos: json["listaHilos"],
    historialCompra: json["historialCompra"],
    listaDeseados: json["listaDeseados"],
    mensajesUsuario: json["mensajesUsuario"],
  );

  //MAPEADOR A JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "nick": nick,
    "password": password,
    "email": email,
    "nombre": nombre,
    "apellidos": apellidos,
    "nacionalidad": nacionalidad,
    "fechaNacimiento": fechaNacimiento,
    "direccion": direccion,
    "isAdmin": isAdmin,
    "fotoPerfil": fotoPerfil,
    "listaHilos": listaHilos,
    "historialCompra": historialCompra,
    "listaDeseados": listaDeseados,
    "mensajesUsuario": mensajesUsuario,
  };

factory Usuario.createDemo() {
  return Usuario._(
    id: 99999,
    nick: "manuelguz",
    password: '123456',
    email: 'personal@gmail.com',
    nombre: "Manuel",
    apellidos: "Guzman",
    direccion: "C/ Republica argentina, 25",
    fechaNacimiento: DateTime.now().subtract(Duration(days: 5000)),
    isAdmin: true,
    fotoPerfil: 'https://url/profile_photo_23434.png',
  );
}


  List<Object> get props => [
    id,
    nick,
    password,
    email,
    nombre,
    apellidos,
    nacionalidad,
    fechaNacimiento,
    direccion,
    isAdmin,
    fotoPerfil,
    listaHilos,
    historialCompra,
    listaDeseados,
    mensajesUsuario,
  ];

}