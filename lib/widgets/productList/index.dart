// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/config/index.dart';
import 'package:jd_project/model/ProductModel.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/widgets/Loading/index.dart';

class ProductList extends StatefulWidget {
  // 接收参数
  Map? arguments;
  ProductList({Key? key, this.arguments}) : super(key: key);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // 全局scaffoldkey
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //分页
  int _page = 1;
  final int _pageSize = 8;

  //数据
  List _productList = [];

  /*
  排序:价格升序 sort=price_1 价格降序 sort=price_-1  销量升序 sort=salecount_1 销量降序 sort=salecount_-1
  */
  String _sort = "";

  // 避免多次加载数据 重复请求
  bool flag = true;

  //是否有数据
  bool _hasMore = true;

  //分类或者搜索关键词下面是否有数据
  bool _hasData = true;

  // 上拉分页
  ScrollController _scrollController = ScrollController(); //listView的控制器

  /*二级导航数据*/
  final List _subHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          -1, //排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"}
  ];
  //二级导航选中判断
  int _selectHeaderId = 1;

  @override
  void initState() {
    super.initState();
    _getProductListData();
    // 监听滚动
    _scrollController.addListener(() {
      var scrollH = _scrollController.position.pixels; //滚动条滚动的高度
      var pageH = _scrollController.position.maxScrollExtent; //页面的高度
      if (scrollH > pageH - 20) {
        if (flag && _hasMore) {
          _getProductListData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('商品列表'), actions: [Text('')]),
        endDrawer: Drawer(
          child: Container(child: Text('筛选')),
        ),
        body: Stack(
          children: [_productListWidget(), _subHeader()],
        ));
  }

  // 筛选导航
  Widget _subHeader() {
    return Positioned(
        top: 0,
        height: AutoSize.h(80),
        width: AutoSize.w(750),
        child: Container(
          height: AutoSize.h(80),
          width: AutoSize.w(750),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
          child: Row(
            children: _subHeaderList.map((value) {
              return Expanded(
                flex: 1,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, AutoSize.h(16), 0, AutoSize.h(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${value["title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: (_selectHeaderId == value["id"])
                                  ? Colors.red
                                  : Colors.black54),
                        ),
                        _showIcon(value["id"])
                      ],
                    ),
                  ),
                  onTap: () {
                    _subHeaderChange(value["id"]);
                  },
                ),
              );
            }).toList(),
          ),
        ));
  }

  //显示header Icon
  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      if (_subHeaderList[id - 1]["sort"] == 1) {
        return Icon(Icons.arrow_drop_down);
      }
      return Icon(Icons.arrow_drop_up);
    }
    return Text("");
  }

  // 商品列表
  Widget _productListWidget() {
    if (_productList.isNotEmpty) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: AutoSize.h(80)),
        child: ListView.builder(
            controller: _scrollController,
            itemCount: _productList.length,
            itemBuilder: (ctx, index) {
              String pic = _productList[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: AutoSize.w(180),
                        height: AutoSize.h(180),
                        child: Image.network(
                          pic,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: AutoSize.h(180),
                            margin: EdgeInsets.only(left: AutoSize.w(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_productList[index].title}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        height: AutoSize.h(36),
                                        padding: EdgeInsets.fromLTRB(
                                            AutoSize.w(10),
                                            AutoSize.h(6),
                                            AutoSize.w(10),
                                            0),
                                        margin: EdgeInsets.only(
                                            right: AutoSize.w(10)),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color.fromRGBO(
                                                230, 230, 230, 0.9)),
                                        child: Text('4G'))
                                  ],
                                ),
                                Text(
                                  '￥${_productList[index].price}',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                  Divider(
                    height: AutoSize.h(24),
                  ),
                  // 加载框
                  _showMore(index)
                ],
              );
            }),
      );
    } else {
      return LoadingWidget();
    }
  }

  // 底部加载框
  Widget _showMore(index) {
    bool equalLen = index == _productList.length - 1;
    if (_hasMore) {
      return equalLen ? LoadingWidget() : Text('');
    } else {
      return equalLen ? Text('--- 我是有底线的 ---') : Text('');
    }
  }

  //导航改变的时候触发
  _subHeaderChange(id) {
    if (id == 4) {
      _scaffoldKey.currentState!.openEndDrawer();
      setState(() {
        _selectHeaderId = id;
      });
    } else {
      setState(() {
        _selectHeaderId = id;
        _sort =
            "${_subHeaderList[id - 1]["fileds"]}_${_subHeaderList[id - 1]["sort"]}";

        //重置分页
        _page = 1;
        //重置数据
        _productList = [];
        //改变sort排序
        _subHeaderList[id - 1]['sort'] = _subHeaderList[id - 1]['sort'] * -1;
        //回到顶部  需要判断是否有数据  有数据回到顶部
        if (_hasData) {
          _scrollController.jumpTo(0);
        }
        //重置_hasMore
        _hasMore = true;
        //重新请求
        _getProductListData();
      });
    }
  }

  void _getProductListData() async {
    setState(() {
      flag = false;
    });
    var api =
        '${Config.domain}api/plist?cid=${widget.arguments!["cid"]}&page=${_page}&sort=${_sort}&pageSize=${_pageSize}';
    var result = await Dio().get(api);
    var productList = ProductModel.fromJson(result.data);
    if (productList.result!.length < _pageSize) {
      setState(() {
        _productList.addAll(productList.result ?? []);
        _hasMore = false;
        flag = true;
      });
    } else {
      setState(() {
        _productList.addAll(productList.result ?? []);
        _page++;
        flag = true;
      });
    }
  }
}
