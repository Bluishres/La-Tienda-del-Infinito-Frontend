// @dart=2.9
import 'dart:math';

import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopend/app/common/BoxDecorationGeneral.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/common/logger.dart';
import 'package:shopend/app/data/repository/_repositorys.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/locator.dart';



class ForumDetailPage extends StatefulWidget  {
  final Usuario user;
  final Hilo hilo;
  ForumDetailPage({Key key, this.hilo, this.user})
      : super(key: key);
  @override
  _ForumDetailPageState createState() => new _ForumDetailPageState();
}

class _ForumDetailPageState extends State<ForumDetailPage> with TickerProviderStateMixin {
  Hilo _hilo;
  List _mensajesList = <Mensaje>[];
  Usuario _user;
  HiloRepository _repoHilo = locator<HiloRepository>();
  final _mensaje = TextEditingController();
  bool _isDelete = false;
  AnimateIconController _animationController;

  @override
  void initState() {
    _user = widget.user;
    _hilo = widget.hilo;
    _animationController = AnimateIconController();
    getAllmensajes();
  }

  bool setDelete(){
    if(!_isDelete) {
      SuccessToast("Selecciona el mensaje que quieres eliminar.");
    }
    setState(() {
      _isDelete = !_isDelete;
    });
    return true;
  }

  void _eliminarMensaje(Mensaje mensaje) {
    if(_user.admin || _user.nick == mensaje.autor.nick){
    _repoHilo
        .deleteMensaje(id: mensaje.id)
        .then((value) => SuccessToast("Mensaje eliminado."))
        .then((value) => getAllmensajes())
        .catchError((Object error) {
      SuccessToast('Error al eliminar mensaje.');
      return error;
    });}else{
      if(_user.nick != mensaje.autor.nick && !_user.admin){
        SuccessToast('Solo puedes borrar tus mensajes.');
      }
    }
  }

  Future<void> getAllmensajes() async {
    _repoHilo
        .getMensajesByhilo(idHilo: _hilo.id)
        .then((listaMensajes) => setState(() {
      _mensajesList = listaMensajes;
    }))
        .then((value) => SuccessToast("Actualizado los mensajes."))
        .catchError((Object error) {
      SuccessToast("No se han podido actualizar los mensajes.");
    });
  }

  Future<void> _escribirMensaje()async {
    if(_mensaje.text.isNotEmpty){
    _repoHilo
        .postMensaje(fecha: DateTime.now().toString().substring(0,10),id_Creador: _user.id, id_Hilo: _hilo.id, mensaje: _mensaje.text)
        .then((mensaje) => setState(() {
        _mensaje.text = "";
        _mensajesList.add(mensaje);
    }))
        .then((value) => SuccessToast("Mensaje enviado correctamente."))
        .then((value) => getAllmensajes())
        .catchError((Object error) {
      SuccessToast("No se ha podido enviar el mensaje.");
    });}else{
      SuccessToast("Debes insertar algun mensaje.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  _hilo.titulo,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        body: Stack(children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: _isDelete ? conisDelete() : conisNormal(),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.08),
              child: ListView.builder(
                  itemCount: _mensajesList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildHiloCard(context, index)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.white),
              child: Container(
                  child: Stack(
                      children: <Widget>[
                    Container(
                      alignment: Alignment.bottomLeft,
                      width: MediaQuery.of(context).size.width * 0.79,
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: TextField(
                        maxLines: null,
                        controller: _mensaje,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.all(Radius.circular(100))),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          hintText: 'Escribe un mensaje...',
                        )
                      ),
                    ),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RawMaterialButton(
                                onPressed: () {_escribirMensaje();},
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
                          ),
                        ),
                  ])),
            ),
          ),
        ]),
    floatingActionButton: Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      child: FloatingActionButton(
          onPressed: () => {setDelete()},
      child: AnimateIcons(
        startIcon: Icons.delete,
        endIcon: Icons.cancel,
        controller: _animationController,
        size: 30.0,
        onEndIconPress: () => setDelete(),
        onStartIconPress: () => setDelete(),
        duration: Duration(milliseconds: 200),
      ),
      backgroundColor: Colors.red,
      ),
    ));
  }

  Widget buildHiloCard(BuildContext context, int index) {
    return Container(
      child: GestureDetector(
        onTap: () => {_isDelete ? _eliminarMensaje(_mensajesList[index]) : null},
        child: Card(
          color: Color.fromRGBO(207, 255, 205, 4.0),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child:
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
                            child: Row(
                              children: [
                                Image.network(_mensajesList[index].autor.fotoPerfil,width: 50, height: 50,),
                                SizedBox(width: 15.0),
                                Expanded(
                                  child: Text(
                                    _mensajesList[index].autor.nick,
                                        style: GoogleFonts.viaodaLibre(
                                            fontSize: 25.0, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child:
                        Padding(
                          padding: EdgeInsets.only(top: 2, bottom: 4.0),
                          child: Container(
                              child: Text(
                                _mensajesList[index].fechaCreacion.toString().substring(0,10),
                                style: GoogleFonts.viaodaLibre(
                                    fontSize: 15.0, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              )),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        alignment: Alignment.topLeft,
                        child:
                        Padding(
                          padding: EdgeInsets.only(top: 2, bottom: 4.0),
                          child: Container(
                              child: Text(
                                _mensajesList[index].mensaje.toString().replaceAll("\"", "").replaceAll("\\n", "\n"),
                                style: GoogleFonts.alef(
                                    fontSize: 17.0, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}
