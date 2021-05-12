import 'dart:html';
import 'package:la_tienda_del_infinito/app/ui/pages/foroPage.dart';
import 'package:la_tienda_del_infinito/app/ui/pages/userPerfilPage.dart';
import 'package:la_tienda_del_infinito/utilities/constants.dart';
import 'package:flutter/material.dart';

class RegistrarPage extends StatefulWidget {
  @override
  RegistrarPageState createState() => RegistrarPageState();
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

class RegistrarPageState extends State<RegistrarPage> {
  Widget _buildFotoPerfil() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage(
              'logos/google.jpg',
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

  Widget _buildFirstRow() {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 50.0,
        ),
        child: Row(
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
          ],
        ),
      ),
    );
  }

  Widget _buildSecondRow() {
    return Row(
      children: [
        SizedBox(
          height: 20.0,
        ),
        _buildFotoPerfil(),
        Column(children: [
          _buildNick(),
          _buildPassword(),
          _buildEmail(),
          _buildNombre(),
        ]),
        Column(
          children: [
            _buildApellidos(),
            _buildNacionalidad(),
            _buildFechaNacimiento(),
            _buildDireccion(),
          ],
        ),
      ],
    );
  }

  Widget _buildThirdRow() {
    return Row(
      children: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(180, 226, 248, 4.0),
        appBar: AppBar(
          title: Image.asset('images/Logo.png', fit: BoxFit.cover),
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
                    "Registrarse",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
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

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text("NombredeUsuario"),
            accountEmail: Text("Prueba@hotmail.com"),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://d1bvpoagx8hqbg.cloudfront.net/259/2347b61ae2c02d0f2b100474e2c29f71.jpg")
                    /*fit: BoxFit.cover*/
                    )),
          ),
          new ListTile(
            leading: Icon(Icons.account_box, color: Colors.cyan, size: 30.0),
            title:
                /*Text(
                "Perfil",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "OpenSans"),
              )*/
                RaisedButton(
              color: Color.fromRGBO(240, 165, 165, 4.0),
              hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
              child: Text(
                "Perfil",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPerfil()),
                );
              },
            ),
          ),
          new ListTile(
            leading: Icon(Icons.attach_email_outlined,
                color: Colors.cyan, size: 30.0),
            title: RaisedButton(
              color: Color.fromRGBO(240, 165, 165, 4.0),
              hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
              child: Text(
                "Foro",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForoScreen()),
                );
              },
            ),
          ),
          new ListTile(
            leading:
                Icon(Icons.app_registration, color: Colors.cyan, size: 30.0),
            title: RaisedButton(
              color: Color.fromRGBO(240, 165, 165, 4.0),
              hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
              child: Text(
                "Registro",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrarPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
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
