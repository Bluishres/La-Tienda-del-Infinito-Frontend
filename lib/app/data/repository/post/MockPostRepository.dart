// @dart=2.9
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shopend/app/data/repository/post/PostRepository.dart';
import 'package:shopend/app/domain/model/post_model.dart';

class MockPostRepository implements PostRepository {

  @override
  Future<List<PostModel>> getAll() async {

    await Future.delayed(Duration(seconds: 2));
    final jsondata = await rootBundle.loadString('assets/mock_data/posts.json');

    var list = jsonDecode(jsondata) as List;

    var lista = list.map((item) {
      return PostModel.fromJson(item);
    }).toList();

    return lista;
  }

  @override
  Future<void> delete({int id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<PostModel> get({int id}) async {
    await Future.delayed(Duration(seconds: 2));
    final jsondata = await rootBundle.loadString('assets/mock_data/posts.json');

    var list = jsonDecode(jsondata) as List;

    var lista = list.map((item) {
      return PostModel.fromJson(item);
    }).toList();

    return lista.firstWhere((post) => post.id==id);
  }

}