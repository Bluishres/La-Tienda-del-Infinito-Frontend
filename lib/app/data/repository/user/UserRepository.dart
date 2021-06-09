// @dart=2.9
import 'package:flutter/foundation.dart';
import 'package:shopend/app/domain/model/_models.dart';

abstract class UserRepository {
  /// Registro usuario
  Future<Usuario> postUser({Usuario USER});

  /// Consultar usuarios
  Future<List<Usuario>> getAllUser();

  /// Consultar Perfil usuario por Email
  Future<Usuario> getUserByEmail({String email});

  /// Consultar Perfil usuario por Nick
  Future<Usuario> getUserByNick({String nick});

  /// Modificar usuario
  Future<Usuario> putUsuario({Usuario userModel});

  /// Eliminar usuario
  Future<void> deleteUsuario({int id});
}
