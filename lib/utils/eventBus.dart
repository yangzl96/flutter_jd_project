// ignore_for_file: file_names

import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

// 商品详情
class ProductContentEvent {
  late String str;
  ProductContentEvent(String str) {
    str = str;
  }
}

// 用户中心广播
class UserEvent {
  String str;
  UserEvent(this.str);
}

//收货地址广播
class AddressEvent{
  String str;
  AddressEvent(this.str);
}


//结算页面
class CheckOutEvent{
  String str;
  CheckOutEvent(this.str);
}