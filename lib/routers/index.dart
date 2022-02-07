// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/material.dart';
import 'package:jd_project/pages/product_detail/product_detail_page.dart';
import 'package:jd_project/pages/search/search_page.dart';
import 'package:jd_project/widgets/productList/index.dart';
import 'package:jd_project/widgets/tabs/index.dart';

// 配置路由
final routes = {
  '/': (context) => const Tabs(),
  '/search': (context) => SearchPage(),
  '/productList': (context, {arguments}) => ProductList(arguments: arguments),
  '/productDetail': (context, {arguments}) => ProductDetailPage(arguments: arguments),
};

// 固定写法
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
