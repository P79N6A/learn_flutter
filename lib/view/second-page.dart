import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_web/test/layout.dart';

class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SecondPageState();
  }
}

class _SecondPageState extends State<SecondPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: Text("second"),
      ),
    );
  }

}