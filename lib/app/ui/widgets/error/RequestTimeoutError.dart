// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class RequestTimeoutErrorWidget extends StatelessWidget {
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
              "assets/images/error-timeout.png",
              width: size.width * 0.80,
            ),
          ),
          Positioned(
            left: 50,
            top: size.height * 0.45,
            right: size.width * 0.40,
            child: Text("No hubo respuesta en el tiempo esperado",
                style: context.textTheme.subtitle1.merge(TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w700))),
          ),
          Positioned.fill(
            top: size.height * 0.55,
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
