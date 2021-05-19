import 'package:flutter/foundation.dart';
import 'package:shopend/app/domain/model/_models.dart';

abstract class UserRepository {
  /// Registro usuario
  Future<UserModel> postUser();

  /// Consultar usuarios
  Future<List<UserModel>> getAllUser();

  /// Consultar Perfil usuario
  Future<UserModel> getUser({int id});

  /// Modificar usuario
  Future<UserModel> putUser({UserModel userModel});

  /// Eliminar usuario
  Future<void> deleteUser({int id});
}
