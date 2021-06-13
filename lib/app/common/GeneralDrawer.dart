// @dart=2.9
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/ui/pages/Foro/ForoPage.dart';
import 'package:shopend/app/ui/pages/_pages.dart';
import 'package:shopend/app/ui/pages/Usuario/gestionUsuarios.dart';

class MenuLateralLogin extends StatelessWidget {
  Usuario _user;

  MenuLateralLogin(Usuario user) {
    _user = user;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: Image(
                image: NetworkImage(_user.fotoPerfil), fit: BoxFit.contain),
            accountName: Text(
              _user != null ? _user.nick : "Cargando...",
              style: GoogleFonts.viaodaLibre(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(
              _user != null
                  ? _user.email + (_user.admin ? " - Administrador" : "")
                  : "Cargando...",
              style: GoogleFonts.viaodaLibre(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            decoration: BoxDecoration(
                color: Color.fromRGBO(191, 229, 245, 5.0),
                image: DecorationImage(
                  image: NetworkImage(_user.fotoPerfil),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.cyan.withOpacity(0.5), BlendMode.dstATop),
                )),
          ),
           ListTile(
            leading: Icon(Icons.account_box, color: Colors.cyan, size: 30.0),
            title: RaisedButton(
              color: Color.fromRGBO(240, 165, 165, 4.0),
              hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
              child: Text(
                "Perfil",
                style: GoogleFonts.viaodaLibre(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPerfil(_user)),
                );
              },
            ),
          ),
           ListTile(
            leading: Icon(Icons.attach_email_outlined,
                color: Colors.cyan, size: 30.0),
            title: RaisedButton(
              color: Color.fromRGBO(240, 165, 165, 4.0),
              hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
              child: Text(
                "Foro",
                style: GoogleFonts.viaodaLibre(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForoPage(user: _user,)),
                );
              },
            ),
          ),
          _user.admin
              ? new ListTile(
                  leading: Icon(Icons.supervised_user_circle,
                      color: Colors.cyan, size: 30.0),
                  title: RaisedButton(
                    color: Color.fromRGBO(240, 165, 165, 4.0),
                    hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
                    child: Text(
                      "Gestión Usuarios",
                      style: GoogleFonts.viaodaLibre(
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GestionUsuariosPage(user: _user)),
                      );
                    },
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
        ],
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
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://lh3.googleusercontent.com/pw/ACtC-3ciz4yQUfjXzVgrJh4nJeKl2MOZUV52osCiB_rVF2CSnRLc07vc4BAnbAUTNlmWqvFQYgehc78Dh0t9lSh4NJouYmHQQiFFEjI2JJGBaAzqssFzZTsG3cNXQ_RhjkjgXWWdjkCa2KLGcqEibnpI7EFj=w497-h326-no"),
                    fit: BoxFit.fill)),
          ),
          new ListTile(
            leading: Icon(Icons.account_box, color: Colors.cyan, size: 30.0),
            title: RaisedButton(
              color: Color.fromRGBO(240, 165, 165, 4.0),
              hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
              child: Text(
                "Perfil",
                style: GoogleFonts.viaodaLibre(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onPressed: () => SuccessToast("Debes registrarte para acceder."),
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
                style: GoogleFonts.viaodaLibre(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onPressed: () => SuccessToast("Debes registrarte para acceder."),
            ),
          ),
        ],
      ),
    );
  }
}


