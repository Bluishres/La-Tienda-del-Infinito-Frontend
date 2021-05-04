
class Mensaje {

//ATRIBUTOS
final int id;
final int Id_Autor;
final DateTime Fecha_Creacion;

  //CONSTRUCTOR
  Mensaje._(
  {this.id,
      this.Id_Autor,
      this.Fecha_Creacion,})
      : super();

  //MAPEADOR A OBJETO
  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje._(
    id: json["id"],
    Id_Autor: json["Id_Autor"],
    Fecha_Creacion: json["Fecha_Creacion"],
  );

  //MAPEADOR A JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "Id_Autor": Id_Autor,
    "Fecha_Creacion": Fecha_Creacion,
  };


  @override
  // TODO: implement props
  List<Object> get props => [
    id,
    Id_Autor,
    Fecha_Creacion,
  ];


}