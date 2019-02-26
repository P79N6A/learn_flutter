import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:learn_web/color.dart';
import 'package:learn_web/route/application.dart';
import 'package:learn_web/route/routers.dart';
import 'package:learn_web/view/home-page.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {

  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Color(themeColor),
      ),
      home: new Scaffold(
          body: AppPage()
      ),
    );
  }

}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//        title: 'Welcome to Flutter',
//        home: new RandomWight(),
//        theme: new ThemeData(primaryColor: Colors.blue)
//
//
////      home: new Scaffold(
////        appBar: new AppBar(
////          title: new Text('Welcome to Flutter'),
////        ),
////        body: new Center(
//////          child: new Text('Hello World1'),
////        child: new RandomWord(),
////        ),
////      ),
//        );
//  }
//}
//
//class RandomWight extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => new RandomWightState();
//}
//
//class RandomWightState extends State<RandomWight> {
//  final _suggestions = <WordPair>[];
//  final _biggerFont = const TextStyle(fontSize: 18);
//  final _saved = new Set<WordPair>();
//
//  @override
//  Widget build(BuildContext context) {
////    return new Text(new WordPair.random().asPascalCase);
//    return new Scaffold(
//      appBar: new AppBar(title: new Text('fuckyou'), actions: <Widget>[
//        new IconButton(
//            icon: new Icon(
//              Icons.list,
//              color: Colors.white,
//            ),
//            onPressed: _click)
//      ]),
//      body: _buildSuggestions(),
//    );
//  }
//
//  Widget _buildSuggestions() {
//    return new ListView.builder(
//        padding: const EdgeInsets.all(10),
//        // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
//        // 在偶数行，该函数会为单词对添加一个ListTile row.
//        // 在奇数行，该行书湖添加一个分割线widget，来分隔相邻的词对。
//        itemBuilder: (context, i) {
//          // 在每一列之前，添加一个1像素高的分隔线widget
//          if (i.isOdd) return new Divider();
//          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
//          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
//          final index = i ~/ 2;
//          // 如果是建议列表中最后一个单词对
//          if (index >= _suggestions.length) {
//            // ...接着再生成10个单词对，然后添加到建议列表
//            _suggestions.addAll(generateWordPairs().take(10));
//          }
//          return _buildRow(_suggestions[index]);
//        });
//  }
//
//  Widget _buildRow(WordPair pair) {
//    final alreadySaved = _saved.contains(pair);
//    return new ListTile(
//        title: new Text(pair.asPascalCase, style: _biggerFont),
//        trailing: new Icon(
//            alreadySaved ? Icons.favorite : Icons.favorite_border,
//            color: alreadySaved ? Colors.red : null),
//        onTap: () {
//          setState(() {
//            if (alreadySaved) {
//              _saved.remove(pair);
//            } else {
//              _saved.add(pair);
//            }
//          });
//        });
//  }
//
//  void _click() {
//    Navigator.push(context, new MaterialPageRoute(builder: (context) {
//      final tiles = _saved.map(
//        (text) {
//          return new ListTile(
//            title: new Text(
//              text.asPascalCase,
//              style: _biggerFont,
//            ),
//          );
//        },
//      );
//      final divides =
//          ListTile.divideTiles(tiles: tiles, context: context).toList();
//
//      return new Detail(divides);
////      return new Scaffold(
////          appBar: new AppBar(title: new Text("收藏")),
////          body: new ListView(children: divides));
//    }));
//  }
//}
//
//class Detail extends StatefulWidget {
//  final list;
//
//  Detail(this.list);
//
//  @override
//  State<StatefulWidget> createState() => new DetailState(list);
//}
//
//class DetailState extends State<Detail> {
//  final data;
//  DetailState(this.data);
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(title: new Text("收藏")),
//      body: new ListView(children: data),
//    );
//  }
//}
//
//
////        appBar: new AppBar(
////          title: new Text('Welcome to Flutter'),
////        ),
////        body: new Center(
//////          child: new Text('Hello World1'),
////        child: new RandomWord(),
////        ),
////      ),
//        );
//  }
//}
//
//class RandomWight extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => new RandomWightState();
//}
//
//class RandomWightState extends State<RandomWight> {
//  final _suggestions = <WordPair>[];
//  final _biggerFont = const TextStyle(fontSize: 18);
//  final _saved = new Set<WordPair>();
//
//  @override
//  Widget build(BuildContext context) {
////    return new Text(new WordPair.random().asPascalCase);
//    return new Scaffold(
//      appBar: new AppBar(title: new Text('fuckyou'), actions: <Widget>[
//        new IconButton(
//            icon: new Icon(
//              Icons.list,
//              color: Colors.white,
//            ),
//            onPressed: _click)
//      ]),
//      body: _buildSuggestions(),
//    );
//  }
//
//  Widget _buildSuggestions() {
//    return new ListView.builder(
//        padding: const EdgeInsets.all(10),
//        // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
//        // 在偶数行，该函数会为单词对添加一个ListTile row.
//        // 在奇数行，该行书湖添加一个分割线widget，来分隔相邻的词对。
//        itemBuilder: (context, i) {
//          // 在每一列之前，添加一个1像素高的分隔线widget
//          if (i.isOdd) return new Divider();
//          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
//          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
//          final index = i ~/ 2;
//          // 如果是建议列表中最后一个单词对
//          if (index >= _suggestions.length) {
//            // ...接着再生成10个单词对，然后添加到建议列表
//            _suggestions.addAll(generateWordPairs().take(10));
//          }
//          return _buildRow(_suggestions[index]);
//        });
//  }
//
//  Widget _buildRow(WordPair pair) {
//    final alreadySaved = _saved.contains(pair);
//    return new ListTile(
//        title: new Text(pair.asPascalCase, style: _biggerFont),
//        trailing: new Icon(
//            alreadySaved ? Icons.favorite : Icons.favorite_border,
//            color: alreadySaved ? Colors.red : null),
//        onTap: () {
//          setState(() {
//            if (alreadySaved) {
//              _saved.remove(pair);
//            } else {
//              _saved.add(pair);
//            }
//          });
//        });
//  }
//
//  void _click() {
//    Navigator.push(context, new MaterialPageRoute(builder: (context) {
//      final tiles = _saved.map(
//        (text) {
//          return new ListTile(
//            title: new Text(
//              text.asPascalCase,
//              style: _biggerFont,
//            ),
//          );
//        },
//      );
//      final divides =
//          ListTile.divideTiles(tiles: tiles, context: context).toList();
//
//      return new Detail(divides);
////      return new Scaffold(
////          appBar: new AppBar(title: new Text("收藏")),
////          body: new ListView(children: divides));
//    }));
//  }
//}
//
//class Detail extends StatefulWidget {
//  final list;
//
//  Detail(this.list);
//
//  @override
//  State<StatefulWidget> createState() => new DetailState(list);
//}
//
//class DetailState extends State<Detail> {
//  final data;
//  DetailState(this.data);
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(title: new Text("收藏")),
//      body: new ListView(children: data),
//    );
//  }
//}


//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:learn_web/layout.dart';
//import 'package:learn_web/gesture.dart';
//import 'package:learn_web/net.dart';
//
//void main() => runApp(new MyApp());
//
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Learn',
//      theme: new ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: new NetWidget(),
//    );
//  }
//}

