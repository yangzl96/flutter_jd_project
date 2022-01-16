// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
            child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        top: AutoSize.h(35),
                        left: AutoSize.w(28),
                        right: AutoSize.w(20)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                        borderSide: BorderSide.none))),
            height: AutoSize.h(60),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(26)),
          ),
          actions: [
            InkWell(
              child: SizedBox(
                height: AutoSize.h(60),
                width: AutoSize.w(80),
                child: Row(
                  children: [Text('搜索')],
                ),
              ),
              onTap: () {},
            )
          ]),
    );
  }
}
