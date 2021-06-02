import 'package:flutter/foundation.dart';
import 'package:shopend/app/domain/model/_models.dart';

abstract class ProductRepository {
  /// Registro producto
  Future<Producto> postProduct();

  /// Consultar productos
  Future<List<Producto>> getAllProduct();

  /// Consultar producto solo uno
  Future<Producto> getProduct({int id});

  /// Modificar producto
  Future<Producto> putProduct({Producto productModel});

  /// Eliminar producto
  Future<void> deleteProduct({int id});
}
