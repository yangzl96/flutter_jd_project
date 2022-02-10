// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  List _cartList = [];
  List get cartList => _cartList;
  int get cartNum => _cartList.length;

  addCartItem(value) {
    _cartList.add(value);
    notifyListeners();
  }

  deleteCartItem(value) {
    _cartList.remove(value);
    notifyListeners();
  }
}
