
import 'Mensaje.dart';

class Historial {

//ATRIBUTOS
final int id;
final List<Mensaje> Mensajes;
final int Id_Hilo;

  //CONSTRUCTOR
  Historial._(
  {this.id,
      this.Mensajes,
      this.Id_Hilo,})
      : super();

  //MAPEADOR A OBJETO
  factory Historial.fromJson(Map<String, dynamic> json) => Historial._(
    id: json["id"],
    Mensajes: json["Mensajes"],
    Id_Hilo: json["Id_Hilo"],
  );

  //MAPEADOR A JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "Mensajes": Mensajes,
    "Id_Hilo": Id_Hilo,
  };


  @override
  // TODO: implement props
  List<Object> get props => [
    id,
    Mensajes,
    Id_Hilo,
  ];


}