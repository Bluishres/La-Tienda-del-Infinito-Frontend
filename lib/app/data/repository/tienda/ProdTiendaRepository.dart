// @dart=2.9
import 'package:shopend/app/common/logger.dart';
import 'package:shopend/app/data/provider/api.dart';
import 'package:shopend/app/data/provider/api_service.dart';
import 'package:shopend/app/domain/model/ListaUsuariosDeseado.dart';
import 'package:shopend/app/domain/model/Ticket.dart';
import 'package:shopend/app/domain/model/_models.dart';

import '../../../locator.dart';
import '../_repositorys.dart';

class ProdTiendaRepository implements TiendaRepository {
  final apiService = locator<APIService>();

  @override
  Future<Ticket> Comprar(
      {String fecha,
      double importe,
      int unidades,
      int id_usuario,
      int id_producto}) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.requestPostwithParams(Endpoint.comprar, false,
          fecha: fecha,
          importe: importe,
          unidades: unidades,
          id_usuario: id_usuario,
          id_producto: id_producto);

      return Ticket.fromJson(data);
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<ListaUsuariosDeseado> addFavorito(
      {int id_usuario, int id_producto}) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.requestPostwithParams(
          Endpoint.addFavorito, true,
          id_usuario: id_usuario, id_producto: id_producto);

      return ListaUsuariosDeseado.fromJson(data);
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<List<ListaUsuariosDeseado>> getAllFavoritos() {
    // TODO: implement getAllFavoritos
    throw UnimplementedError();
  }

  @override
  Future<List<Ticket>> getAllTickets() {
    // TODO: implement getAllTickets
    throw UnimplementedError();
  }

  @override
  Future<List<ListaUsuariosDeseado>> getAllfavoritossByUser(
      {int id_user}) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var data =
          await apiService.requestGetID(Endpoint.addFavorito,false, id: id_user);

      var lista = (data as List).map((item) {
        try {
          return ListaUsuariosDeseado.fromJson(item);
        } catch (_) {
          logger.e(_);
          return ListaUsuariosDeseado();
        }
      }).toList();

      var validItems = lista.where((item) => item.id != null).toList();

      return validItems;
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<List<Ticket>> getAllticketsByUser({int id_user}) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.requestGetID(Endpoint.comprar,false, id: id_user);

      var lista = (data as List).map((item) {
        try {
          return Ticket.fromJson(item);
        } catch (_) {
          logger.e(_);
          return Ticket();
        }
      }).toList();

      var validItems = lista.where((item) => item.id != null).toList();

      return validItems;
    } on Exception catch (ex, s) {
      throw ex;
    }
  }
}
