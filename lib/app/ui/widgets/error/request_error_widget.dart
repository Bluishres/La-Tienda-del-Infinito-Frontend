// @dart=2.9
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class RequestErrorWidget extends StatelessWidget {
  final String msg;
  final bool showButtonRetry;

  const RequestErrorWidget({Key key, this.msg = "Algo fue mal", this.showButtonRetry = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: size.height * 0.07,
            left: 60,
            child: Image.asset(
              "assets/images/error-robot.png",
              width: size.width * 0.80,
            ),
          ),
          Positioned(
            left: 50,
            top: size.height * 0.50,
            right: size.width * 0.40,
            child: Text("Ocurrió un error",
                style: context.textTheme.subtitle1
                    .merge(TextStyle(color: Colors.blueGrey, fontSize: 17, fontWeight: FontWeight.w800))),
          ),
          Positioned(
            left: 60,
            top: size.height * 0.55,
            right: size.width * 0.10,
            child: Text(msg,
                style: context.textTheme.subtitle1.merge(TextStyle(color: Colors.grey, fontWeight: FontWeight.w800))),
          ),
          if (showButtonRetry)
            Positioned.fill(
              top: size.height * 0.60,
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: Text("Reintentar"),
                  onPressed: () => Navigator.of(context).pop<int>(-1),
                ),
              ),
            )
        ],
      ),
    );
  }
}
