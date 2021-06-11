// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForoScreen extends StatefulWidget {
  @override
  ForoScreenState createState() => ForoScreenState();
}

class ForoScreenState extends State<ForoScreen> {
  bool _rememberMe = false;

  Widget _buildContenedorHilos() {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(255, 240, 240, 150.0)),
      margin: const EdgeInsets.all(20.0),
      child: Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(3),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              Container(
                  height: 70,
                  child: Center(
                    child: Text(
                      'Hilos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  )),
              Container(
                  height: 70,
                  child: Center(
                    child: Text(
                      'Mensajes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  )),
              Center(
                child: Container(
                    height: 70,
                    child: Center(
                      child: Text(
                        'Autor',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.5,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    )),
              ),
            ],
          ),
          TableRow(
            children: <Widget>[
              Container(
                  height: 70,
                  child: Center(
                    child: Text(
                      'Películas 2021',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  )),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.top,
                child: Container(
                    height: 70,
                    child: Center(
                      child: Text(
                        '3',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.5,
                          fontSize: 15.0,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    )),
              ),
              Container(
                  height: 70,
                  child: Center(
                    child: Text(
                      'josebusto98',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  )),
            ],
          ),
          TableRow(
            children: <Widget>[
              Container(
                  height: 70,
                  child: Center(
                    child: Text(
                      'Videojuegos 2021',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  )),
              Container(
                  height: 70,
                  child: Center(
                    child: Text(
                      '2',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  )),
              Center(
                child: Container(
                    height: 70,
                    child: Center(
                      child: Text(
                        'bluishres',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.5,
                          fontSize: 15.0,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ],
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
        child: GestureDetector(
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
              Container(
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
                        'FORO',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildContenedorHilos(),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
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
