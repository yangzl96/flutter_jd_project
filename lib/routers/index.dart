// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:jd_project/pages/address/address_add.dart';
import 'package:jd_project/pages/address/address_edit.dart';
import 'package:jd_project/pages/address/address_list.dart';
import 'package:jd_project/pages/cart/cart_page.dart';
import 'package:jd_project/pages/checkout/checkout_page.dart';
import 'package:jd_project/pages/login/login_page.dart';
import 'package:jd_project/pages/order/order_info.dart';
import 'package:jd_project/pages/order/order_page.dart';
import 'package:jd_project/pages/pay/pay_page.dart';
import 'package:jd_project/pages/product_detail/product_detail_page.dart';
import 'package:jd_project/pages/register/register_first.dart';
import 'package:jd_project/pages/register/register_second.dart';
import 'package:jd_project/pages/register/register_third.dart';
import 'package:jd_project/pages/search/search_page.dart';
import 'package:jd_project/widgets/productList/index.dart';
import 'package:jd_project/widgets/tabs/index.dart';

// 配置路由
final routes = {
  '/': (context) => const Tabs(),
  '/login': (context) => LoginPage(),
  '/search': (context) => SearchPage(),
  '/cart': (context) => CartPage(),
  '/productList': (context, {arguments}) => ProductList(arguments: arguments),
  '/productDetail': (context, {arguments}) =>
      ProductDetailPage(arguments: arguments),
  '/registerFirst': (context) => RegisterFirstPage(),
  '/registerSecond': (context, {arguments}) =>
      RegisterSecondPage(arguments: arguments),
  '/checkout': (context) => CheckoutPage(),
  '/registerThird': (context, {arguments}) =>
      RegisterThirdPage(arguments: arguments),
  '/addressAdd': (context) => AddressAddPage(),
  '/addressEdit': (context, {arguments}) =>
      AddressEditPage(arguments: arguments),
  '/addressList': (context) => AddressListPage(),
  '/pay': (context) => PayPage(),
  '/order': (context) => OrderPage(),
  '/orderInfo': (context) => OrderInfoPage(),
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
