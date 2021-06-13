import 'package:flutter/cupertino.dart';

BoxDecoration conisDelete(){
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF3F6B6C),
        Color(0xFF2E5066),
        Color(0xFF087163),
        Color(0xFF17395A),
      ],
      stops: [0.1, 0.4, 0.7, 0.9],
    ),
  );
}

BoxDecoration conisNormal(){
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF61A4A6),
        Color(0xFF61A4D8),
        Color(0xFF11FAD1),
        Color(0xFF398AE5),
      ],
      stops: [0.1, 0.4, 0.7, 0.9],
    ),
  );
}