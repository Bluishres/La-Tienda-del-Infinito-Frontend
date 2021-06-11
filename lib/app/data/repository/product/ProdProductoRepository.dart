// @dart=2.9

import 'package:shopend/app/common/logger.dart';
import 'package:shopend/app/data/provider/api.dart';
import 'package:shopend/app/data/provider/api_service.dart';
import 'package:shopend/app/domain/model/Producto.dart';

import '../../../locator.dart';
import '../_repositorys.dart';

class ProdProductoRepository implements ProductRepository {
  final apiService = locator<APIService>();

  @override
  Future<List<Producto>> getAllProduct() async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.callGetMasterPrueba(Endpoint.product_getAll);

      //Procesar
      var lista = (data as List).map((item) {
        try {
          return Producto.fromJson(item);
        } catch (_) {
          logger.e(_);
          return Producto();
        }
      }).toList();

      var validItems = lista.where((item) => item.id != null).toList();

      return validItems;
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<Producto> postProduct({Producto producto}) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.requestPost(Endpoint.product_post, producto);

      return Producto.fromJson(data);
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<Producto> putProduct({Producto producto}) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.requestPut(Endpoint.product_put, producto);

      return Producto.fromJson(data);
    } on Exception catch (ex, s) {
      throw ex;
    }
  }

  @override
  Future<void> deleteProduct({int id}) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var data = await apiService.requestDelete(Endpoint.product_delete,
          id: id.toString());
      bool b = data.toString().toLowerCase() == 'true';
      return b;
    } on Exception catch (ex, s) {
      throw ex;
    }
  }
}
