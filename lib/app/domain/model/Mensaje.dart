
class Mensaje {

//ATRIBUTOS
final int id;
final int idAutor;
final DateTime fechaCreacion;

  //CONSTRUCTOR
  Mensaje._(
  {this.id,
      this.idAutor,
      this.fechaCreacion,})
      : super();

  //MAPEADOR A OBJETO
  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje._(
    id: json["id"],
    idAutor: json["idAutor"],
    fechaCreacion: json["fechaCreacion"],
  );

  //MAPEADOR A JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "idAutor": idAutor,
    "fechaCreacion": fechaCreacion,
  };


  List<Object> get props => [
    id,
    idAutor,
    fechaCreacion,
  ];


}