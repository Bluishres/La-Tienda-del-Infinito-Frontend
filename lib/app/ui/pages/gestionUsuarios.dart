// @dart=2.9
import 'dart:async';

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
import 'delmodUsuario.dart';

class GestionUsuariosPage extends StatefulWidget {
  final Usuario user;
  GestionUsuariosPage({Key key, this.user}) : super(key: key);

  @override
  _GestionUsuariosPageState createState() => _GestionUsuariosPageState();
}

class _GestionUsuariosPageState extends State<GestionUsuariosPage> {
  List<Usuario> _usuario = null;
  Usuario _user;
  UserRepository _repoUser = locator<UserRepository>();
  bool _isloading = true;

  FutureOr onGoBack(dynamic value) {
    getAllUsers();
  }

  void getAllUsers(){
    _repoUser
        .getAllUser()
        .then((list) => setState(() {
      _isloading = false;
      _usuario = list;
    }))
        .catchError((Object error) {
      setState(() {
        _isloading = false;
      });
      SuccessToast('Error al actualizar los usuarios.');
      return error;
    });
  }

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    getAllUsers();

    //var _posts = await _repo.getAll();
  }

  Widget _createListView(BuildContext context, List<Usuario> users) {
    return new ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            height: 2.0,
            thickness: 1,
          ),
          users[i].admin ? SizedBox(height: 0,) :
          new ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DelModUsuario(user: users[i],))).then((value) => onGoBack(value)),
              leading: Icon(Icons.supervised_user_circle, color: Colors.black,),
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${users[i].nombre.toString()}',
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
                    users[i].email,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Usuarios"),
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
        child: _usuario == null
            ? Center(
          child: Text("Error al obtener los productos"),
        )
            : _createListView(context, _usuario),),

      ),
    );
  }
}


