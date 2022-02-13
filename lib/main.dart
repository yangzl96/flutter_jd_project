// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/provider/Cart.dart';
import 'package:jd_project/provider/Counter.dart';
import 'package:jd_project/routers/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_project/utils/Stroage.dart';
import 'package:jd_project/utils/color.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Storage.clear();
    return ScreenUtilInit(
        designSize: const Size(750, 1334), //设计稿的宽度和高度
        minTextAdapt: true,
        builder: () => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => Counter()),
                ChangeNotifierProvider(create: (_) => Cart())
              ],
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  initialRoute: '/',
                  onGenerateRoute: onGenerateRoute,
                  theme: ThemeData(primarySwatch: white)),
            ));
  }
}
