import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shopend/app/domain/model/Usuario.dart';
import 'package:shopend/app/domain/model/post_model.dart';

import 'UserRepository.dart';

class MockUsuarioRepository implements UserRepository {
  /// Arreglar el postUser
  @override
  Future<Usuario> postUser({int id}) async {
    await Future.delayed(Duration(seconds: 2));
    final jsondata = await rootBundle.loadString('assets/mock_data/user.json');

    var list = jsonDecode(jsondata) as List;

    var lista = list.map((item) {
      return Usuario.fromJson(item);
    }).toList();

    return lista.firstWhere((post) => post.id == id);
  }

  @override
  Future<List<Usuario>> getAllUser() async {
    await Future.delayed(Duration(seconds: 2));
    final jsondata = await rootBundle.loadString('assets/mock_data/user.json');

    var list = jsonDecode(jsondata) as List;

    var lista = list.map((item) {
      return Usuario.fromJson(item);
    }).toList();

    return lista;
  }

  @override
  Future<Usuario> getUser({int id}) async {
    await Future.delayed(Duration(seconds: 2));
    final jsondata = await rootBundle.loadString('assets/mock_data/user.json');

    var list = jsonDecode(jsondata) as List;

    var lista = list.map((item) {
      return Usuario.fromJson(item);
    }).toList();

    return lista.firstWhere((post) => post.id == id);
  }

  @override
  Future<void> deleteUsuario({int id}) {
    // TODO: implement deleteUsuario
    throw UnimplementedError();
  }

  @override
  Future<List<Usuario>> getAllUsuarios() {
    // TODO: implement getAllUsuarios
    throw UnimplementedError();
  }

  @override
  Future<Usuario> getUsuario({int id}) {
    // TODO: implement getUsuario
    throw UnimplementedError();
  }

  @override
  Future<Usuario> postUsuario() {
    // TODO: implement postUsuario
    throw UnimplementedError();
  }

  @override
  Future<Usuario> putUsuario({Usuario userModel}) {
    // TODO: implement putUsuario
    throw UnimplementedError();
  }
}
