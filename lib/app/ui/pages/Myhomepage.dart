// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shopend/app/ui/pages/Splash/Splashscreen.dart';
import 'package:shopend/app/ui/pages/main.dart';


class MyHomePage extends StatefulWidget {
  final String title;
  final List ProductoList;
  final bool errorProductos;

  MyHomePage({Key key, this.title, this.ProductoList, this.errorProductos})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title;
  List ProductoList;
  bool errorProductos;


  @override
  void initState() {
    title = widget.title;
    ProductoList = widget.ProductoList;
    errorProductos = widget.errorProductos;
  }


  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(children: <Widget>[
      Main(
        title: title,
        errorProductos: errorProductos,
        ProductoList: ProductoList,
      ),
      IgnorePointer(child: Splashscreen(color: Colors.cyan))
    ]));
  }
}
