// @dart=2.9

import 'package:shopend/app/common/logger.dart';
import 'package:shopend/app/data/provider/api.dart';
import 'package:shopend/app/data/provider/api_service.dart';
import 'package:shopend/app/domain/model/Hilo.dart';
import 'package:shopend/app/domain/model/Mensaje.dart';

import '../../../locator.dart';
import '../_repositorys.dart';

class ProdHiloRepository implements HiloRepository {
  final apiService = locator<APIService>();

  @override
  Future<void> deleteHilo({int id}) async{
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.requestDelete(Endpoint.hilo,
          id: id.toString());
      bool b = data.toString().toLowerCase() == 'true';
      return b;
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<void> deleteMensaje({int id}) async{
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.requestDelete(Endpoint.mensaje,
          id: id.toString());
      bool b = data.toString().toLowerCase() == 'true';
      return b;
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<List<Hilo>> getAllHilos() async{
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.callGetMasterPrueba(Endpoint.hilo);

      //Procesar
      var lista = (data as List).map((item) {
        try {
          return Hilo.fromJson(item);
        } catch (_) {
          logger.e(_);
          return Hilo();
        }
      }).toList();

      var validItems = lista.where((item) => item.id != null).toList();

      return validItems;
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<Hilo> getByid({int id}) async{
    await Future.delayed(Duration(seconds: 2));
    try {
      var data =
          await apiService.requestGetID(Endpoint.hilo_getbyid,false, id: id);

      try {
        return Hilo.fromJson(data);
      } catch (_) {
        logger.e(_);
        return Hilo();
      }
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<List<Mensaje>> getMensajesByhilo({int idHilo}) async{
    await Future.delayed(Duration(seconds: 2));
    try {
      var data =
          await apiService.requestGetID(Endpoint.mensajes,true, id: idHilo);

      var lista = (data as List).map((item) {
        try {
          return Mensaje.fromJson(item);
        } catch (_) {
          return Mensaje();
        }
      }).toList();

      var validItems = lista.where((item) => item.id != null).toList();

      return validItems;
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<Hilo> postHilo({String fecha, int id_Creador, String titulo, String mensaje}) async{
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.PostHilo(Endpoint.hilo,
          fecha: fecha,
          id_Creador: id_Creador,
          mensaje: mensaje,
          titulo: titulo);

      return Hilo.fromJson(data);
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<Mensaje> postMensaje({String fecha, int id_Creador, int id_Hilo, String mensaje}) async{
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.PostMensaje(Endpoint.mensaje,
          fecha: fecha,
          id_Creador: id_Creador,
          mensaje: mensaje,
          id_Hilo: id_Hilo);

      return Mensaje.fromJson(data);
    } on Exception catch (ex, s) {
      throw ex;
    }
  }


}