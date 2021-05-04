
class Hilo {

//ATRIBUTOS
final int id;
final int Id_Creador;
final DateTime Fecha_Creacion;
final int Id_Historial;

  //CONSTRUCTOR
  Hilo._(
  {this.id,
      this.Id_Creador,
      this.Fecha_Creacion,
      this.Id_Historial,})
      : super();

  //MAPEADOR A OBJETO
  factory Hilo.fromJson(Map<String, dynamic> json) => Hilo._(
    id: json["id"],
    Id_Creador: json["Id_Creador"],
    Fecha_Creacion: json["Fecha_Creacion"],
    Id_Historial: json["Id_Historial"],
  );

  //MAPEADOR A JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "Id_Creador": Id_Creador,
    "Fecha_Creacion": Fecha_Creacion,
    "Id_Historial": Id_Historial,
  };


  @override
  // TODO: implement props
  List<Object> get props => [
    id,
    Id_Creador,
    Fecha_Creacion,
    Id_Historial,
  ];


}