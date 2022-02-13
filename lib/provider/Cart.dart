// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jd_project/utils/Stroage.dart';

class Cart extends ChangeNotifier {
  // 购物车列表
  List _cartList = [];
  // 全选状态
  bool _isCheckedAll = false;
  // 获取
  List get cartList => _cartList;
  bool get isCheckedAll => _isCheckedAll;

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
    // 初始化全选状态
    _isCheckedAll = isCheckAll();
    notifyListeners();
  }

  // 更新获取方法
  updateCartList() {
    _init();
  }

  // 更新count数据
  itemCountChange() {
    Storage.setString('cartList', json.encode(_cartList));
    notifyListeners();
  }

  // 全选 | 反选 value： true | false
  checkedAll(value) {
    for (var i = 0; i < _cartList.length; i++) {
      _cartList[i]['checked'] = value;
    }
    _isCheckedAll = value;
    Storage.setString('cartList', json.encode(_cartList));
    notifyListeners();
  }

  // 判断是否全选
  bool isCheckAll() {
    if (_cartList.isNotEmpty) {
      for (var i = 0; i < _cartList.length; i++) {
        if (_cartList[i]['checked'] == false) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  // 每一项的点击 处理是否全选
  itemChange() {
    if (isCheckAll()) {
      _isCheckedAll = true;
    } else {
      _isCheckedAll = false;
    }
    Storage.setString('cartList', json.encode(_cartList));
    notifyListeners();
  }
}
