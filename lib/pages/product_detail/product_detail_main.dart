// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:jd_project/config/index.dart';
import 'package:jd_project/pages/cart/cart_num.dart';
import 'package:jd_project/provider/Cart.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/utils/cart.dart';
import 'package:jd_project/utils/eventBus.dart';
import 'package:jd_project/widgets/button/index.dart';
import 'package:jd_project/model/ProductContentModel.dart';
import 'package:provider/provider.dart';

class ProductDetailMain extends StatefulWidget {
  final List _productContentList;
  ProductDetailMain(this._productContentList, {Key? key}) : super(key: key);

  @override
  _ProductDetailMainState createState() => _ProductDetailMainState();
}

class _ProductDetailMainState extends State<ProductDetailMain> {
  // 商品信息
  late ProductContentitem _productContent;

  // 已选 类别 属性
  List _attr = [];

  // 选择的值
  String _selectedValue = "";

  // 监听
  var actionEventBus;

  var cartProvider;

  @override
  void initState() {
    super.initState();
    _productContent = widget._productContentList[0];
    print(_productContent.toJson() is Map);
    _attr = _productContent.attr;
    _initAttr();
    // 监听广播
    actionEventBus = eventBus.on<ProductContentEvent>().listen((str) {
      _attrBottomSheet();
    });
  }

  @override
  void dispose() {
    super.dispose();
    // 取消监听
    actionEventBus.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // 获取 provider cart
    cartProvider = Provider.of<Cart>(context);
    //处理图片
    String pic = Config.domain + _productContent.pic;
    pic = pic.replaceAll('\\', '/');
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          AspectRatio(
              aspectRatio: 6 / 5, child: Image.network(pic, fit: BoxFit.fill)),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Text("${_productContent.title}",
                  style: TextStyle(
                      color: Colors.black87, fontSize: AutoSize.sp(36)))),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${_productContent.subTitle}',
              style:
                  TextStyle(color: Colors.black54, fontSize: AutoSize.sp(28)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(children: [
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text('特价：'),
                      Text('￥${_productContent.price}',
                          style: TextStyle(
                              color: Colors.red, fontSize: AutoSize.sp(36)))
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('原价：'),
                      Text('￥${_productContent.oldPrice}',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.black38,
                              fontSize: AutoSize.sp(28)))
                    ],
                  ))
            ]),
          ),
          // 已选择
          _attr.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  height: AutoSize.h(80),
                  child: InkWell(
                    onTap: () {
                      _attrBottomSheet();
                    },
                    child: Row(
                      children: [
                        Text(
                          '已选：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(_selectedValue)
                      ],
                    ),
                  ),
                )
              : Text(''),
          Divider(),
          Container(
            height: AutoSize.h(80),
            child: Row(
              children: [
                Text(
                  '运费：',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('免运费')
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  // 选择商品类型
  void _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, setBottomState) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(AutoSize.w(20)),
                  child: ListView(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getAttrWidget(setBottomState),
                    ),
                    Divider(),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        height: AutoSize.h(80),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text(
                                '数量',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CartNum(_productContent)
                            ],
                          ),
                        ))
                  ]),
                ),
                Positioned(
                    bottom: 0,
                    width: AutoSize.w(750),
                    height: AutoSize.h(76),
                    child: Row(children: [
                      Container(
                        width: AutoSize.w(750),
                        height: AutoSize.h(76),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: ButtonWidget(
                                      color: Color.fromRGBO(253, 1, 0, 0.9),
                                      text: '加入购物车',
                                      cb: () async {
                                        // 加入购物车的操作有异步代码
                                        // 所以这里要等待，否则会造成
                                        // 加入购物车后数据没有更新
                                        await CartUtils.addCart(
                                            _productContent);
                                        Navigator.of(context).pop();
                                        // 通知Provider更新
                                        cartProvider.updateCartList();
                                      }),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: ButtonWidget(
                                      color: Color.fromRGBO(255, 165, 0, 0.9),
                                      text: '立即购买',
                                      cb: () {}),
                                ))
                          ],
                        ),
                      )
                    ]))
              ],
            );
          });
        });
  }

  // 属性选择
  List<Widget> _getAttrWidget(setBottomState) {
    List<Widget> attrList = [];
    _attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: [
          // 左侧名称
          Container(
            width: AutoSize.w(120),
            padding: EdgeInsets.only(top: AutoSize.h(30)),
            child: Text(
              '${attrItem.cate}: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // 右侧选项
          Container(
            width: AutoSize.w(590),
            child: Wrap(
              children: _getAttrItemWidget(attrItem, setBottomState),
            ),
          )
        ],
      ));
    });
    return attrList;
  }

  // 属性item
  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];
    attrItem.attrList.forEach((item) {
      attrItemList.add(Container(
        margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            _changeAttr(attrItem.cate, item['title'], setBottomState);
          },
          child: Chip(
            label: Text('${item['title']}'),
            padding: EdgeInsets.all(10),
            backgroundColor: item['checked'] ? Colors.red : Colors.black26,
          ),
        ),
      ));
    });
    return attrItemList;
  }

  // 初始化attr数据 加checked属性
  void _initAttr() {
    //注意attrList属性需要在model中定义
    var attr = _attr;
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list.length; j++) {
        // 第一个属性默认选中
        if (j == 0) {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": true});
        } else {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": false});
        }
      }
    }
    _getSelectedAttrValue();
  }

  // 获取选中的属性
  void _getSelectedAttrValue() {
    var _list = _attr;
    List tempArr = [];
    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].attrList.length; j++) {
        if (_list[i].attrList[j]['checked'] == true) {
          tempArr.add(_list[i].attrList[j]['title']);
        }
      }
    }
    setState(() {
      _selectedValue = tempArr.join(',');
      // 赋值选中的属性到实例中去
      _productContent.selectedAttr = _selectedValue;
    });
  }

  // 点击属性
  void _changeAttr(cate, title, setBottomState) {
    var attr = _attr;
    for (var i = 0; i < attr.length; i++) {
      // 找到对应的属性行
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].attrList.length; j++) {
          // 先把选中都设置false
          attr[i].attrList[j]['checked'] = false;
          // 再找到当前点击的属性 设置选中
          if (attr[i].attrList[j]['title'] == title) {
            attr[i].attrList[j]['checked'] = true;
          }
        }
      }
    }
    //注意  改变showModalBottomSheet里面的数据 来源于StatefulBuilder
    setBottomState(() {
      _attr = attr;
    });
    _getSelectedAttrValue();
  }
}
