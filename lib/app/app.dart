import 'package:flutter/material.dart';
import 'package:la_tienda_del_infinito/app/ui/pages/loginPage.dart';
import 'package:la_tienda_del_infinito/app/ui/pages/userPerfilPage.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Tienda del Infinito',
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
      backgroundColor: Color.fromRGBO(180, 226, 248, 4.0),
      appBar: AppBar(
        title: Image.asset('images/Logo.png', fit: BoxFit.cover),
        centerTitle: true,
        actions: <Widget>[RaisedButton(
          color: Colors.red,
          hoverColor: Colors.lightGreen,
          child: Text("Login", style: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
        ],
      ),
      drawer: MenuLateral(),
      // Uso este RaisedButton en el body de forma momentánea para probar
      // el link con la página de Perfil
      body: RaisedButton(
        color: Colors.red,
        hoverColor: Colors.lightGreen,
        child: Text("Perfil", style: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
            fontSize: 18
        ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserPerfil()),
          );
        },
      ),
    );
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
                    )
            ),
          ),
          new ListTile(
              leading: Icon(Icons.account_box, color: Colors.cyan, size: 30.0),
              title: Text("Perfil", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans"
              ),
              )
          ),
          new ListTile(
              leading: Icon(Icons.attach_email_outlined,
                  color: Colors.cyan, size: 30.0),
              title: Text("Foro", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans"
              ),
              )
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
