// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shopend/app/common/utils/size_config.dart';
import 'package:shopend/app/domain/model/_models.dart';

import 'Price.dart';
import 'DefaultButton.dart';
import 'ProductDescription.dart';
import 'ProductImages.dart';
import 'TopRoundedContainer.dart';

class Body extends StatefulWidget {
  Producto product;
  Body({Key key, this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
  
}

class _BodyState extends State<Body> {
   Producto _product;


  @override
  void initState() {
    super.initState();
    _product = widget.product;
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
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color.fromRGBO(194, 232, 248, 4.0),
                child: Column(
                  children: [
                  Price(product: _product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.15,
                          right: MediaQuery.of(context).size.width * 0.15,
                          bottom: getProportionateScreenWidth(40, context: context),
                          top: getProportionateScreenWidth(15, context: context),
                        ),
                        child: DefaultButton(
                          text: "Comprar Producto",
                          press: () {},
                        ),
                      ),
                    ),
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