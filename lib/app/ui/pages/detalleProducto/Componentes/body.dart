// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopend/app/common/utils/size_config.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:universal_platform/universal_platform.dart';

import 'DefaultButton.dart';
import 'Price.dart';
import 'ProductDescription.dart';
import 'ProductImages.dart';
import 'TopRoundedContainer.dart';

class Body extends StatefulWidget {
  final Function Actualizarcantidad;
  final Function Comprar;
  final Function Addfavorito;
  final Function Retirarproducto;
  final Usuario userActivo;
  Producto product;


  Body({Key key, this.product, this.Actualizarcantidad, this.Comprar, this.userActivo, this.Addfavorito, this.Retirarproducto}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Producto _product;
  Function Actualizarcantidad;
  Function Comprar;
  Function Addfavorito;
  Usuario _userActivo;
  Function Retirarproducto;
  @override
  void initState() {
    super.initState();
    _product = widget.product;
    Actualizarcantidad = widget.Actualizarcantidad;
    Comprar = widget.Comprar;
    _userActivo = widget.userActivo;
    Addfavorito = widget.Addfavorito;
    Retirarproducto = widget.Retirarproducto;
  }




  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: _product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: _product,
                Addfavorito: Addfavorito,
                userActivo: _userActivo,
              ),
              TopRoundedContainer(
                color: Color.fromRGBO(194, 232, 248, 4.0),
                child: Column(
                  children: [
                    Price(product: _product, Actualizarcantidad: Actualizarcantidad),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20, context: context)),
                      child: Row(
                          children: <Widget>[
                        Column(
                          children: [
                            Text(
                              'Stock Disponible: ',
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              _product.stockDisponible.toString(),
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: _product.stockDisponible == 0 ? Colors.red : Colors.green),
                            ),
                          ],
                        ),
                      ]),
                    ),
                    SizedBox(height: 20,),
                    UniversalPlatform.isWeb ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20, context: context)),
                      child: _userActivo != null ? Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () {Comprar();},
                            child: Text("Comprar Producto"),
                          ),
                          SizedBox(width: 20,),
                          _userActivo.admin ?  ElevatedButton(
                            style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () {Retirarproducto();},
                            child: Text("Retirar Producto"),
                          ) : SizedBox(height: 0,),
                        ],
                      ) : Center(
                        child: Text("Debes estar registrado para comprar en esta plataforma.",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14
                            ),
                            textAlign: TextAlign.center),
                      ),
                    ) : SizedBox(height: 0,),
                    UniversalPlatform.isAndroid ? TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.15,
                          right: MediaQuery.of(context).size.width * 0.15,
                          bottom:
                              getProportionateScreenWidth(40, context: context),
                          top:
                              getProportionateScreenWidth(15, context: context),
                        ),
                        child: _userActivo != null ? Column(
                          children: [
                            DefaultButton(
                              text: "Comprar Producto",
                              press: () {Comprar();},
                            ),
                           _userActivo.admin ? SizedBox(height: 20,) : SizedBox(height: 0,),
                            _userActivo.admin ? DefaultButton(
                              text: "Retirar Producto.",
                              press: () {Retirarproducto();},
                            ) : SizedBox(height: 0,)
                          ],
                        ) : Center(
                          child: Text("Debes estar registrado para comprar en esta plataforma.",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14
                          ),
                          textAlign: TextAlign.center),
                        ),
                      ),
                    ) : SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
