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
