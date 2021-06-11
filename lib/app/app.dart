// @dart=2.9
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopend/app/data/repository/_repositorys.dart';
import 'package:shopend/app/ui/pages/Myhomepage.dart';
import 'package:shopend/app/ui/widgets/_widgets.dart';

import 'domain/model/Producto.dart';
import 'locator.dart';

class MyApp extends StatefulWidget {
  final String title;

  const MyApp({Key key, this.title}) : super(key: key);

  @override
  _AppState createState() => _AppState(title);
}

class _AppState extends State<MyApp> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final String title;
  ProductRepository _repoProduct = locator<ProductRepository>();
  List _ProductoList = <Producto>[];
  bool _errorProductos = false;
  bool _done = false;

  _AppState(this.title);

  Future<void> _recuperarProductosbd() async {
    _repoProduct
        .getAllProduct()
        .then((listaProducto) => setState(() {
              _ProductoList = listaProducto;
              _done = true;
            }))
        .catchError((Object error) {
      setState(() {
        _errorProductos = true;
        _done = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _recuperarProductosbd();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return RequestErrorWidget();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done && _done) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: this.title,
              theme: ThemeData(
                primaryColor: Colors.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: MyHomePage(
                title: this.title,
                errorProductos: _errorProductos,
                ProductoList: _ProductoList,
              ));
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return LoadingIndicator();
      },
    );
  }
}
