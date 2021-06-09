// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/common/utils/size_config.dart';
import 'package:shopend/app/domain/model/Producto.dart';

import 'RoundedIconBtn.dart';

class Price extends StatefulWidget {
  Producto product;
  Price({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  _PriceState createState() => _PriceState();

}

class _PriceState extends State<Price> {
  Producto product;
  int _cantidad = 0;


  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  void aumentarCant(){
    setState(() {
      _cantidad++;
    });
  }

  void disminuirCant(){
    if(_cantidad > 0){
    setState(() {
      _cantidad--;
    });}else{
      SuccessToast("No se puede disminuir mas cantidad.");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    int selectedColor = 3;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20, context: context)),
      child: Row(
        children: [
          Text(product.precio + "€", style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold
          )),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {disminuirCant();},
          ),
          SizedBox(width: getProportionateScreenWidth(20, context: context)),
          Text(_cantidad.toString()),
          SizedBox(width: getProportionateScreenWidth(20, context: context)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {aumentarCant();},
          ),
        ],
      ),
    );
  }
}
