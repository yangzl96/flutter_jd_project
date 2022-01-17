// ignore_for_file: file_names

import 'dart:convert';

import 'package:jd_project/utils/Stroage.dart';

class SearchUtils {
  // 设置Keyword
  static setHistoryData(keywords) async {
    String? searchList = await Storage.getString('searchList');
    if (searchList != null) {
      // json字符串 转成 Map
      List searchListData = json.decode(searchList);
      var hasData = searchListData.any((word) => word == keywords);
      if (!hasData) {
        searchListData.add(keywords);
        await Storage.setString('searchList', json.encode(searchListData));
      }
    } else {
      List tempList = [];
      tempList.add(keywords);
      await Storage.setString('searchList', json.encode(tempList));
    }
  }

  static getHistoryList() async {
    String? searchList = await Storage.getString('searchList');
    if (searchList != null) {
      List searchListData = json.decode(searchList);
      return searchListData;
    }
    return [];
  }

  static clearHistory() async {
    await Storage.remove('searchList');
  }

  static removeHistoryData(keywords) async {
    String? searchList = await Storage.getString('searchList');
    if (searchList != null) {
      List searchListData = json.decode(searchList);
      searchListData.remove(keywords);
      await Storage.setString('searchList', json.encode(searchListData));
    }
  }
}
