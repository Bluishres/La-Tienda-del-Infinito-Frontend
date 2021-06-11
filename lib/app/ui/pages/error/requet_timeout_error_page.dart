// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopend/app/ui/widgets/_widgets.dart';

class RequetTimeoutErrorPage extends StatefulWidget {
  @override
  _RequetTimeoutErrorPageState createState() => _RequetTimeoutErrorPageState();
}

class _RequetTimeoutErrorPageState extends State<RequetTimeoutErrorPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tiempo agotado"),
      ),
      body: Stack(
        children: <Widget>[
          RequestTimeoutErrorWidget(),
        ],
      ),
    );
  }
}
