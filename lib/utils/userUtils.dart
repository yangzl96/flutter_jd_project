// ignore_for_file: file_names

import 'dart:convert';

import 'package:jd_project/utils/Stroage.dart';

class UserServices {
  static getUserInfo() async {
    String? userInfo = await Storage.getString('userInfo');
    if (userInfo != null) {
      List userInfoList = json.decode(userInfo);
      return userInfoList;
    } else {
      return [];
    }
  }

  static getUserLoginState() async {
    var userInfo = await UserServices.getUserInfo();
    if (userInfo.length > 0 && userInfo[0]['username'] != '') {
      return true;
    } else {
      return false;
    }
  }

  static loginOut() {
    Storage.remove('userInfo');
  }
}
