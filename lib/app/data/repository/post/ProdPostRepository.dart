// @dart=2.9

import 'package:shopend/app/app_state.dart';
import 'package:shopend/app/common/logger.dart';
import 'package:shopend/app/data/provider/api.dart';
import 'package:shopend/app/data/provider/api_service.dart';
import 'package:shopend/app/data/repository/post/PostRepository.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/locator.dart';

class ProdPostRepository implements PostRepository {
  final apiService = locator<APIService>();
  final appState = locator<AppState>();
  final maxIntervalRefreshData = Duration(seconds: 10);
  final maxIntervalCacheData = Duration(days: 1);

  @override
  Future<List<PostModel>> getAll() async {
    try {
      var data = await apiService.callGetMasterPrueba(Endpoint.posts);

      //Procesar
      var lista = (data as List).map((item) {
        try {
          return PostModel.fromJson(item);
        } catch (_) {
          logger.e(_);
          return PostModel();
        }
      }).toList();

      var validItems = lista.where((item) => item.id != null).toList();

      return validItems;
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<void> delete({int id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<PostModel> get({int id}) async {
    try {
      var data = await apiService.callGetMasterPrueba(Endpoint.posts,
          id: id.toString());

      //Procesar
      try {
        return PostModel.fromJson(data);
      } catch (_) {
        logger.e(_);
        return PostModel();
      }
    } on Exception catch (ex, s) {
      throw ex;
    }
  }
}
