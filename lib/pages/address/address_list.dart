// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';

class AddressListPage extends StatefulWidget {
  AddressListPage({Key? key}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收货地址列表'),
      ),
      body: Container(
        child: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(height: 20),
                ListTile(
                  leading: Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("张三  15201681234"),
                      SizedBox(height: 10),
                      Text("北京市海淀区西二旗"),
                    ],
                  ),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(height: 20),
              ],
            ),
            Positioned(
                bottom: 0,
                width: AutoSize.w(750),
                height: AutoSize.h(88),
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: AutoSize.w(750),
                  height: AutoSize.h(88),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.white))),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/addressAdd');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text("增加收货地址", style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
