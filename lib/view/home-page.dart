import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_web/color.dart';
import 'package:learn_web/view/Third-page.dart';
import 'package:learn_web/view/first/first-page.dart';
import 'package:learn_web/view/fourth-page.dart';
import 'package:learn_web/view/second-page.dart';

class AppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<AppPage> {

  int _currentIndex = 0;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new PageController(initialPage: _currentIndex,);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          FirstPage(),
          SecondPage(),
          ThirdPage(),
          FourthPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        iconSize: 24,
        onTap: _onTap,
        fixedColor: Color(themeColor),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: Text("主页"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text("游戏"), icon: Icon(Icons.games)),
          BottomNavigationBarItem(
              title: Text("消息"), icon: Icon(Icons.message)),
          BottomNavigationBarItem(
              title: Text("我的"), icon: Icon(Icons.people)),
        ],
      ),
    );
  }

  void _onTap(int index) {
    if (mounted) {
      setState(() {
        _currentIndex = index;
        _controller.jumpToPage(index);
      });
    }
  }
}
