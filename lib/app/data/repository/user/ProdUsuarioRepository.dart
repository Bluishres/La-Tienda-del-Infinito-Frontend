// @dart=2.9

import 'package:shopend/app/common/logger.dart';
import 'package:shopend/app/data/provider/api.dart';
import 'package:shopend/app/data/provider/api_service.dart';
import 'package:shopend/app/domain/model/Usuario.dart';

import '../../../locator.dart';
import 'UserRepository.dart';

class ProdUsuarioRepository implements UserRepository {
  final apiService = locator<APIService>();

  /// Arreglar el postUser
  @override
  Future<Usuario> postUser({Usuario USER}) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.requestPost(Endpoint.user_post, USER);

      return Usuario.fromJson(data);
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<List<Usuario>> getAllUser() async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.callGetMasterPrueba(Endpoint.user_getAll);

      //Procesar
      var lista = (data as List).map((item) {
        try {
          return Usuario.fromJson(item);
        } catch (_) {
          logger.e(_);
          return Usuario();
        }
      }).toList();

      var validItems = lista.where((item) => item.id != null).toList();

      return validItems;
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<Usuario> getUserByEmail({String email}) async {
    try {
      var data = await apiService.callGetMasterPrueba(Endpoint.user_getByEmail,
          id: email);

      //Procesar
      try {
        return Usuario.fromJson(data);
      } catch (_) {
        logger.e(_);
        return Usuario();
      }
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<Usuario> getUserByNick({String nick}) async {
    try {
      var data = await apiService.callGetMasterPrueba(Endpoint.user_getByNick,
          id: nick);

      //Procesar
      try {
        return Usuario.fromJson(data);
      } catch (_) {
        logger.e(_);
        return Usuario();
      }
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<bool> deleteUsuario({int id}) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.requestDelete(Endpoint.user_delete,
          id: id.toString());
      bool b = data.toString().toLowerCase() == 'true';
      return b;
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<Usuario> putUsuario({Usuario userModel}) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.requestPut(Endpoint.user_put, userModel);

      return Usuario.fromJson(data);
    } on Exception catch (ex, s) {
      throw ex;
    }
  }
}
