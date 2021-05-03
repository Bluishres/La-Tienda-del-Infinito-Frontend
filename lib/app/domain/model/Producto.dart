
import '_models.dart';
import 'package:sqflite/sqlite_api.dart';

class Producto extends ModelDb {
  //ATRIBUTOS DE LA BASE DE DATOS
static final tbl = "Producto";
static final dbId = "id";
static final dbNombre = "nombre";
static final dbDescripcion = "descripcion";
static final dbPrecio = "precio";
static final dbStock = "stock_disponible";
static final dbFechaCreacion = "fecha_creacion";
static final dbUsuarios = "id_usuarios";

//ATRIBUTOS
final int id;
final String nombre;
final String descripcion;
final Double precio;
final int stockDisponible;
final Date fechaCreacion;
//int idUsuarios;

  //CONSTRUCTOR
  Producto._(
  {this.id,
      this.nombre,
      this.descripcion,
      this.precio,
      this.stockDisponible,
      this.fechaCreacion,
      this.idUsuarios})
      : super(tbl,dbId, id.toString());

  //MAPEADOR A OBJETO
  factory Producto.fromJson(Map<String, dynamic> json) => Producto._(
    id: json["id"],
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    precio: json["precio"],
    stockDisponible: json["stockDisponible"],
    fechaCreacion: json["fechaCreacion"],
    idUsuarios: json["idUsuarios"],
  );

  //MAPEADOR A JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "descripciom": descripciom,
    "precio": precio,
    "stockDisponible": stockDisponible,
    "fechaCreacion": fechaCreacion,
    "idUsuarios": idUsuarios,
  };


  @override
  // TODO: implement props
  List<Object> get props => [
    id,
    nombre,
    descripciom,
    precio,
    stockDisponible,
    fechaCreacion,
    idUsuarios,
  ];

  //SELECT * FROM USUARIO
  static Future<List<Producto>> DbSelectAll(Database db) async {
    final result = await db.rawQuery('SELECT FROM ${Producto.tbl}');

    return result.isNotEmpty
        ? result.map((c) => Producto.fromJson(c)).toList()
        : [];
  }

}