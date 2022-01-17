// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:jd_project/utils/Stroage.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/utils/searchUtils.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keyWords;
  List _historyListData = [];
  @override
  void initState() {
    super.initState();
    _getHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      top: AutoSize.h(35),
                      left: AutoSize.w(28),
                      right: AutoSize.w(20)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26),
                      borderSide: BorderSide.none)),
              onChanged: (val) {
                setState(() {
                  _keyWords = val;
                });
              },
            ),
            height: AutoSize.h(60),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(26)),
          ),
          actions: [
            InkWell(
              child: SizedBox(
                height: AutoSize.h(60),
                width: AutoSize.w(80),
                child: Row(
                  children: [Text('搜索')],
                ),
              ),
              onTap: () async {
                await SearchUtils.setHistoryData(_keyWords);
                Navigator.of(context).pushReplacementNamed('/productList',
                    arguments: {'keywords': _keyWords});
              },
            )
          ]),
      body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Text(
                '热搜',
                style: Theme.of(context).textTheme.headline6,
              ),
              Divider(),
              Wrap(children: [
                Container(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('女装'),
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('儿童玩具'),
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('男装'),
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('笔记本电脑'),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              _historyListData.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                            '历史记录',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Divider(),
                          Column(
                            children: _historyListData.map((item) {
                              return Column(children: [
                                ListTile(
                                  trailing: IconButton(
                                    onPressed: () {
                                      _showAlertDialog("$item");
                                    },
                                    icon: Icon(Icons.clear_outlined),
                                  ),
                                  title: Text('$item'),
                                ),
                                Divider()
                              ]);
                            }).toList(),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: InkWell(
                              onTap: () async {
                                await SearchUtils.clearHistory();
                                _getHistoryData();
                              },
                              child: Container(
                                width: AutoSize.w(400),
                                height: AutoSize.h(64),
                                // decoration: BoxDecoration(
                                //     border: Border.all(
                                //         color:
                                //             Color.fromRGBO(233, 233, 233, 0.9),
                                //         width: 1)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.delete),
                                    Text('清空历史记录')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ])
                  : Text('')
            ],
          )),
    );
  }

  // 获取历史搜索
  void _getHistoryData() async {
    var historyListData = await SearchUtils.getHistoryList();
    setState(() {
      _historyListData = historyListData;
    });
  }

  void _showAlertDialog(String keyword) async {
    await showDialog(
        barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: Text('提示信息！'),
            content: Text('确定要删除该记录吗?'),
            actions: [
              TextButton(
                  onPressed: () async {
                    await SearchUtils.removeHistoryData(keyword);
                    _getHistoryData();
                    Navigator.of(context).pop();
                  },
                  child: Text('确定', style: TextStyle(color: Colors.red))),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('取消', style: TextStyle(color: Colors.black87)))
            ],
          );
        });
  }
}
