// ignore_for_file: file_names

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutoSize {
  static w(num value) {
    return ScreenUtil().setWidth(value);
  }

  static h(num value) {
    return ScreenUtil().setHeight(value);
  }

  static sp(num value) {
    return ScreenUtil().setSp(value);
  }

  // 设备物理宽度
  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  // 设备物理高度
  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }
}
