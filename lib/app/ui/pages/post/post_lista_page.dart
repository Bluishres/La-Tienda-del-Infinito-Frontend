import 'package:flutter/material.dart';
import 'package:shopend/app/app.dart';
import 'package:shopend/app/data/repository/post/PostRepository.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/locator.dart';
import 'package:shopend/app/router.dart';
import 'package:shopend/app/ui/widgets/_widgets.dart';

class PostListaPage extends StatefulWidget {
  PostListaPage({Key key}) : super(key: key);

  @override
  _PostListaPageState createState() => _PostListaPageState();
}

class _PostListaPageState extends State<PostListaPage> {
  List<PostModel> _posts = null;
  PostRepository _repo = locator<PostRepository>();
  bool _isloading = true;

  @override
  void initState() {
    super.initState();

    _repo.getAll().then((list) => setState(() {
          _isloading = false;
          _posts = list;
        }));

    //var _posts = await _repo.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Posts"),
      ),
      body: Container(
        child: _isloading
            ? Center(
                child: LoadingIndicator(),
              )
            : _posts == null
                ? Center(
                    child: Text("Errror al obtener los posts"),
                  )
                : _createListView(context, _posts),
      ),
    );
  }
}

Widget _createListView(BuildContext context, List<PostModel> posts) {
  return new ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, i) => new Column(
      children: <Widget>[
        new Divider(
          height: 2.0,
          thickness: 1,
        ),
        new ListTile(
          onTap: () => Navigation.page("/posts/detalle", context, params: [posts[i]]),
          leading: Icon(Icons.post_add),
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                posts[i].id.toString(),
                style: new TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF404040)),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${posts[i].userId.toString()}',
                    style: new TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF404040)),
                  ),
                ),
              )
            ],
          ),
          subtitle: Text(
            posts[i].title,
            style: new TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF404040)),
          ),
        ),
      ],
    ),
  );
}
