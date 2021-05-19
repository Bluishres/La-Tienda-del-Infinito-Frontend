import 'package:flutter/material.dart';
import 'package:shopend/app/ui/pages/_pages.dart';

import '../router.dart';


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
            title: RaisedButton(
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

          new ListTile(
            leading:
            Icon(Icons.app_registration, color: Colors.cyan, size: 30.0),
            title: RaisedButton(
              color: Color.fromRGBO(240, 165, 165, 4.0),
              hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
              child: Text(
                "Posts",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onPressed: () {
                Navigation.page('/posts/lista',context);
              },
            ),
          )
        ],
      ),
    );
  }
}