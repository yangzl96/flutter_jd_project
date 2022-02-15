// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:jd_project/pages/product_detail/product_detail_comment.dart';
import 'package:jd_project/pages/product_detail/product_detail_info.dart';
import 'package:jd_project/pages/product_detail/product_detail_main.dart';
import 'package:jd_project/provider/Cart.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/utils/cart.dart';
import 'package:jd_project/utils/eventBus.dart';
import 'package:jd_project/utils/toast.dart';
import 'package:jd_project/widgets/button/index.dart';
import 'package:jd_project/config/index.dart';
import 'package:dio/dio.dart';
import 'package:jd_project/model/ProductContentModel.dart';
import 'package:jd_project/widgets/loading/index.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  Map arguments;
  ProductDetailPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List _productContentList = [];
  @override
  void initState() {
    super.initState();
    _getContentData();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 16);
    var cartProvider = Provider.of<Cart>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          // tab可以在 appBar-bottom 这是二级tabs
          // 也可以在title中，是一级tabs
          appBar: AppBar(
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: AutoSize.w(400),
                child: TabBar(
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      child: Text('商品', style: textStyle),
                    ),
                    Tab(
                      child: Text('详情', style: textStyle),
                    ),
                    Tab(
                      child: Text('评价', style: textStyle),
                    ),
                  ],
                ),
              ),
            ]),
            actions: [
              IconButton(
                  onPressed: () {
                    showMenu(
                        context: context,
                        position:
                            RelativeRect.fromLTRB(AutoSize.w(400), 86, 8, 0),
                        items: [
                          PopupMenuItem(
                              child: Row(
                            children: [Icon(Icons.home), Text('首页')],
                          )),
                          PopupMenuItem(
                              child: Row(
                            children: [Icon(Icons.search), Text('搜索')],
                          ))
                        ]);
                  },
                  icon: Icon(Icons.more_horiz))
            ],
          ),
          body: SafeArea(
            child: _productContentList.isNotEmpty
                ? Stack(
                    children: [
                      TabBarView(
                        physics: NeverScrollableScrollPhysics(), //禁止左右滑动（详情页上下滑动的时候可能会造成tabbar左右滑动）
                        children: [
                        //商品
                        ProductDetailMain(_productContentList),
                        //详情
                        ProductDetailInfo(_productContentList),
                        //评价
                        ProductDetailComment(),
                      ]),
                      Positioned(
                          width: AutoSize.w(750),
                          height: AutoSize.h(88),
                          bottom: 0,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      top: BorderSide(
                                          width: 1, color: Colors.black26))),
                              child: Row(children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/cart');
                                  },
                                  child: Container(
                                      padding:
                                          EdgeInsets.only(top: AutoSize.h(4)),
                                      height: AutoSize.h(84),
                                      width: AutoSize.w(120),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.shopping_cart,
                                            size: AutoSize.sp(36),
                                          ),
                                          Text(
                                            '购物车',
                                            style: TextStyle(
                                                fontSize: AutoSize.sp(22)),
                                          )
                                        ],
                                      )),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: ButtonWidget(
                                        color: Color.fromRGBO(253, 1, 0, 0.9),
                                        text: '加入购物车',
                                        cb: () async {
                                          // 如果有属性选择
                                          if (_productContentList[0]
                                                  .attr
                                                  .length >
                                              0) {
                                            // 广播
                                            eventBus.fire(
                                                ProductContentEvent('加入购物车'));
                                          } else {
                                            await CartUtils.addCart(
                                                _productContentList[0]);
                                            Navigator.of(context).pop();
                                            // 通知Provider更新
                                            cartProvider.updateCartList();
                                            ShowToast.toast('加入成功');
                                          }
                                        })),
                                Expanded(
                                    flex: 1,
                                    child: ButtonWidget(
                                        color: Color.fromRGBO(255, 165, 0, 0.9),
                                        text: '立即购买',
                                        cb: () {
                                          if (_productContentList[0]
                                                  .attr
                                                  .length >
                                              0) {
                                            // 广播
                                            eventBus.fire(
                                                ProductContentEvent('立即购买'));
                                          } else {}
                                        })),
                              ])))
                    ],
                  )
                : LoadingWidget(),
          )),
    );
  }

  // 获取数据
  void _getContentData() async {
    var api = '${Config.domain}api/pcontent?id=${widget.arguments['id']}';
    // print(api);
    var result = await Dio().get(api);
    var productContent = ProductContentModel.fromJson(result.data);
    setState(() {
      _productContentList.add(productContent.result);
    });
  }
}
