import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:learn_web/route/application.dart';
import 'package:learn_web/route/routers.dart';
import 'package:learn_web/test/custom_view.dart';
import 'package:learn_web/test/eventbus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LayoutWidget extends StatefulWidget {
  @override
  LayoutState createState() => new LayoutState();
}

class LayoutState extends State<LayoutWidget>
    with WidgetsBindingObserver {


  var ccc;

  @override
  Widget build(BuildContext context) {
    ccc = context;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Layout"),
        backgroundColor: Colors.blue,
      ),
      body: wrapLayout,
    );
  }

  //流式布局
  Widget get wrapLayout {
    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      spacing: 10,
      runSpacing: 5,
      children: <Widget>[
        Chip(
          label: Text("艾伦"),
          avatar: CircleAvatar(
            backgroundImage: AssetImage("assets/ic_back.png"),),
          onDeleted: () {
            Application.router.navigateTo(ccc,
                '${Routes.test}?filePath=${Uri.encodeComponent(
                    "lib/test/net.dart")}');
          },
        ),
        Chip(
          label: Text("宝宝辅导费"),
          avatar: CircleAvatar(
              backgroundColor: Colors.black54, child: Text("B")),
        ),
        Chip(
          label: Text("次次次开关柜"),
          avatar: CircleAvatar(
              backgroundColor: Colors.black54, child: Text("C")),
        ),
        Chip(
          label: Text("d的高科技的考虑过"),
          avatar: CircleAvatar(
              backgroundColor: Colors.black54, child: Text("D")),
        ),
        Chip(
          label: Text("gdiandi"),
          avatar: CircleAvatar(
              backgroundColor: Colors.black54, child: Text("G")),
        )
      ],
    );
  }
}


//线性布局+弹性布局
Widget get getLinearLayout {
  return Container(
    margin: EdgeInsets.only(left: 16),
    color: Colors.green,
    child: new Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("121fgfg32"),
                  Text("4fgfgf")
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

//弹性布局
Widget get flexLayout {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 20,
      ),
      Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                height: 50,
                color: Colors.orange,
              )),
          Spacer(

          ),
          Expanded(
              flex: 2,
              child: Container(
                height: 50,
                color: Colors.black,
              ))
        ],
      )
    ],
  );
}


//箱子 限制类布局
Widget get constrainBox {
  return ConstrainedBox(
    constraints: BoxConstraints(
        minWidth: 200,
        maxHeight: 20
    ),
    child: Container(
      width: 50,
      height: 50,
      color: Colors.red,
    ),
  );
//  return SizedBox(
//    width: 50,
//    height: 50,
//    child: Container(
//      color: Colors.red,
//    ),
//  );
}

//装饰布局
Widget get decorateBox {
  return DecoratedBox(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 4.0,
          offset: Offset(2.0, 2.0),
        )
      ],
      gradient: LinearGradient(colors: [
        Colors.red, Colors.orange
      ]),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Text("login"),),
  );
}

//综合布局
Widget get container {
  return Container(
    margin: EdgeInsets.only(left: 80, top: 100),
    width: 150,
    height: 100,
    transform: Matrix4.rotationZ(0.2),
    decoration: BoxDecoration(
        boxShadow: [BoxShadow(
            color: Colors.black54,
            offset: Offset(2, 2),
            blurRadius: 4
        )
        ],
        borderRadius: BorderRadius.circular(8),
        gradient: RadialGradient(colors: [
          Colors.red, Colors.orange
        ], center: Alignment.topLeft,
            radius: .98
        )
    ),
    alignment: Alignment.center,
    child: Text("5.20",
      style: TextStyle(inherit: true, fontSize: 28, color: Colors.white),),
  );
}


//scrollView
Widget get scrollView {
  var str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  return Scrollbar(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
              children: str.split("").map((title) =>
                  Text(title, textScaleFactor: 3.0,)).toList()
          ),
        ),
      ));
}

//ListView
Widget get listView {
  return ListView.builder(
      itemCount: 100,
      itemExtent: 50,
      itemBuilder: (BuildContext context, int index) {
        return Text("$index", style: TextStyle(inherit: true, fontSize: 18),
          textAlign: TextAlign.center,);
      }
  );
}

Widget get listView2 {
  return ListView.separated(
      itemCount: 100,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.black54, height: 1,);
      },
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 16),
          height: 50,
          child: Text("$index", style: TextStyle(inherit: true, fontSize: 18))
          ,
        );
      }
  );
}


// TODO: 加载第一页的同时也会加载更多

class ListViewWidget extends StatefulWidget {

  @override
  ListViewState createState() => new ListViewState();
}

