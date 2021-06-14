// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/common/constants.dart';
import 'package:shopend/app/ui/pages/Usuario/registrarPage.dart';
import 'package:shopend/app/ui/widgets/indicator/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final password = TextEditingController();
  final email = TextEditingController();
  bool _isValidatebad = false;
  bool _isloading = false;
  bool _isError = false;
  String errorUser = "";
  String errorPass = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    password.dispose();
    email.dispose();
    super.dispose();
  }

  void _inicializar() {
    setState(() {
      _isloading = true;
      _isError = false;
      password.text.isEmpty || email.text.isEmpty
          ? _isValidatebad = true
          : _isValidatebad = false;
      errorUser = "";
      errorPass = "";
    });
  }

  void _initsesion() async {
    _inicializar();
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      setState(() {
        _isloading = false;
      });
      SuccessToast('Iniciada sesion correctamente.');
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _isError = true;
          errorUser = "usuario no encontrado.";
          _isloading = false;
        });
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setState(() {
          _isError = true;
          errorPass = "la contraseña no es correcta.";
          _isloading = false;
        });
        print('Wrong password provided for that user.');
      } else {
        setState(() {
          _isError = true;
          _isloading = false;
        });
      }
    }
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
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
        _isValidatebad && email.text.isEmpty
            ? Text('Debes introducir email.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
            : SizedBox(height: 0),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
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
            ? Text('Debes introducir password.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
            : SizedBox(height: 0),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      width: 300.0,
      padding: EdgeInsets.symmetric(vertical: 50.0),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => _initsesion(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white60,
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '¿No tienes una cuenta? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/Logo.png',
            fit: BoxFit.cover, width: 170.0, height: 230.0),
        centerTitle: true,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: _isloading
            ? Center(
                child: LoadingIndicator(),
              )
            : GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  children: <Widget>[
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
                    Center(
                      child: Container(
                        height: double.infinity,
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 60.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Iniciar Sesión',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              _buildEmailTF(),
                              SizedBox(
                                height: 30.0,
                              ),
                              _buildPasswordTF(),
                              _isError
                                  ? Text('Error , ' + errorUser + " " + errorPass,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red))
                                  : SizedBox(height: 0),
                              _buildLoginBtn(),
                              _buildSignupBtn(),
                              RaisedButton(
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
                                    MaterialPageRoute(
                                        builder: (context) => RegistrarPage()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
