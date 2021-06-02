import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shopend/app/common/logger.dart';
import 'package:shopend/app/data/provider/api.dart';
import 'package:shopend/app/data/provider/api_service.dart';
import 'package:shopend/app/domain/model/_models.dart';

import '../../../locator.dart';
import 'ProductRepository.dart';

class MockProductoRepository implements ProductRepository {

  final apiService = locator<APIService>();
  /// Arreglar el postProduct
  @override
  Future<Producto> postProduct({int id}) async {
    await Future.delayed(Duration(seconds: 2));
    final jsondata = await rootBundle.loadString('assets/mock_data/productos.json');

    var list = jsonDecode(jsondata) as List;

    var lista = list.map((item) {
      return Producto.fromJson(item);
    }).toList();

    return lista.firstWhere((post) => post.id == id);
  }

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
  Future<Producto> getProduct({int id}) async {
    await Future.delayed(Duration(seconds: 2));
    final jsondata = await rootBundle.loadString('assets/mock_data/productos.json');

    var list = jsonDecode(jsondata) as List;

    var lista = list.map((item) {
      return Producto.fromJson(item);
    }).toList();

    return lista.firstWhere((post) => post.id == id);
  }

  @override
  Future<void> deleteProduct({int id}) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Producto> putProduct({Producto productModel}) {
    // TODO: implement putProduct
    throw UnimplementedError();
  }
}
