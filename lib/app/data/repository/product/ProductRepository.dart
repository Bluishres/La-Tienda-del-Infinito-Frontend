// @dart=2.9
import 'package:shopend/app/domain/model/_models.dart';

abstract class ProductRepository {
  /// Registro producto
  Future<Producto> postProduct({Producto producto});

  /// Consultar productos
  Future<List<Producto>> getAllProduct();

/*  /// Consultar producto solo uno
  Future<Producto> getProduct({int id});*/

  /// Modificar producto
  Future<Producto> putProduct({Producto producto});

  /// Eliminar producto
  Future<void> deleteProduct({int id});
}
