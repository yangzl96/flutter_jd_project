// ignore_for_file: file_names

import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ProductContentEvent {
  late String str;
  ProductContentEvent(String str) {
    str = str;
  }
}
