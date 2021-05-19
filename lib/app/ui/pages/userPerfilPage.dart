import 'package:flutter/material.dart';
import 'package:shopend/app/common/GeneralDrawer.dart';
import 'package:shopend/app/common/constants.dart';

import '../../router.dart';
import '_pages.dart';

class UserPerfil extends StatefulWidget {
  @override
  UserPerfilState createState() => UserPerfilState();
}

// Este build y el buildFotoPerfil hay que cambiarlos, solo están asi para ver
// como queda visualmente
Widget _buildSocialBtn(Function onTap, AssetImage logo) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
        image: DecorationImage(
          image: logo,
        ),
      ),
    ),
  );
}

class UserPerfilState extends State<UserPerfil> {
  Widget _buildFotoPerfil() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNick() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Nick: ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            enabled: false,
            style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'userNick',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
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
        Text(
          'Password: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            enabled: false,
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
        Text(
          'Email: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            enabled: false,
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
            enabled: false,
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
            enabled: false,
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
            enabled: false,
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
          'Fecha de Nacimiento: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            enabled: false,
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.date_range,
                color: Colors.black,
              ),
              hintText: 'FechaNacimiento',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
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
            enabled: false,
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(180, 226, 248, 4.0),
        appBar: AppBar(
          title: Image.asset('assets/images/Logo.png', fit: BoxFit.cover),
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
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 50.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Datos de usuario',
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
                _buildFotoPerfil(),
                _buildNick(),
                _buildPassword(),
                _buildEmail(),
                _buildNombre(),
                _buildApellidos(),
                _buildNacionalidad(),
                _buildFechaNacimiento(),
                _buildDireccion(),
                SizedBox(height: 20.0),
                RaisedButton(
                  padding: EdgeInsets.all(20.0),
                  color: Color.fromRGBO(240, 165, 165, 4.0),
                  hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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





/*class Imagen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Image appLogo = new Image(
        image: new ExactAssetImage("assets/images/AppLogo.png"),
        height: 5.0,
        width: 5.0,
        alignment: FractionalOffset.center);
  }
}*/
