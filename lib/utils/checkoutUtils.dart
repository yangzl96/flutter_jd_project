// ignore_for_file: file_names

import 'dart:convert';

import 'package:jd_project/utils/Stroage.dart';

class CheckOutUtils {
  // 计算结算总价
  static getAllPrice(checkOutListData) {
    var tempAllPrice = 0.0;
    for (var i = 0; i < checkOutListData.length; i++) {
      if (checkOutListData[i]['checked'] == true) {
        tempAllPrice +=
            checkOutListData[i]['price'] * checkOutListData[i]['count'];
      }
    }
    return tempAllPrice;
  }

  // 下单后，清除被下单的商品
  // 移除下订单时，被勾选的商品
  static removeSelectedCartItem() async {

    List _cartList = [];
    List _tempList = [];

    // 获取购物车数据
    String? cartListString = await Storage.getString('cartList');
    if (cartListString != null) {
      List cartListData = json.decode(cartListString);
      _cartList = cartListData;
    } else {
      _cartList = [];
    }
    // 找出为被勾选的商品 赋值为新的购物车数据
    for(var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]['checked'] == false) {
        _tempList.add(_cartList[i]);
      }
    }
    Storage.setString('cartList', json.encode(_tempList));
  }

}
