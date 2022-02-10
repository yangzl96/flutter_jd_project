// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => count;
  incCount() {
    _count++;
    notifyListeners();
  }
}
