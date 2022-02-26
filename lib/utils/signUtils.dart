
// ignore_for_file: file_names

import 'dart:convert';

import 'package:crypto/crypto.dart';

class SignUtils {
  static getSign(json) {
    List attrKeys = json.keys.toList();
    //排序  ASCII 字符顺序进行升序排列 
    attrKeys.sort();
    String str = "";
    for(var i = 0; i < attrKeys.length; i++) {
      str += "${attrKeys[i]}${json[attrKeys[i]]}";
    }
    return md5.convert(utf8.encode(str)).toString();
  }
}