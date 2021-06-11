// @dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/data/repository/_repositorys.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/locator.dart';
import 'package:shopend/app/ui/widgets/_widgets.dart';

import '../detalleProducto/DetalleProducto.dart';

class ProdFavoritosPage extends StatefulWidget {
  final Usuario user;

  ProdFavoritosPage({Key key, this.user}) : super(key: key);

  @override
  _ProdFavoritosPageState createState() => _ProdFavoritosPageState();
}

class _ProdFavoritosPageState extends State<ProdFavoritosPage> {
  List<ListaUsuariosDeseado> _favoritos = null;
  Usuario _user;
  TiendaRepository _repoTicket = locator<TiendaRepository>();
  bool _isloading = true;

  FutureOr onGoBack(dynamic value) {
    getAllFav();
  }

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    getAllFav();

    //var _posts = await _repo.getAll();
  }

  void getAllFav() {
    _repoTicket
        .getAllfavoritossByUser(id_user: _user.id)
        .then((list) => setState(() {
      _isloading = false;
      _favoritos = list;
    }))
        .catchError((Object error) {
      setState(() {
        _isloading = false;
      });
      SuccessToast('Error al actualizar los productos.');
      return error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Productos Favoritos"),
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
                  child: _favoritos == null
                      ? Center(
                          child: Text("Error al obtener los productos"),
                        )
                      : _createListView(context, _favoritos),
                ),
        ));
  }

  Widget _createListView(
      BuildContext context, List<ListaUsuariosDeseado> favoritos) {
    return new ListView.builder(
      itemCount: favoritos.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            height: 2.0,
            thickness: 1,
          ),
          new ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalleProducto(
                          producto: favoritos[i].producto,
                          getUsuarioActivo: favoritos[i].usuario))).then((value) => onGoBack(value)),
              leading: Icon(
                Icons.post_add,
                color: Colors.black,
              ),
              title: Container(
                child:
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${favoritos[i].producto.nombre.toString()}',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
              ),
              subtitle: Container(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      favoritos[i].producto.precio + "€",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
              ),
              )
        ],
      ),
    );
  }
}


