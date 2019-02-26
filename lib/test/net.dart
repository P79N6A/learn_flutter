import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class NetWidget extends StatefulWidget {
  @override
  NetState createState() => new NetState();
}

class NetState extends State<NetWidget>
    with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Net"),
        backgroundColor: Colors.blue,
      ),
      body: new HttpTestRoute(),
    );
  }
}


class HttpTestRoute extends StatefulWidget {
  @override
  _HttpTestRouteState createState() => new _HttpTestRouteState();
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          RaisedButton(
              child: Text("获取"),
              onPressed: _loading ? null : () async {
                setState(() {
                  _loading = true;
                  _text = "正在请求...";
                });
                try {
                  getHttp();
                } catch (e) {
                  print("请求失败：$e");
                } finally {
                  setState(() {
                    _loading = false;
                  });
                }
              }
          ),
          Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 50.0,
              child: Text(_text.replaceAll(new RegExp(r"\s"), ""))
          )
        ],
      ),
    );
  }

  Future getHttp() async {
    var dio = new Dio(new Options(
        baseUrl: "http://10.221.1.185:7201/",
        connectTimeout: 10000,
        receiveTimeout: 10000,
        contentType: ContentType.json,
        responseType: ResponseType.PLAIN,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        }
    ));


    Map<String, Object> hashMap = new Map();
    List<MapEntry<String, Object>>list;

    Map<String, Object> headParams = new Map();
    list = new List();
    list.add(MapEntry("SERVICE_ID", "SH.786012"));
    list.add(MapEntry("SERIAL", "1214124"));
    headParams.addEntries(list);
    list = new List();
    list.add(MapEntry("REQ_MSG_HDR", headParams));
    hashMap.addEntries(list);

    Map<String, Object> bodyParams = new Map();
    list = new List();
    list.add(MapEntry("SERVICE_ID", "SH.786012"));
    list.add(MapEntry("F_FUNCTION", "SH.786012"));
    list.add(MapEntry("F_OP_USER", ""));
    list.add(MapEntry("F_OP_ROLE", "1"));
    list.add(MapEntry("F_OP_SITE", "getLocalIpAddress"));
    list.add(MapEntry("F_CHANNEL", "3"));
    list.add(MapEntry("TERM_TYPE", "1"));
    list.add(MapEntry("IS_VALID", "1"));
    bodyParams.addEntries(list);
    list = new List();
    list.add(MapEntry("REQ_COMM_DATA", bodyParams));
    hashMap.addEntries(list);

    list = new List();
    List tempList = new List();
    tempList.add(hashMap);
    list.add(MapEntry("REQUESTS", tempList));

    Map<String, Object> map = new Map();
    map.addEntries(list);

    String body = jsonEncode(map);
    print("wu-----body=$body");

    CancelToken cancelToken = new CancelToken();
    Response<String> response = await dio.post(
        "kesb_req/", data: body, cancelToken: cancelToken);
    print(response.data);
    cancelToken.cancel("f");
  }


  Future testNet() async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request;
    request =
    await httpClient.post("10.221.1.185", 7201, "kesb_req");
    request.headers.add("Content-Type", "application/json");
    request.headers.add("Accept", "application/json");


    Map<String, Object> hashMap = new Map();
    List<MapEntry<String, Object>>list;

    Map<String, Object> headParams = new Map();
    list = new List();
    list.add(MapEntry("SERVICE_ID", "SH.786012"));
    list.add(MapEntry("SERIAL", "1214124"));
    headParams.addEntries(list);
    list = new List();
    list.add(MapEntry("REQ_MSG_HDR", headParams));
    hashMap.addEntries(list);

    Map<String, Object> bodyParams = new Map();
    list = new List();
    list.add(MapEntry("SERVICE_ID", "SH.786012"));
    list.add(MapEntry("F_FUNCTION", "SH.786012"));
    list.add(MapEntry("F_OP_USER", ""));
    list.add(MapEntry("F_OP_ROLE", "1"));
    list.add(MapEntry("F_OP_SITE", "getLocalIpAddress"));
    list.add(MapEntry("F_CHANNEL", "3"));
    list.add(MapEntry("TERM_TYPE", "1"));
    list.add(MapEntry("IS_VALID", "1"));
    bodyParams.addEntries(list);
    list = new List();
    list.add(MapEntry("REQ_COMM_DATA", bodyParams));
    hashMap.addEntries(list);

    list = new List();
    List tempList = new List();
    tempList.add(hashMap);
    list.add(MapEntry("REQUESTS", tempList));

    Map<String, Object> map = new Map();
    map.addEntries(list);

    String body = jsonEncode(map);
    print("wu-----body=$body");


    request.add(utf8.encode(body));

    HttpClientResponse response = await request.close();
    _text = await response.transform(utf8.decoder).join();
    String responseBody = jsonDecode(_text);

    var code = response.statusCode;
    print("code=$code");
    print("responseBody=$responseBody");

    httpClient.close();
  }


}