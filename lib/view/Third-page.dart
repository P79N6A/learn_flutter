import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_web/test/layout.dart';

class ThirdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ThirdPageState();
  }
}

class _ThirdPageState extends State<ThirdPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: Text("third"),
      ),
    );
  }

}