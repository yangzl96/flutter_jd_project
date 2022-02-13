// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jd_project/utils/Stroage.dart';

class Cart extends ChangeNotifier {
  List _cartList = [];
  // 获取
  List get cartList => _cartList;

  // 构造方法
  Cart() {
    _init();
  }
  // 初始化获取购物车数据
  void _init() async {
    String? cartList = await Storage.getString('cartList');
    if (cartList != null) {
      // json => map
      List cartListData = json.decode(cartList);
      _cartList = cartListData;
    } else {
      _cartList = [];
    }
    notifyListeners();
  }

  // 更新获取方法
  updateCartList() {
    _init();
  }
}
