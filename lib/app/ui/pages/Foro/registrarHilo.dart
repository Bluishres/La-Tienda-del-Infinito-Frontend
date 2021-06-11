// @dart=2.9
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/common/constants.dart';
import 'package:shopend/app/data/repository/_repositorys.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/ui/widgets/indicator/loading_indicator.dart';

import '../../../locator.dart';

class RegistrarHilo extends StatefulWidget {
  final Usuario user;
  RegistrarHilo(this.user);

  @override
  RegistrarHiloState createState() => RegistrarHiloState();
}

class RegistrarHiloState extends State<RegistrarHilo> {
  HiloRepository _repoHilo = locator<HiloRepository>();
  Hilo _hilo;
  final titulo = TextEditingController();
  final mensaje = TextEditingController();
  bool _isloading = false;
  bool _isError = false;
  bool _isValidatebad = false;
  Usuario _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titulo.dispose();
    mensaje.dispose();
    super.dispose();
  }

  void _subirHilo() {
    if(!_isValidatebad){
    _repoHilo.postHilo(
        fecha: DateTime.now().toString(),
        id_Creador: _user.id,
    titulo: titulo.text,
    mensaje: mensaje.text)
        .then((hilo) => setState(() {
      _hilo = hilo;
      _isloading = false;
    }))
        .then((value) => SuccessToast("Hilo creado correctamente."))
    .then((value) => Navigator.pop(context))
        .catchError((Object error) {
      setState(() {
        _isloading = false;
        _isError = true;
      });
      SuccessToast('Error al crear el Hilo.');
      return error;
    });}else{
      setState(() {
        _isloading = false;
        _isError = true;
      });
      SuccessToast('Error al crear el Hilo.');
    }
  }


  void _comprobar_Campos() {
    setState(() {
      _isloading = true;
      _isError = false;
      titulo.text.isEmpty ||
              mensaje.text.isEmpty
          ? _isValidatebad = true
          : _isValidatebad = false;
    });
    _subirHilo();
  }

  Widget _buildTitulo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Column(children: <Widget>[
            Text('Título del hilo: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ]),
          Column(children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text('*',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ),
          ]),
        ]),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: titulo,
            style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 15.0),
              prefixIcon: Icon(
                Icons.description,
                color: Colors.black,
              ),
              hintText: 'Título',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        _isValidatebad && titulo.text.isEmpty
            ? Text('Campo obligatorio.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
            : SizedBox(height: 0),
      ],
    );
  }

  Widget _buildMensaje() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        Row(children: <Widget>[
          Column(children: <Widget>[
            Text('Primer Mensaje del hilo: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ]),
          Column(children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text('*',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ),
          ]),
        ]),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 200.0,
          child: TextField(
          maxLines: 30,
            controller: mensaje,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.message,
                color: Colors.black,
              ),
              hintText: 'Mensaje',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        _isValidatebad && mensaje.text.isEmpty
            ? Text('Campo obligatorio.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
            : SizedBox(height: 0),
      ],
    );
  }

  Widget _buildObligatorio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('* OBLIGATORIO',
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'OpenSans',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(180, 226, 248, 4.0),
        appBar: AppBar(
          title: Image.asset('assets/images/Logo.png',
              fit: BoxFit.cover, width: 170.0, height: 230.0),
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
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
          child: _isloading
              ? Center(
                  child: LoadingIndicator(),
                )
              : SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Registro de Hilo',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildObligatorio(),
                      SizedBox(height: 20.0),
                      _buildTitulo(),
                      SizedBox(height: 20.0),
                      _buildMensaje(),
                      SizedBox(height: 20.0),
                      _isError
                          ? Text('ERROR, comprueba los datos.',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                          : SizedBox(height: 0),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        padding: EdgeInsets.all(20.0),
                        color: Color.fromRGBO(240, 165, 165, 4.0),
                        hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Añadir hilo",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onPressed: () {
                          _comprobar_Campos();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.all(20.0),
                        color: Color.fromRGBO(240, 165, 165, 4.0),
                        hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Volver",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
        ));
  }
}
