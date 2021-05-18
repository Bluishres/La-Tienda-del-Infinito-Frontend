import 'package:flutter/material.dart';
import 'package:shopend/app/ui/widgets/_widgets.dart';

class UnderConstructionErrorPage extends StatelessWidget {
  final String msg;

  const UnderConstructionErrorPage({Key key, this.msg=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("En obras"),
      ),
      body: Stack(
        children: <Widget>[
          UnderConstructionErrorWidget(),
        ],
      ),
    );
  }
}
