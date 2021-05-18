import 'package:flutter/foundation.dart';
import 'package:shopend/app/domain/model/_models.dart';

abstract class PostRepository {

  Future<List<PostModel>> getAll();
  Future<PostModel> get({int id});
  Future<void> delete({int id});

}

