// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class UnderConstructionErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: size.height * 0.15,
            left: 60,
            child: Image.asset(
              "assets/images/error-under-construction.png",
              width: size.width * 0.70,
            ),
          ),
          Positioned(
            left: size.width * 0.20,
            top: size.height * 0.65,
            right: size.width * 0.05,
            child: Text("Estamos trabajando en ello\nDisculpe las molestias",
                style: context.textTheme.subtitle1.merge(TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.w700))),
          ),
        ],
      ),
    );
  }
}
