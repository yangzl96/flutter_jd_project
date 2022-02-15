// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jd_project/utils/Stroage.dart';

// 因为在使用的时候都是 直接改的_cartList所以可以这里直接赋值保存
// Storage.setString('cartList', json.encode(_cartList));

class Cart extends ChangeNotifier {
  // 购物车列表
  List _cartList = [];
  // 全选状态
  bool _isCheckedAll = false;
  // 总价
  double _allPrice = 0;

  // 获取
  List get cartList => _cartList;
  bool get isCheckedAll => _isCheckedAll;
  double get allPrice => _allPrice;

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
    // 计算总价
    computedAllPrice();
    notifyListeners();
  }

  // 更新获取方法
  updateCartList() {
    _init();
  }

  // 更新count数据
  itemCountChange() {
    // 计算总价
    computedAllPrice();
    // 因为直接改的_cartList所以可以这里直接赋值
    Storage.setString('cartList', json.encode(_cartList));
    notifyListeners();
  }

  // 全选 | 反选 value： true | false
  checkedAll(value) {
    for (var i = 0; i < _cartList.length; i++) {
      _cartList[i]['checked'] = value;
    }
    _isCheckedAll = value;
    // 计算总价
    computedAllPrice();
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
    // 计算总价
    computedAllPrice();
    Storage.setString('cartList', json.encode(_cartList));
    notifyListeners();
  }

  // 计算总价
  computedAllPrice() {
    double templatePrice = 0;
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]['checked'] == true) {
        templatePrice += _cartList[i]['price'] * _cartList[i]['count'];
      }
    }
    _allPrice = templatePrice;
    notifyListeners();
  }

  // 删除
  removeItem() {
    // 正常循环遍历 checked为true 的 使用 _cartList.remove(_cartList[i])
    // 会出现长度变化后，索引不正确的问题

    // 反向思维 获取没被选中的数据赋值
    List tempList = [];
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]["checked"] == false) {
        tempList.add(_cartList[i]);
      }
    }
    _cartList = tempList;
    //计算总价
    computedAllPrice();
    Storage.setString("cartList", json.encode(_cartList));
    notifyListeners();
  }
}
