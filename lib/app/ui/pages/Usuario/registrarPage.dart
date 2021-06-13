// @dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:shopend/app/common/GeneralDrawer.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/common/constants.dart';
import 'package:shopend/app/data/repository/user/UserRepository.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/ui/widgets/indicator/loading_indicator.dart';

import '../../../locator.dart';

class RegistrarPage extends StatefulWidget {
  @override
  RegistrarPageState createState() => RegistrarPageState();
}

class RegistrarPageState extends State<RegistrarPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storageReference = FirebaseStorage.instance;
  DocumentReference sightingRef = Firestore.instance.collection("TDI").doc();
  UserRepository _repo = locator<UserRepository>();
  Usuario _user;
  Usuario _comprobar_user;
  final nick = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  final nombre = TextEditingController();
  final apellidos = TextEditingController();
  final nacionalidad = TextEditingController();
  var fecha = TextEditingController();
  final direccion = TextEditingController();
  final foto = TextEditingController();
  DateTime _dateTime;
  bool _isloading = false;
  bool _isEmailbad = false;
  bool _isNickbad = false;
  bool _isError = false;
  bool _isValidatebad = false;
  File _image = null;
  String errorEmail = "";

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    } else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }
    setState(() {
      if (pickedFile != null) {
/*        _images.add(File(pickedFile.path));*/
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('Imagen no seleccionada.');
      }
    });
  }

  Future<String> uploadFile(File _image) async {
    storageReference.ref().child('TDI/${p.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference
        .ref()
        .child('TDI/${p.basename(_image.path)}')
        .putFile(_image);
    await uploadTask.onComplete;
    print('Archivo Subido.');
    String returnURL;
    await storageReference
        .ref()
        .child('TDI/${p.basename(_image.path)}')
        .getDownloadURL()
        .then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  Future<void> _saveImage(File _image, DocumentReference ref) async {
    String imageURL = await uploadFile(_image);
    setState(() {
      foto.text = imageURL;
    });
    ref.update({
      "images": FieldValue.arrayUnion([imageURL])
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nick.dispose();
    password.dispose();
    email.dispose();
    nombre.dispose();
    apellidos.dispose();
    nacionalidad.dispose();
    fecha.dispose();
    direccion.dispose();
    foto.dispose();
    super.dispose();
  }

  FutureOr cerrarSesion() {
    auth.signOut();
  }

  void _subirusuarioFirebase() async {
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) => cerrarSesion());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void _subirusuario() {
    if (!_isEmailbad && !_isNickbad && !_isValidatebad) {
      if(_image != null){
      _saveImage(_image, sightingRef)
          .then((value) => _subirUsuarioBD())
          .catchError((Object error) {
        SuccessToast(
            "Ha ocurrido un error al subir la imagen, por favor vuelve a subirla.");
        return error;
      });}
      else{
        _subirUsuarioBD();
      }
    } else {
      setState(() {
        _isloading = false;
        _isError = true;
      });
    }
  }

  void _subirUsuarioBD() {
    final usuario = Usuario(
        email: email.text,
        nick: nick.text,
        password: password.text,
        direccion: direccion.text,
        nombre: nombre.text,
        apellidos: apellidos.text,
        nacionalidad: nacionalidad.text,
        fotoPerfil: foto.text,
        fechaNacimiento: fecha.text != ""
            ? DateTime.parse(fecha.text)
            : DateTime.parse("0000-00-00"),
        admin: false);
    _repo
        .postUser(USER: usuario)
        .then((user) => setState(() {
              _user = user;
              _isloading = false;
            }))
        .then((value) => SuccessToast('Usuario registrado correctamente.'))
        .then((value) => Navigator.pop(context))
        .catchError((Object error) {
      SuccessToast(
          'Ocurrio un error al registrar el usuario, revise los datos.');
      return error;
    });
    _subirusuarioFirebase();
  }

  void _comprobar_estadoUsuarioE() {
    if (_comprobar_user != null) {
      setState(() {
        _isEmailbad = true;
        errorEmail = "Email ya en uso.";
      });
    } else {
      setState(() {
        _isEmailbad = false;
      });
    }
  }

  void _comprobar_estadoUsuarioN() {
    if (_comprobar_user != null) {
      setState(() {
        _isNickbad = true;
      });
    } else {
      setState(() {
        _isNickbad = false;
      });
    }
  }

  void _comprobar_Usuario2() {
    _repo
        .getUserByNick(nick: nick.text)
        .then((user) => setState(() {
              _comprobar_user = user;
            }))
        .then((value) => _comprobar_estadoUsuarioN())
        .then((value) => _subirusuario())
        .catchError((Object error) {
      _subirusuario();
      return error;
    });
  }

  void _comprobar_Usuario() {
    bool emailValid = EmailValidator.validate(email.text);
    setState(() {
      _isloading = true;
      _isError = false;
      _isNickbad = false;
      _isEmailbad = false;
      password.text.isEmpty || nick.text.isEmpty || email.text.isEmpty
          ? _isValidatebad = true
          : _isValidatebad = false;
    });
    if(!emailValid){
      _isEmailbad = true;
      _isError = true;
      _isloading = false;
      errorEmail = "No es un email válido.";
    }else{
    _repo
        .getUserByEmail(email: email.text)
        .then((user) => setState(() {
              _comprobar_user = user;
            }))
        .then((value) => _comprobar_estadoUsuarioE())
        .then((value) => _comprobar_Usuario2())
        .catchError((Object error) {
      _comprobar_Usuario2();
      return error;
    });}
  }

  Widget _buildFotoPerfilshow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              width: 200,
              height: 200,
              child: Image.file(
                _image,
                fit: BoxFit.contain,
              )),
        ],
      ),
    );
  }

  Widget _buildFotoPerfil() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Foto Perfil: ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          Row(
            children: [
              SizedBox(width: 50),
              Center(
                  child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Galería'),
                color: Color.fromRGBO(240, 165, 165, 4.0),
                hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
                onPressed: () {
                  getImage(true);
                },
              )),
              SizedBox(width: 50.0),
              Center(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('Cámara'),
                  color: Color.fromRGBO(240, 165, 165, 4.0),
                  hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
                  onPressed: () {
                    getImage(false);
                  },
                ),
              ),
            ],
          )
        ]);
  }

  Widget _buildNick() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Column(children: <Widget>[
            Text('Nick: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ]),
          Column(children: <Widget>[
            Text('*',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
          ]),
        ]),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: nick,
            style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 15.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'userNick',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        _isNickbad
            ? Text('Nick ya en uso.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
            : SizedBox(height: 0),
        _isValidatebad && nick.text.isEmpty
            ? Text('El campo es obligatorio.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
            : SizedBox(height: 0),
      ],
    );
  }

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        Row(children: <Widget>[
          Column(children: <Widget>[
            Text('Password: ',
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
            controller: password,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: 'Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        _isValidatebad && password.text.isEmpty
            ? Text('El campo es obligatorio.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
            : SizedBox(height: 0),
      ],
    );
  }

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        Row(children: <Widget>[
          Column(children: <Widget>[
            Text('Email: ',
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
            controller: email,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        _isEmailbad
            ? Text(errorEmail,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
            : SizedBox(height: 0),
        _isValidatebad && email.text.isEmpty
            ? Text('El campo es obligatorio.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
            : SizedBox(height: 0),
      ],
    );
  }

  Widget _buildNombre() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        Text(
          'Nombre: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: nombre,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              hintText: 'Nombre',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildApellidos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        Text(
          'Apellidos: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: apellidos,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person_pin,
                color: Colors.black,
              ),
              hintText: 'Apellidos',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNacionalidad() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        Text(
          'Nacionalidad: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: nacionalidad,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.flag,
                color: Colors.black,
              ),
              hintText: 'Nacionalidad',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFechaNacimiento() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        Text(
          'Fecha de nacimiento: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
              controller: fecha,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              enabled: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(Icons.date_range, color: Colors.black),
                  hintText: 'Fecha',
                  hintStyle: kHintTextStyle)),
        ),
        Center(
          child: RaisedButton(
            child: Text('Selecciona una fecha'),
            color: Color.fromRGBO(240, 165, 165, 4.0),
            hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
            onPressed: () {
              showDatePicker(
                      context: context,
                      initialDate:
                          _dateTime == null ? DateTime.now() : _dateTime,
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2022))
                  .then((date) {
                setState(() {
                  _dateTime = date;
                  fecha.text = (_dateTime == null
                      ? 'No has escogido ninguna fecha'
                      : _dateTime.toString().substring(0, 10));
                });
              });
            },
          ),
        )
      ],
    );
  }

  Widget _buildDireccion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        Text(
          'Dirección: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: direccion,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.directions,
                color: Colors.black,
              ),
              hintText: 'Direccion',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        SizedBox(height: 20.0),
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
        drawer: MenuLateral(),
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
                        'Registro de usuario',
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
                      SizedBox(
                        height: 30.0,
                      ),
                      _image != null
                          ? _buildFotoPerfilshow()
                          : SizedBox(
                              height: 0,
                            ),
                      SizedBox(height: 20.0),
                      _buildFotoPerfil(),
                      SizedBox(height: 20.0),
                      _buildNick(),
                      _buildPassword(),
                      _buildEmail(),
                      _buildNombre(),
                      _buildApellidos(),
                      _buildNacionalidad(),
                      _buildDireccion(),
                      _buildFechaNacimiento(),
                      SizedBox(height: 20.0),
                      _isError
                          ? Text('ERROR, comprueba los datos.',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                          : SizedBox(height: 0),
                      SizedBox(height: 20.0),
                      MaterialButton(
                        padding: EdgeInsets.all(20.0),
                        color: Color.fromRGBO(240, 165, 165, 4.0),
                        hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Registrarse",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onPressed: () {
                          _comprobar_Usuario();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      MaterialButton(
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
