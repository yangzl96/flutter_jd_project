// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CheckOut with ChangeNotifier {
  List _checkOutListData = [];
  List get checkOutListData => _checkOutListData;

  changeCheckOutListData(data) {
    _checkOutListData = data;
    notifyListeners();
  }
}
