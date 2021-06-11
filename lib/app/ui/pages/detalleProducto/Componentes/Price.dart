// @dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/common/utils/size_config.dart';
import 'package:shopend/app/domain/model/Producto.dart';

import 'RoundedIconBtn.dart';

class Price extends StatefulWidget {
  final Function Actualizarcantidad;
  Producto product;

  Price({
    Key key,
    this.product, this.Actualizarcantidad,
  }) : super(key: key);

  @override
  _PriceState createState() => _PriceState();
}

class _PriceState extends State<Price> {
  Producto product;
  Function Actualizarcantidad;
  int _cantidad = 1;
  double _Price;
  var f = NumberFormat("###.0#", "en_US");

  @override
  void initState() {
    super.initState();
    product = widget.product;
    Actualizarcantidad = widget.Actualizarcantidad;
    setState(() {
      _Price = double.parse(product.precio) * _cantidad;
    });
  }

  void aumentarCant() {
    if(_cantidad <product.stockDisponible){
    setState(() {
      _cantidad++;
    });
    Actualizarcantidad(_cantidad);
    setState(() {
      _Price = double.parse(product.precio) * _cantidad;
    });}else{
      SuccessToast("No se puede sobrepasar el stock disponible.");
    }
  }

  void disminuirCant() {
    if (_cantidad > 1) {
      setState(() {
        _cantidad--;
      });
      Actualizarcantidad(_cantidad);
      setState(() {
        _Price = double.parse(product.precio) * _cantidad;
      });
    } else {
      SuccessToast("No se puede disminuir mas cantidad.");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    int selectedColor = 3;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20, context: context)),
      child: Row(
        children: [
          Text(f.format(_Price).toString() + "€",
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              disminuirCant();
            },
          ),
          SizedBox(width: getProportionateScreenWidth(20, context: context)),
          Text(_cantidad.toString()),
          SizedBox(width: getProportionateScreenWidth(20, context: context)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              aumentarCant();
            },
          ),
        ],
      ),
    );
  }
}
