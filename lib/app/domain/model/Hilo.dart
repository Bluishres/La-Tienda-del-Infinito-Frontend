
class Hilo {

//ATRIBUTOS
final int id;
final int idCreador;
final DateTime fechaCreacion;
final int idHistorial;

  //CONSTRUCTOR
  Hilo._(
  {this.id,
      this.idCreador,
      this.fechaCreacion,
      this.idHistorial,})
      : super();

  //MAPEADOR A OBJETO
  factory Hilo.fromJson(Map<String, dynamic> json) => Hilo._(
    id: json["id"],
    idCreador: json["idCreador"],
    fechaCreacion: json["fechaCreacion"],
    idHistorial: json["idHistorial"],
  );

  //MAPEADOR A JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "idCreador": idCreador,
    "fechaCreacion": fechaCreacion,
    "idHistorial": idHistorial,
  };

  
  List<Object> get props => [
    id,
    idCreador,
    fechaCreacion,
    idHistorial,
  ];


}