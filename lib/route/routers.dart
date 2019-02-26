import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:learn_web/test/test.dart';
import 'package:learn_web/view/home-page.dart';

class Routes {
  static String root = "/";
  static String home = "/home";


  static String test = '/test';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context,
        Map<String, List<String>> params) {});
    router.define(home, handler: homeHandler);

    router.define(test, handler: testHandler);
  }
}

// app的首页
var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new AppPage();
  },
);

var testHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String filePath = params["filePath"]?.first;
    return new TestWidget(filePath: filePath);
  },
);

