import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_web/utils/net_utils.dart';
import 'package:learn_web/view/first_page_item.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstPageState();
  }
}

class _FirstPageState extends State<FirstPage> {
  ScrollController _scrollController = new ScrollController();

  List items = new List();
  int _pageIndex = 0;
  int _pageTotal = 0;
  bool _hasMore = true;
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    _getMoreData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.separated(
          controller: _scrollController,
          itemCount: items.length + 1,
          separatorBuilder: (BuildContext context, int index) =>
              Divider(
                color: Colors.grey,
                height: 1,
              ),
          itemBuilder: (BuildContext context, int index) {
            if (index == items.length) {
              return _LoadMoreWidget();
            } else {
              return _listViewItem(items[index]);
            }
          },
        ));
  }

  Widget _LoadMoreWidget() {
    if (_hasMore) {
      return Container(
          alignment: Alignment.center,
          height: 50,
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ));
    } else {
      return Container(
          alignment: Alignment.center,
          height: 40,
          child: Text("没有更多了~",
              style: TextStyle(color: Colors.grey, fontSize: 14)));
    }
  }

  Widget _listViewItem(item) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 16),
      child: Text("${item.title}"),
    );
  }

  Future<Null> _refresh() async {
    List data = await httpRequest();
    if (this.mounted) {
      setState(() {
        items.clear();
        items.addAll(data);
        isLoading = false;
        _hasMore = true;
        return null;
      });
    }
  }

  Future _getMoreData() async {
    if (!isLoading && _hasMore) {
      // 如果上一次异步请求数据完成 同时有数据可以加载
      if (mounted) {
        setState(() => isLoading = true);
      }
      //if(_hasMore){ // 还有数据可以拉新
      List newEntries = await httpRequest();
      //if (newEntries.isEmpty) {
      _hasMore = (_pageIndex <= _pageTotal);
      if (this.mounted) {
        setState(() {
          items.addAll(newEntries);
          isLoading = false;
        });
      }
    } else if (!isLoading && !_hasMore) {
      // 这样判断,减少以后的绘制
      _pageIndex = 0;
    }
  }


  Future<List> httpRequest() async {
    final listObj = await requestApi(params: {'pageIndex': _pageIndex});
    _pageIndex = listObj['pageIndex'];
    _pageTotal = listObj['total'];
    return listObj['list'];
  }

  Future<Map> requestApi({Map<String, dynamic>params}) async {
    const url = 'https://timeline-merger-ms.juejin.im/v1/get_tag_entry?src=web&tagId=5a96291f6fb9a0535b535438';
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    final _param  = {'page':pageIndex,'pageSize':20,'sort':'rankIndex'};
    var responseList = [];
    var  pageTotal = 0;

    try{
      var response = await NetUtils.get(url, params: _param);
      responseList = response['d']['entrylist'];
      pageTotal = response['d']['total'];
      if (!(pageTotal is int) || pageTotal <= 0) {
        pageTotal = 0;
      }
    }catch(e){
      print("$e");
    }
    pageIndex += 1;
    List resultList = new List();
    for (int i = 0; i < responseList.length; i++) {
      try {
        FirstPageItem cellData = new FirstPageItem.fromJson(responseList[i]);
        resultList.add(cellData);
      } catch (e) {
        // No specified type, handles all
      }
    }
    Map<String, dynamic> result = {"list":resultList, 'total':pageTotal, 'pageIndex':pageIndex};
    return result;
  }
}
