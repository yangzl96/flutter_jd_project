import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';

class JdText extends StatelessWidget {
  final String text;
  final bool password;
  var onChanged;
  final int height;
  final int maxLines;
  var controller;

  JdText(
      {Key? key,
      this.text = '输入内容',
      this.password = false,
      this.onChanged = null,
      this.maxLines = 1,
      this.controller = null,
      this.height = 68})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
          controller: controller,
          maxLines: 1,
          onChanged: onChanged,
          obscureText: password,
          cursorColor: Colors.red,
          decoration: InputDecoration(
              hintText: text,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none))),
      height: AutoSize.h(height),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
    );
  }
}
