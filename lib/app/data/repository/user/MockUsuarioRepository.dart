// @dart=2.9

import 'package:shopend/app/common/logger.dart';
import 'package:shopend/app/data/provider/api.dart';
import 'package:shopend/app/data/provider/api_service.dart';
import 'package:shopend/app/domain/model/Usuario.dart';

import '../../../locator.dart';
import 'UserRepository.dart';

class MockUsuarioRepository implements UserRepository {
  final apiService = locator<APIService>();

  /// Arreglar el postUser
/*  @override
  Future<Usuario> postUser({int id}) async {
    await Future.delayed(Duration(seconds: 2));
    final jsondata = await rootBundle.loadString('assets/mock_data/user.json');

    var list = jsonDecode(jsondata) as List;

    var lista = list.map((item) {
      return Usuario.fromJson(item);
    }).toList();

    return lista.firstWhere((post) => post.id == id);
  }*/

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
/*    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.callGetMasterPrueba(Endpoint.user_getByEmail, id: email);
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
    }*/
  }

  @override
  Future<Usuario> getUserByNick({String nick}) async {
/*    await Future.delayed(Duration(seconds: 2));
    final jsondata = await rootBundle.loadString('assets/mock_data/user.json');

    var list = jsonDecode(jsondata) as List;

    var lista = list.map((item) {
      return Usuario.fromJson(item);
    }).toList();

    return lista.firstWhere((post) => post.id == id);*/
  }

  @override
  Future<void> deleteUsuario({int id}) {
    // TODO: implement deleteUsuario
    throw UnimplementedError();
  }

  @override
  Future<Usuario> putUsuario({Usuario userModel}) {
    // TODO: implement putUsuario
    throw UnimplementedError();
  }

  @override
  Future<Usuario> postUser({Usuario USER}) {
    // TODO: implement postUser
    throw UnimplementedError();
  }
}
