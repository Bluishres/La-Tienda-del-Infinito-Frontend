// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/common/constants.dart';
import 'package:shopend/app/data/repository/_repositorys.dart';
import 'package:shopend/app/domain/model/Usuario.dart';
import 'package:shopend/app/locator.dart';
import 'package:shopend/app/ui/widgets/indicator/loading_indicator.dart';

class DelModUsuario extends StatefulWidget {
  final Usuario user;

  DelModUsuario({this.user = null});

  @override
  DelModUsuarioState createState() => DelModUsuarioState();
}

class DelModUsuarioState extends State<DelModUsuario> {
  Usuario _user;
  final nick = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  final nombre = TextEditingController();
  final apellidos = TextEditingController();
  final nacionalidad = TextEditingController();
  final fechaNacimiento = TextEditingController();
  final direccion = TextEditingController();
  final fotoPerfil = TextEditingController();
  bool _show = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User admin;
  bool _isloading = false;
  UserRepository _repoUser = locator<UserRepository>();

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    nick.text = _user.nick;
    password.text = _user.password;
    email.text = _user.email;
    nombre.text = _user.nombre;
    apellidos.text = _user.apellidos;
    nacionalidad.text = _user.nacionalidad;
    fechaNacimiento.text = _user.fechaNacimiento.toString();
    direccion.text = _user.direccion;
    fotoPerfil.text = _user.fotoPerfil;
    setState(() {
      admin = auth.currentUser;
    });
  }

  void EliminarUsuarioBD() {
    _repoUser
        .deleteUsuario(id: _user.id)
        .then((value) => setState(() {
              _isloading = false;
            }))
        .then((value) => SuccessToast("Usuario eliminado correctamente."))
        .then((value) => Navigator.pop(context))
        .catchError((Object error) {
      setState(() {
        _isloading = false;
      });
      SuccessToast('Error al eliminar usuario.');
      return error;
    });
  }

  Future<void> EliminarUsuario() async {
    setState(() {
      _isloading = true;
    });
    auth
        .signOut()
        .then((value) => auth.signInWithEmailAndPassword(
            email: _user.email, password: _user.password))
        .then((value) => value.user.delete())
        .then((value) => auth.signInWithEmailAndPassword(
            email: admin.email, password: "123456"))
        .then((value) => EliminarUsuarioBD())
        .catchError((Object error) {
      setState(() {
        _isloading = false;
      });
      SuccessToast('Error al eliminar usuario.');
      return error;
    });
  }

  void mostrarPass() {
    setState(() {
      _show = !_show;
    });
  }

  Widget _buildFotoPerfil() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              width: 200,
              height: 200,
              child: Image.network(
                _user.fotoPerfil,
              )),
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
            controller: nick,
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
            controller: password,
            obscureText: _show ? false : true,
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
        RaisedButton(
          color: Color.fromRGBO(240, 165, 165, 4.0),
          hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(_show ? Icons.lock_outline : Icons.lock_open),
          onPressed: () {
            mostrarPass();
          },
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
            controller: fechaNacimiento,
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
      ],
    );
  }

  Widget _buildBtnEliminarUser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RaisedButton(
          padding: EdgeInsets.all(20.0),
          color: Color.fromRGBO(240, 165, 165, 4.0),
          hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text(
            "Eliminar Usuario",
            style: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          onPressed: () {
            /*Navigator.push(context, MaterialPageRoute(builder: (context) => ProdCompradosPage(user: _user)));*/
            _showDialog(context);
          },
        ),
      ],
    );
  }

  Widget _buildBtnEditarUser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RaisedButton(
          padding: EdgeInsets.all(20.0),
          color: Color.fromRGBO(240, 165, 165, 4.0),
          hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text(
            "Editar Usuario",
            style: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          onPressed: () {
            /*Navigator.push(context, MaterialPageRoute(builder: (context) => ProdFavoritosPage(user: _user)));*/
          },
        ),
      ],
    );
  }

  _showDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            title: const Text('Eliminar Usuario'),
            content:
                const Text('¿Está seguro de que quiere eliminar este usuario?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => EliminarUsuario()
                    .then((value) => Navigator.pop(context, 'Ok')),
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
            ],
          );
        });
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
        body: _isloading
            ? Center(
                child: LoadingIndicator(),
              )
            : Container(
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
                      SizedBox(height: 20.0),
                      _buildNick(),
                      _buildPassword(),
                      _buildEmail(),
                      _buildNombre(),
                      _buildApellidos(),
                      _buildNacionalidad(),
                      _buildFechaNacimiento(),
                      _buildDireccion(),
                      SizedBox(height: 25.0),
                      _buildBtnEliminarUser(),
                      SizedBox(height: 15.0),
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
