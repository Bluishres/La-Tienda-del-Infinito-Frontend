import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shopend/app/domain/model/UserModel.dart';
import 'package:shopend/app/domain/model/post_model.dart';

import 'UserRepository.dart';

class MockPostRepository implements UserRepository {
  /// Arreglar el postUser
  @override
  Future<UserModel> postUser({int id}) async {
    await Future.delayed(Duration(seconds: 2));
    final jsondata = await rootBundle.loadString('assets/mock_data/user.json');

    var list = jsonDecode(jsondata) as List;

    var lista = list.map((item) {
      return UserModel.fromJson(item);
    }).toList();

    return lista.firstWhere((post) => post.id == id);
  }

  @override
  Future<List<UserModel>> getAllUser() async {
    await Future.delayed(Duration(seconds: 2));
    final jsondata = await rootBundle.loadString('assets/mock_data/user.json');

    var list = jsonDecode(jsondata) as List;

    var lista = list.map((item) {
      return UserModel.fromJson(item);
    }).toList();

    return lista;
  }

  @override
  Future<UserModel> getUser({int id}) async {
    await Future.delayed(Duration(seconds: 2));
    final jsondata = await rootBundle.loadString('assets/mock_data/user.json');

    var list = jsonDecode(jsondata) as List;

    var lista = list.map((item) {
      return UserModel.fromJson(item);
    }).toList();

    return lista.firstWhere((post) => post.id == id);
  }

  @override
  Future<UserModel> putUser({UserModel userModel}) {
    // TODO: implement putUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser({int id}) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
