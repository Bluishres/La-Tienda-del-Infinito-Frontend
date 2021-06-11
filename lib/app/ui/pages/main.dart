// @dart=2.9
import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopend/app/common/GeneralDrawer.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/data/repository/_repositorys.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/locator.dart';
import 'package:shopend/app/ui/pages/_pages.dart';
import 'package:shopend/app/ui/pages/detalleProducto/DetalleProducto.dart';
import 'package:shopend/app/ui/pages/Producto/registrarProducto.dart';

class Main extends StatefulWidget {
  Main({Key key, this.title, this.ProductoList, this.errorProductos})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final List ProductoList;
  final bool errorProductos;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  ProductRepository _repoProduct = locator<ProductRepository>();
  List _ProductoList;
  var currentUser;
  bool _errorProductos = false;
  Usuario _user;
  UserRepository _repoUser = locator<UserRepository>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  PageController pageController;
  double viewportFraction = 0.8;
  double pageOffset = 0;
  bool _isLoading = true;

  FutureOr onGoBack(dynamic value) {
    setState(() {
      currentUser = auth.currentUser;
    });
    _recuperarUserbd();
    _recuperarProductosbd(false);
  }

  void _recuperarUserbd() {
    if (currentUser != null) {
      _repoUser
          .getUserByEmail(email: currentUser.email)
          .then((user) => setState(() {
                _user = user;
              }))
          .catchError((Object error) {
        return error;
      });
    }
  }

  Usuario getUsuarioActivo() {
    if (_user != null) {
      return _user;
    } else {
      return null;
    }
  }

