// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';

class ButtonWidget extends StatelessWidget {
  Color color;
  String text;
  final double height;
  Function()? cb;
  ButtonWidget(
      {Key? key,
      this.color = Colors.black,
      this.height = 68,
      this.text = "按钮",
      this.cb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cb,
      child: Container(
          child: Container(
        margin: EdgeInsets.all(5),
        height: AutoSize.h(height),
        padding: EdgeInsets.all(5),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      )),
    );
  }
}
