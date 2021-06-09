// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shopend/app/domain/model/_models.dart';

class PostDetail extends StatefulWidget {

  final PostModel model;

  const PostDetail({Key key, this.model}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.model.id}'),
      ),
      body: Container(
        child: Center(
          child: Text(widget.model.title),
        ),
      ),
    );
  }
}
