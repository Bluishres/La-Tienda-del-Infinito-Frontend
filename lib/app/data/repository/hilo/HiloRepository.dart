// @dart=2.9
import 'package:shopend/app/domain/model/_models.dart';

abstract class HiloRepository {
  Future<Hilo> postHilo(
      {String fecha, int id_Creador, String titulo, String mensaje});

  Future<List<Hilo>> getAllHilos();

  Future<void> deleteHilo({int id});

  Future<Hilo> getByid({int id});

  Future<Mensaje> postMensaje({String fecha, int id_Creador,int id_Hilo, String mensaje});

  Future<void> deleteMensaje({int id});

  Future<List<Mensaje>> getMensajesByhilo({int idHilo});


}
