// @dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/data/repository/_repositorys.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/ui/pages/Foro/registrarHilo.dart';

import '../../../locator.dart';

class ForoPage extends StatefulWidget {
  final Usuario user;

  const ForoPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ForoPage();
  }
}

class _ForoPage extends State<ForoPage> {
  Usuario _user;
  List _ForoList = <Hilo>[];
  bool _errorProductos = false;
  HiloRepository _repoHilo = locator<HiloRepository>();
  Future<void> _recuperarForosbd(bool isActualizar) async {
    _repoHilo
        .getAllHilos()
        .then((listaHilo) => setState(() {
      _ForoList = listaHilo;
    }))
        .then((value) =>
    isActualizar ? SuccessToast("Actualizado la lista de hilos.") : null)
        .catchError((Object error) {
      setState(() {
        _errorProductos = true;
      });
    });
  }


  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _recuperarForosbd(false);
  }
  FutureOr onGoBack(dynamic value) {
    _recuperarForosbd(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Foro"),
        ),
        body: Stack(children: <Widget>[
          Container(
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
          ),
          Container(
            child: new ListView.builder(
                itemCount: _ForoList.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildHiloCard(context, index)),
          ),
        ]),
        bottomNavigationBar: Container(
            padding: MediaQuery.of(context).viewInsets,
            color: Colors.white,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 2),
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type a message',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 10.0,
                          fillColor: Colors.cyan,
                          child: Icon(
                            Icons.send,
                            size: 27.0,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),
                      ],
                    )
                  ],
                ))
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrarHilo(_user)),
            ).then((value) => onGoBack(value));
          },
          child: const Icon(Icons.add_box),
          backgroundColor: Colors.cyan,
        ));
  }
  Widget buildHiloCard(BuildContext context, int index) {
    Hilo hilo = _ForoList[index];
    return new Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Card(
        color: Color.fromRGBO(255, 185, 185, 4.0),
        elevation: 100,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child:
                Container(child: Text(hilo.titulo, style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 20.0),
                child:
                Container(
                  child: Text(hilo.fechaCreacion.toString().substring(0,10)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                child: Row(
                  children: <Widget>[
                    Text(hilo.creador.nick, style: new TextStyle(fontSize: 20.0),),
                    Spacer(),
                    Icon(Icons.message),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
