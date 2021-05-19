import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopend/app/router.dart';
import 'package:shopend/app/ui/pages/_pages.dart';
import 'package:shopend/app/ui/pages/userPerfilPage.dart';

import 'common/GeneralDrawer.dart';

class MyApp extends StatelessWidget {
  final String title;

  const MyApp({Key key, this.title}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primaryColor: Colors.white),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(62.0),
          child: AppBar(
          title: Image.asset('assets/images/Logo.png', fit: BoxFit.cover),
          centerTitle: true,
          actions: <Widget>[
            Container(
              child: RaisedButton(
                color: Color.fromRGBO(240, 165, 165, 4.0),
                hoverColor: Color.fromRGBO(246, 237, 203, 200.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            )
          ],
        ),
        ),
        drawer: MenuLateral(),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(children: <Widget>[
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
                          Color(0xFF11FAE1),
                          Color(0xFF398AE5),
                        ],
                        stops: [0.1, 0.4, 0.7, 0.9],
                      ),
                    ),
                  ),
                ]))));
  }
}