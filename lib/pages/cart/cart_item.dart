// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jd_project/model/ProductContentModel.dart';
import 'package:jd_project/pages/cartNum.dart';
import 'package:jd_project/utils/autoSize.dart';

class CartItem extends StatefulWidget {
  Map _itemData;
  CartItem(this._itemData, {Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late Map _itemData;
  @override
  void initState() {
    super.initState();
    _itemData = widget._itemData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AutoSize.w(200),
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: [
          SizedBox(
            width: AutoSize.w(60),
            child: Checkbox(
              onChanged: (v) {},
              value: true,
              activeColor: Colors.red,
            ),
          ),
          SizedBox(
            width: AutoSize.w(160),
            height: AutoSize.h(120),
            child: Image.network("${_itemData['pic']}", fit: BoxFit.fill),
          ),
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
