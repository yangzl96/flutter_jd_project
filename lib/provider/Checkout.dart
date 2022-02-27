// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CheckOut with ChangeNotifier {
  List _checkOutListData = [];
  List get checkOutListData => _checkOutListData;

  // 点击结算时，保存购物车中选中的数据
  changeCheckOutListData(data) {
    _checkOutListData = data;
    notifyListeners();
  }
}
