import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_web/test/layout.dart';

class FourthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FourthPageState();
  }
}

class _FourthPageState extends State<FourthPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: Text("fourth"),
      ),
    );
  }

}