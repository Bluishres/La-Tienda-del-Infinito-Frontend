
import 'Mensaje.dart';

class Historial {

//ATRIBUTOS
final int id;
final List<Mensaje> mensajes;
final int idHilo;

  //CONSTRUCTOR
  Historial._(
  {this.id,
      this.mensajes,
      this.idHilo,})
      : super();

  //MAPEADOR A OBJETO
  factory Historial.fromJson(Map<String, dynamic> json) => Historial._(
    id: json["id"],
    mensajes: json["mensajes"],
    idHilo: json["idHilo"],
  );

  //MAPEADOR A JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "mensajes": mensajes,
    "idHilo": idHilo,
  };


  List<Object> get props => [
    id,
    mensajes,
    idHilo,
  ];


}