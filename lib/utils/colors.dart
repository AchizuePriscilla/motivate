import 'package:flutter/material.dart';

RandGrad randGradient(String uid) {
  if (uid != null) {
    var n = uid.hashCode;
    var c1 = HSLColor.fromAHSL(1, (n % 360).floorToDouble(), 0.95, 0.5);
    var _c1 = c1.toColor();
    var c2 = Color(0xffffff ^ c1.toColor().value);

    return RandGrad(c1: _c1, c2: c2);
  }
  return null;
}

class RandGrad {
  final Color c1, c2;

  RandGrad({this.c1, this.c2});
}
