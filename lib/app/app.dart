import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Tienda del Infinito',
      theme: ThemeData(
        primaryColor: Colors.cyan,
        accentColor: Colors.cyan
      ),
      home: MyHomePage(title: 'La Tienda del Infinito'),
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
        appBar: AppBar(title: const Text('La Tienda del Infinito'),
    ),
      drawer: MenuLateral(),
    );
  }
}

class MenuLateral extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text("NombredeUsuario"),
            accountEmail: Text("Prueba@hotmail.com"),
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage("https://d1bvpoagx8hqbg.cloudfront.net/259/2347b61ae2c02d0f2b100474e2c29f71.jpg")
                  /*fit: BoxFit.cover*/
              )
            ),
          ),
          new ListTile(
            leading: Icon(Icons.account_box,color: Colors.cyan, size: 30.0),
            title: Text("Perfil")
          ),
          new ListTile(
              leading: Icon(Icons.attach_email_outlined,color: Colors.cyan, size: 30.0),
              title: Text("Foro")
          ),
        ],
      ),
    );
  }
  
}