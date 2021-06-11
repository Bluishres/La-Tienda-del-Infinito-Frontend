// @dart=2.9

import 'package:shopend/app/data/provider/api_service.dart';
import 'package:shopend/app/domain/model/_models.dart';

import '../../../locator.dart';
import 'ProductRepository.dart';

class MockProductoRepository implements ProductRepository {
  final apiService = locator<APIService>();

  @override
  Future<void> deleteProduct({int id}) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<Producto>> getAllProduct() {
    // TODO: implement getAllProduct
    throw UnimplementedError();
  }

  @override
  Future<Producto> getProduct({int id}) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<Producto> postProduct({Producto producto}) {
    // TODO: implement postProduct
    throw UnimplementedError();
  }

  @override
  Future<Producto> putProduct({Producto producto}) {
    // TODO: implement putProduct
    throw UnimplementedError();
  }
}
