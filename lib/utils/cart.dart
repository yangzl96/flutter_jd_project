import 'dart:convert';

import 'package:jd_project/config/index.dart';
import 'package:jd_project/utils/Stroage.dart';

class CartUtils {
  static addCart(item) async {
    // print(item); Instance of 'ProductContentitem'
    item = CartUtils.formatterCartData(item);
    // {_id: 5a0425bc010e711234661439, title: 磨砂牛皮男休闲鞋-有属性, price: 688, selectedAttr: 牛皮 ,系带,白色, count: 6, pic: public\upload\RinsvExKu7Ed-ocs_7W1DxYO.png, checked: true}
    // print(item);

    String? cartList = await Storage.getString('cartList');
    if (cartList != null) {
      // json => map
      List cartListData = json.decode(cartList);
      // 判断购物车有没有这个数据
      bool hasData = cartListData.any((value) {
        return value['_id'] == item['_id'] &&
            value['selectedAttr'] == item['selectedAttr'];
      });
      if (hasData) {
        // 存在数据 count + 1
        for (var i = 0; i < cartListData.length; i++) {
          if (cartListData[i]['_id'] == item['_id'] &&
              cartListData[i]['selectedAttr'] == item['selectedAttr']) {
            cartListData[i]['count'] = cartListData[i]['count'] + 1;
          }
        }
        await Storage.setString('cartList', json.encode(cartListData));
      } else {
        // 否则直接添加
        cartListData.add(item);
        await Storage.setString('cartList', json.encode(cartListData));
      }
    } else {
      // 初始化
      List tempList = [];
      tempList.add(item);
      await Storage.setString('cartList', json.encode(tempList));
    }
  }

  // 过滤数据
  // 对象(实例) => Map
  static formatterCartData(item) {
    //处理图片
    String pic = item.pic;
    pic = Config.domain + pic.replaceAll('\\', '/');

    final Map data = new Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    //处理 string 和int类型的价格
    if (item.price is int || item.price is double) {
      data['price'] = item.price;
    } else {
      data['price'] = double.parse(item.price);
    }
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = pic;
    //是否选中
    data['checked'] = true;
    print(data);
    return data;
  }

  // 获取购物车选中的数据
  static getCheckOutData() async {
    List cartListData = [];
    List tempCheckOutData = [];
    String? cartList = await Storage.getString('cartList');
    if (cartList != null) {
      cartListData = json.decode(cartList);
    } else {
      cartListData = [];
    }
    for (var i = 0; i < cartListData.length; i++) {
      if (cartListData[i]['checked'] == true) {
        tempCheckOutData.add(cartListData[i]);
      }
    }
    return tempCheckOutData;
  }
}
