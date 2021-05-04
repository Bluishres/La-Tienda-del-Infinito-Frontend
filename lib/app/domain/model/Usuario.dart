
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
DateTime fecha_nacimiento;
String direccion;
final bool isAdmin;
String foto_perfil;
final List<Hilo> lista_hilos;
final List<Producto> lista_deseados;
final List<Producto> historial_compra;
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
      this.fecha_nacimiento,
      this.direccion,
      this.isAdmin,
      this.foto_perfil,
      this.lista_hilos,
      this.historial_compra,
      this.lista_deseados,
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
    fecha_nacimiento: json["fecha_nacimiento"],
    direccion: json["direccion"],
    isAdmin: json["isAdmin"],
    foto_perfil: json["foto_perfil"],
    lista_hilos: json["lista_hilos"],
    historial_compra: json["historial_compra"],
    lista_deseados: json["lista_deseados"],
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
    "fecha_nacimiento": fecha_nacimiento,
    "direccion": direccion,
    "isAdmin": isAdmin,
    "foto_perfil": foto_perfil,
    "lista_hilos": lista_hilos,
    "historial_compra": historial_compra,
    "lista_deseados": lista_deseados,
    "mensajesUsuario": mensajesUsuario,
  };


  @override
  // TODO: implement props
  List<Object> get props => [
    id,
    nick,
    password,
    email,
    nombre,
    apellidos,
    nacionalidad,
    fecha_nacimiento,
    direccion,
    isAdmin,
    foto_perfil,
    lista_hilos,
    historial_compra,
    lista_deseados,
    mensajesUsuario,
  ];

}