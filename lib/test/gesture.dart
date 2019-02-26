import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GestureWidget extends StatefulWidget {
  @override
  GestureState createState() => new GestureState();
}

class GestureState extends State<GestureWidget>
    with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("gesture"),
//        backgroundColor: Colors.blue,
//      ),
//      body:,
//    );
  }
}

class GestureScaleWidget extends StatefulWidget {
  @override
  GestureScaleState createState() => new GestureScaleState();
}

class GestureScaleState extends State<GestureScaleWidget> {

  double _width = 50.0; //通过修改图片宽度来达到缩放效果

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("gesture"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: GestureDetector(
          //指定宽度，高度自适应
          child: Image.asset("assets/icons/ic_my.png", width: _width),
          onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              //缩放倍数在0.8到10倍之间
              _width = 50 * details.scale.clamp(.5, 2.0);
            });
          },
        ),
      ),
    );
  }
}
