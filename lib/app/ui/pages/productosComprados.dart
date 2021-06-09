// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shopend/app/app.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/data/repository/_repositorys.dart';
import 'package:shopend/app/data/repository/post/PostRepository.dart';
import 'package:shopend/app/data/repository/user/UserRepository.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/locator.dart';
import 'package:shopend/app/router.dart';
import 'package:shopend/app/ui/widgets/_widgets.dart';

import 'detalleProducto/DetalleProducto.dart';

class ProdCompradosPage extends StatefulWidget {
  final Usuario user;
  ProdCompradosPage({Key key, this.user}) : super(key: key);

  @override
  _ProdCompradosPageState createState() => _ProdCompradosPageState();
}

class _ProdCompradosPageState extends State<ProdCompradosPage> {
  List<Ticket> _tickets = null;
  Usuario _user;
  TiendaRepository _repoTicket = locator<TiendaRepository>();
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _repoTicket
        .getAllticketsByUser(id_user: _user.id)
        .then((list) => setState(() {
              _isloading = false;
              _tickets = list;
            }))
        .catchError((Object error) {
      setState(() {
        _isloading = false;
      });
      SuccessToast('Error al actualizar los productos.');
      return error;
    });

    //var _posts = await _repo.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Productos Comprados"),
      ),
      body: Container(
        child: _isloading
            ? Center(
                child: LoadingIndicator(),
              )
            : Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF61A4A6),
                Color(0xFF61A4D8),
                Color(0xFF11FAD1),
                Color(0xFF398AE5),
              ],
              stops: [0.1, 0.4, 0.7, 0.9],
            ),
          ),
        child: _tickets == null
            ? Center(
          child: Text("Error al obtener los productos"),
        )
            : _createListView(context, _tickets),),

      ),
    );
  }
}

Widget _createListView(BuildContext context, List<Ticket> products) {
  return new ListView.builder(
    itemCount: products.length,
    itemBuilder: (context, i) => new Column(
      children: <Widget>[
        new Divider(
          height: 2.0,
          thickness: 1,
        ),
        new ListTile(
            onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => DetalleProducto(
                    producto: products[i].producto,
                    getUsuarioActivo: products[i].usuario))),
            leading: Icon(Icons.post_add, color: Colors.black,),
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${products[i].producto.nombre.toString()}',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
            subtitle: Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  products[i].producto.precio,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ))
      ],
    ),
  );
}
