import 'package:flutter/foundation.dart';
import 'package:shopend/app/domain/model/_models.dart';

abstract class UserRepository {
  /// Registro usuario
  Future<Usuario> postUsuario();

  /// Consultar usuarios
  Future<List<Usuario>> getAllUsuarios();

  /// Consultar Perfil usuario
  Future<Usuario> getUsuario({int id});

  /// Modificar usuario
  Future<Usuario> putUsuario({Usuario userModel});

  /// Eliminar usuario
  Future<void> deleteUsuario({int id});
}
