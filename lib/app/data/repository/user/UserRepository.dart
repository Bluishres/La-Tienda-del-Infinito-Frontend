import 'package:flutter/foundation.dart';
import 'package:shopend/app/domain/model/_models.dart';

abstract class UserRepository {
  /// Registro usuario
  Future<Usuario> postUser();

  /// Consultar usuarios
  Future<List<Usuario>> getAllUser();

  /// Consultar Perfil usuario
  Future<Usuario> getUser({int id});

  /// Modificar usuario
  Future<Usuario> putUsuario({Usuario userModel});

  /// Eliminar usuario
  Future<void> deleteUsuario({int id});
}
