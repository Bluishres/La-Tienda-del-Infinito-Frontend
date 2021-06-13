// @dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopend/app/common/BoxDecorationGeneral.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/data/repository/_repositorys.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/ui/pages/Foro/registrarHilo.dart';
import 'package:shopend/app/ui/widgets/indicator/loading_indicator.dart';

import '../../../locator.dart';
import 'HiloDetalle.dart';

class ForoPage extends StatefulWidget {
  final Usuario user;

  const ForoPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ForoPage();
  }
}

class _ForoPage extends State<ForoPage> with SingleTickerProviderStateMixin {
  Usuario _user;
  List _foroList = <Hilo>[];
  HiloRepository _repoHilo = locator<HiloRepository>();
  bool _isLoading = false;
  bool _isDelete = false;

  Future<void> _recuperarForosbd(bool isActualizar) async {
    _repoHilo
        .getAllHilos()
        .then((listaHilo) => setState(() {
              _foroList = listaHilo;
              _isLoading = false;
            }))
        .then((value) => isActualizar
            ? SuccessToast("Actualizado la lista de hilos.")
            : null)
        .catchError((Object error) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _retirarHilo(Hilo hilo) {
    setState(() {
      _isLoading = true;
    });
    _repoHilo
        .deleteHilo(id: hilo.id)
        .then((isCorrect) => setState(() {
              _isLoading = false;
              _isDelete = false;
            }))
        .then((value) => SuccessToast("Hilo eliminado."))
        .then((value) => _recuperarForosbd(true))
        .catchError((Object error) {
      setState(() {
        _isLoading = false;
      });
      SuccessToast('Error al eliminar hilo.');
      return error;
    });
  }

  void actualizar() {
    setState(() {
      _isLoading = true;
    });
    _recuperarForosbd(true);
  }

  void setDelete() {
    if (!_isDelete) {
      SuccessToast("Selecciona el hilo que quieres eliminar.");
    }
    setState(() {
      _isDelete = !_isDelete;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    _user = widget.user;
    _recuperarForosbd(false);
  }

  FutureOr onGoBack(dynamic value) {
    _recuperarForosbd(true);
  }

  isUser() {
    return SpeedDial(
      marginEnd: 18,
      marginBottom: 20,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      icon: Icons.menu,
      activeIcon: Icons.remove,
      buttonSize: 56.0,
      visible: true,
      closeManually: false,
      renderOverlay: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.cyan,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(Icons.update),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          label: 'Actualizar',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => {actualizar()},
        ),
        SpeedDialChild(
          child: Icon(Icons.add_box),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          label: 'Añadir hilo',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrarHilo(_user)),
            ).then((value) => onGoBack(value))
          },
        ),
      ],
    );
  }

  SpeedDial isAdmin() {
    return SpeedDial(
      marginEnd: 18,
      marginBottom: 20,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      icon: Icons.menu,
      activeIcon: Icons.remove,
      buttonSize: 56.0,
      visible: true,
      closeManually: false,
      renderOverlay: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.cyan,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: _isDelete ? Icon(Icons.cancel) : Icon(Icons.delete),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          label: _isDelete ? 'Cancelar' : 'Eliminar Hilo',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => {setDelete()},
        ),
        SpeedDialChild(
          child: Icon(Icons.update),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          label: 'Actualizar',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => {actualizar()},
        ),
        SpeedDialChild(
          child: Icon(Icons.add_box),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          label: 'Añadir hilo',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrarHilo(_user)),
            ).then((value) => onGoBack(value))
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: LoadingIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Foro",
                  style: GoogleFonts.viaodaLibre(fontWeight: FontWeight.bold)),
            ),
            body: Stack(children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: _isDelete ? conisDelete() : conisNormal(),
              ),
              Container(
                child: ListView.builder(
                    itemCount: _foroList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildHiloCard(context, index)),
              )
            ]),
            floatingActionButton: _user.admin ? isAdmin() : isUser());
  }

  Widget buildHiloCard(BuildContext context, int index) {
    Hilo hilo = _foroList[index];
    return GestureDetector(
      onTap: () => {
        _isDelete
            ? _retirarHilo(hilo)
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ForumDetailPage(
                          hilo: hilo,
                          user: _user,
                        )),
              ).then((value) => onGoBack(value))
      },
      child: Container(
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
                  padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Container(
                      child: Text(
                    hilo.titulo,
                    style: GoogleFonts.viaodaLibre(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0, bottom: 20.0),
                  child: Container(
                    child: Text(hilo.fechaCreacion.toString().substring(0, 10),
                        style: GoogleFonts.viaodaLibre()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        hilo.creador.nick,
                        style: GoogleFonts.viaodaLibre(fontSize: 20.0),
                      ),
                      Spacer(),
                      Icon(Icons.message),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