class ListViewState extends State<ListViewWidget>
    with WidgetsBindingObserver {

  static const loadingTag = "loading_end";

  bool haveMore = true;
  int page = 0;
  var _listData = <String>[loadingTag];

  bool firstLoad = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Layout"),
        backgroundColor: Colors.blue,
      ),
      body: listView3,
    );
  }

  Widget get listView3 {
    return ListView.separated(
        itemCount: _listData.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(color: Colors.grey, height: 1,),
        itemBuilder: (BuildContext context, int index) {
          if (firstLoad) {
            return null;
          }
          if (_listData[index] == loadingTag) {
            if (haveMore) {
              _loadData();
              return Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
              );
            } else {
              return Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text("没有更多了~",
                      style: TextStyle(color: Colors.grey, fontSize: 14))
              );
            }
          }
          return Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16),
              height: 40,
              child: Text(_listData[index] + "--$index",
                  style: TextStyle(inherit: true, fontSize: 18))
          );
        });
  }


  void _loadData() {
    if (page > 3) {
      haveMore = false;
    }
    page++;
    Future.delayed(Duration(seconds: 2)).then((i) {
      _listData.insertAll(_listData.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      firstLoad = false;
      setState(() {

      });
    });
  }
}


//GridView
Widget get gridView {
  return GridView(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1
    ),
//    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//        maxCrossAxisExtent: 100,
//        childAspectRatio: 1
//    ),
    children: <Widget>[
      Icon(Icons.map),
      Icon(Icons.list),
      Icon(Icons.cached),
      Icon(Icons.map),
      Icon(Icons.add),
      Icon(Icons.gamepad),
    ],
  );
}

//复合列表
class CustomScrollViewWidget extends StatefulWidget {

  @override
  CustomScrollViewState createState() => new CustomScrollViewState();
}

class CustomScrollViewState extends State<CustomScrollViewWidget>
    with WidgetsBindingObserver {

  bool haveMore = true;
  int page = 0;
  var _listData = <String>[loadingTag];
  static const loadingTag = "loading_end";
  bool firstLoad = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("测试"),
              collapseMode: CollapseMode.parallax,
              background: Image.asset(
                  "assets/ic_back.png", fit: BoxFit.cover),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((BuildContext context,
                    int index) {
                  return Container(
                    padding: EdgeInsets.all(6),
                    color: Colors.cyan[100 * (index % 9)],
                    alignment: Alignment.center,
                    child: Text("item$index"),
                  );
                }, childCount: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10
                )
            ),
          ),
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate((BuildContext context,
                  int index) {
                if (firstLoad) {
                  return null;
                }
                if (_listData[index] == loadingTag) {
                  if (haveMore) {
                    _loadData();
                    return Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                    );
                  } else {
                    return Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text("没有更多了~",
                            style: TextStyle(color: Colors.grey, fontSize: 14))
                    );
                  }
                }
                return new Container(
                  height: 50,
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: new Text('list item $index'),
                );
              }, childCount: _listData.length),
              itemExtent: 50)
        ],
      )
      ,
    );
  }

  void _loadData() {
    if (page > 3) {
      haveMore = false;
    }
    page++;
    Future.delayed(Duration(seconds: 2)).then((i) {
      _listData.insertAll(_listData.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      firstLoad = false;
      setState(() {

      });
    });
  }
}

//列表滚动控制、滚动百分比
class ScrollHomerWidget extends StatefulWidget {
  @override
  ScrollHomeState createState() => new ScrollHomeState();
}

class ScrollHomeState extends State<ScrollHomerWidget> {

  String title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bus.on("login", (arg) {
      print(arg);
    });
    title = "测试";
    AssetImage("assets/ic_back.png")
        .resolve(ImageConfiguration())
        .addListener((ImageInfo image, bool synchronousCall) {
      print(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("滚动控制"),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (BuildContext context) {
                        return new ScrollControllerWidget();
                      }
                  )
              );
            })
          ]
      ),
      body: TitleBar(title: title,
        onBack: () {
          setState(() {
            _readCounter().then((count) {
              title = "次数$count";
            });
          });
        },
        right: TitleBarRight(
            rightTitle: "编辑",
            onClickRight: () {
              setState(() {
                count++;
              });
              getFile().then((g) {
                print(g);
              });
//              _getFile().then((f) {
//                f.writeAsString("$count");
//              });
            }
        ),
      ),
    );
  }

  Future<String> getFile() async {
    String name = (await getExternalStorageDirectory()).path;
    return name;
  }

  int count = 0;

  Future<int> _readCounter() async {
    try {
      File file = await _getFile();
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  Future<File> _getFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/counter.txt');
  }

}

class ScrollControllerWidget extends StatefulWidget {

  @override
  ScrollControllerState createState() => new ScrollControllerState();
}

class ScrollControllerState extends State<ScrollControllerWidget> {

  bool showButton = false;

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset >= 800 && !showButton) {
        setState(() {
          showButton = true;
        });
      } else if (_controller.offset < 800 && showButton) {
        setState(() {
          showButton = false;
        });
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("列表"),
        backgroundColor: Colors.blue,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
//          print("${(progress * 100).toInt()}%");
        },
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.lightBlue[100 * (index % 9)],
              alignment: Alignment.center,
              child: Text("item$index"),
            );
          },
          itemCount: 100,
          itemExtent: 50,
          controller: _controller,
        ),
      ),
      floatingActionButton: !showButton ? null : FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          onPressed: () {
            bus.emit("login", 123);
//            _controller.jumpTo(0);
            _controller.animateTo(0,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease);
          }
      ),
    );
  }
}



