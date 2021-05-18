import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopend/app/ui/widgets/_widgets.dart';

class RequetErrorPage extends StatefulWidget {
  final String msg;

  const RequetErrorPage({Key key, this.msg=""}) : super(key: key);

  @override
  _RequetErrorPageState createState() => _RequetErrorPageState();
}

class _RequetErrorPageState extends State<RequetErrorPage> {

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
  dispose(){
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Algo fue mal"),
      ),
      body: Stack(
        children: <Widget>[
          RequestErrorWidget(msg: widget.msg),
        ],
      ),
    );
  }
}
