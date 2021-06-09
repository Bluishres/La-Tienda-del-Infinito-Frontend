// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shopend/app/common/utils/size_config.dart';

class DefaultButton extends StatefulWidget {
  String text;
  Function press;
  DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);

  @override
  _DefaultButtonState createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  String text;
  Function press;

  @override
  void initState() {
    super.initState();
    text = widget.text;
    press = widget.press;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56, context: context),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Color.fromRGBO(240, 165, 165, 4.0),
        hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18, context: context),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
