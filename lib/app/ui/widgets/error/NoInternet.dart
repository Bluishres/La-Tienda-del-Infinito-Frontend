// @dart=2.9
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopend/app/data/provider/ConectivityProvider.dart';
import 'package:shopend/app/locator.dart';
import 'package:velocity_x/velocity_x.dart';

class NoInternetWidget extends StatefulWidget {
  @override
  _NoInternetWidgetState createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  Stream<ConnectivityStatus> _streamConnectiviyChanged;

  @override
  void initState() {
    super.initState();
    _streamConnectiviyChanged = locator<ConnectivityService>().subscribe();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<ConnectivityStatus>(
        stream: _streamConnectiviyChanged,
        builder: (context, connectivityState) {
          bool internetConnection = false;
          if (connectivityState.hasData &&
              (connectivityState.data == ConnectivityStatus.Cellular ||
                  connectivityState.data == ConnectivityStatus.WiFi)) {
            Timer(Duration(milliseconds: 500),
                () => Navigator.of(context).pop<int>(-1));
            internetConnection = true;
          }

          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    "assets/images/NoInternet.png",
                    width: size.width * 0.80,
                  ),
                ),
                Text("Error de conexión",
                    style: context.textTheme.headline6.merge(TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800))),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      "¿Has comprobado que estás conectado a una red Wifi o que tienes los datos activados?",
                      style: context.textTheme.subtitle1.merge(TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w700))),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: Text("Reintentar"),
                  onPressed: internetConnection
                      ? () => Navigator.of(context).pop<int>(-1)
                      : null,
                )
              ],
            ),
          );
        });
  }
}