  Future<void> _recuperarProductosbd(bool isActualizar) async {
    _repoProduct
        .getAllProduct()
        .then((listaProducto) => setState(() {
              _ProductoList = listaProducto;
            }))
        .then((value) =>
            isActualizar ? SuccessToast("Actualizado los productos.") : null)
        .catchError((Object error) {
      setState(() {
        _errorProductos = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        currentUser = auth.currentUser;
        _ProductoList = widget.ProductoList;
        _errorProductos = widget.errorProductos;
      });
    }
    _recuperarUserbd();
    pageController =
        PageController(initialPage: 0, viewportFraction: viewportFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController.page;
            });
          });
  }

  void cerrarSesion() {
    auth.signOut().then((value) => setState(() {
          currentUser = auth.currentUser;
          _user = null;
        }));
    Navigator.pop(context, 'OK');
  }

  FloatingActionButton addProducto() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegistrarProducto()))
            .then((value) => onGoBack(value));
      },
      child: const Icon(Icons.add_box),
      backgroundColor: Colors.cyan,
    );
  }

  _showDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            title: const Text('Cerrar Sesión'),
            content: const Text('¿Está seguro de que quiere cerrar sesión?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => cerrarSesion(),
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancelar'),
              ),
            ],
          );
        });
  }

  PageView ListProducts() {
    return PageView.builder(
      controller: pageController,
      itemBuilder: (context, index) {
        double scale = max(viewportFraction,
            (1 - (pageOffset - index).abs()) + viewportFraction);

        double angle = (pageOffset - index).abs();

        if (angle > 0.5) {
          angle = 1 - angle;
        }
        return Container(
          padding: EdgeInsets.only(
            right: 10,
            left: 20,
            top: 100 - scale * 25,
            bottom: 100 - angle * 25,
          ),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(
                3,
                2,
                0.001,
              )
              ..rotateY(angle),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(
                    PageRouteBuilder(
                      fullscreenDialog: true,
                      transitionDuration: Duration(milliseconds: 600),
                      barrierColor: Color.fromRGBO(194, 232, 248, 4.0),
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return DetalleProducto(
                          producto: Producto(
                              nombre: _ProductoList[index].nombre,
                              descripcion: _ProductoList[index].descripcion,
                              imagen: _ProductoList[index].imagen,
                              fechaCreacion: _ProductoList[index].fechaCreacion,
                              precio: _ProductoList[index].precio,
                              stockDisponible:
                                  _ProductoList[index].stockDisponible,
                              id: _ProductoList[index].id),
                          getUsuarioActivo: getUsuarioActivo(),
                        );
                      },
                      transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) {
                        return SlideTransition(
                          position: Tween(
                                  begin: Offset(1.0, 0.0),
                                  end: Offset(0.0, 0.0))
                              .animate(animation),
                          child: child,
                        );
                        /*FadeTransition(
                      opacity:
                      animation, // CurvedAnimation(parent: animation, curve: Curves.elasticInOut),
                      child: child,
                    )*/
                        ;
                      },
                    ),
                  )
                  .then((value) => onGoBack(value)),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Hero(
                      flightShuttleBuilder: (
                        BuildContext flightContext,
                        Animation<double> animation,
                        HeroFlightDirection flightDirection,
                        BuildContext fromHeroContext,
                        BuildContext toHeroContext,
                      ) {
                        final Hero toHero = toHeroContext.widget;
                        return ScaleTransition(
                          scale: animation.drive(
                            Tween<double>(begin: 0.0, end: 1.0).chain(
                              CurveTween(
                                curve: Interval(0.0, 1.0,
                                    curve: PeakQuadraticCurve()),
                              ),
                            ),
                          ),
                          child: flightDirection == HeroFlightDirection.push
                              ? RotationTransition(
                                  turns: animation,
                                  child: toHero.child,
                                )
                              : FadeTransition(
                                  opacity: animation.drive(
                                    Tween<double>(begin: 0.0, end: 1.0).chain(
                                      CurveTween(
                                        curve: Interval(0.0, 1.0,
                                            curve: ValleyQuadraticCurve()),
                                      ),
                                    ),
                                  ),
                                  child: toHero.child,
                                ),
                        );
                      },
                      tag: 'image' + _ProductoList[index].nombre,
                      child: Image.network(
                        _ProductoList[index].imagen,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        alignment: Alignment((pageOffset - index).abs() * 0.5, 0),
                      ),
                    ),
                  ), AnimatedCrossFade(
                      crossFadeState: angle == 0
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: Duration(
                        milliseconds: 200,
                      ),
                      firstChild: SizedBox(
                        height: 0,
                      ),
                      secondChild: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: AnimatedCrossFade(
                          crossFadeState: angle == 0
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: Duration(
                            milliseconds: 200,
                          ),
                          firstChild: SizedBox(
                            height: 0,
                          ),
                          secondChild: Hero(
                            tag: 'text' + _ProductoList[index].nombre,
                            child: Center(
                              child: Text(
                                _ProductoList[index].nombre +
                                    "\n" +
                                    _ProductoList[index].precio +
                                    "€",
                                style: GoogleFonts.stintUltraCondensed(color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: _ProductoList.length,
    );
  }

  Column columna() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListProducts(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //MediaQueryData queryData;
    //queryData = MediaQuery.of(context);
    SizeConfig().init(context);
    timeDilation = 2;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Image.asset('assets/images/Logo.png'),
          actions: [
            currentUser != null
                ? IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    onPressed: () => _showDialog(context))
                : IconButton(
                    icon: Icon(
                      Icons.login,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()))
                        .then((value) => onGoBack(value)),
                  ),
          ],
        ),
        drawer: currentUser != null ? MenuLateralLogin(_user) : MenuLateral(),
        body: Container(
            height: SizeConfig.safeBlockVertical * 100, //10 for example
            width: SizeConfig.safeBlockHorizontal * 100, //10 for example
            child: RefreshIndicator(
              onRefresh: () async {
                _recuperarProductosbd(true);
              },
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.light,
                  child: GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Stack(children: <Widget>[
                        Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
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
                        _errorProductos
                            ? Text(
                                "Error, no se ha podido obtener los productos.")
                            : columna()
                      ]))),
            )),
        floatingActionButton:
            _user != null && _user.admin ? addProducto() : null);
  }
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

class PeakQuadraticCurve extends Curve {
  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    return -15 * pow(t, 2) + 15 * t + 1;
  }
}

class ValleyQuadraticCurve extends Curve {
  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    return 4 * pow(t - 0.5, 2);
  }
}
