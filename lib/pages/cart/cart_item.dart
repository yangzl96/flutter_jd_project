// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:jd_project/pages/cartNum.dart';
import 'package:jd_project/provider/Cart.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  Map _itemData;
  CartItem(this._itemData, {Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late Map _itemData;
  var cartProvider;
  // @override
  // void initState() {
  //   super.initState();
  //   // 千万不要在这里赋值，因为只会执行一次 随后都执行build
  //   // 所以导致了购物车的数据删除的时候不正确
  //   _itemData = widget._itemData;
  //   print(1);
  //   print(_itemData);
  //   print(1);
  // }

  @override
  Widget build(BuildContext context) {
    _itemData = widget._itemData;
    cartProvider = Provider.of<Cart>(context);
    return Container(
      width: AutoSize.w(220),
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: [
          // 选择框
          SizedBox(
            width: AutoSize.w(60),
            child: Checkbox(
              onChanged: (v) {
                _itemData['checked'] = !_itemData['checked'];
                cartProvider.itemChange();
              },
              value: _itemData['checked'],
              activeColor: Colors.red,
            ),
          ),
          // 图片
          SizedBox(
            width: AutoSize.w(160),
            height: AutoSize.h(120),
            child: Image.network("${_itemData['pic']}", fit: BoxFit.fill),
          ),
          // 商品信息
          Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _itemData['title'],
                      maxLines: 2,
                    ),
                    Text(_itemData['selectedAttr'], maxLines: 2),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "￥${_itemData['price']}",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CartNum(_itemData),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
