import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RiveTest extends StatefulWidget {
  RiveTest({Key key}) : super(key: key);

  @override
  _RiveTestState createState() => _RiveTestState();
}

class _RiveTestState extends State<RiveTest> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xff6424FF),
      child: FlareActor(
        "assets/test.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "Untitled",
      ),
    );
  }
}
