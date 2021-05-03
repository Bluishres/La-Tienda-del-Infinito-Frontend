
import '_models.dart';
import 'package:sqflite/sqlite_api.dart';

class Usuario extends ModelDb {
  //ATRIBUTOS DE LA BASE DE DATOS
static final tbl = "Usuario";
static final dbId = "id";
static final dbNick = "nick";
static final dbPassword = "password";
static final dbEmail = "email";
static final dbNombre = "nombre";
static final dbApellidos = "apellidos";
static final dbNacionalidad = "nacionalidad";
static final dbFecha_Nacimiento = "fecha_nacimiento";
static final dbDireccion = "direccion";
static final dbisAdmin = "isAdmin";
static final Foto_perfil = "foro_perfil";
static final Lista_foros = "lista_foros";
static final Lista_deseados = "lista_deseados";
static final Historial_Compra = "historial_compra";

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
/*final List<Foro> lista_foros;
final List<Producto> lista_deseados;
final List<Producto> historial_compra;*/

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
      this.foto_perfil})
      : super(tbl,dbId, id.toString());

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
  ];

  //SELECT * FROM USUARIO
  static Future<List<Usuario>> DbSelectAll(Database db) async {
    final result = await db.rawQuery('SELECT FROM ${Usuario.tbl}');

    return result.isNotEmpty
        ? result.map((c) => Usuario.fromJson(c)).toList()
        : [];
  }

}