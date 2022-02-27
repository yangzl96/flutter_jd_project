// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';

class OrderInfoPage extends StatefulWidget {
  OrderInfoPage({Key? key}) : super(key: key);

  @override
  State<OrderInfoPage> createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("订单详情")),
      body: Container(
        child: ListView(
          children: [
            //  收货地址
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.add_location, color: Colors.red),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("张三  15201686455"),
                        SizedBox(height: 10),
                        Text("北京市海淀区 西二旗"),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 16),
            // 列表
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              height: AutoSize.h(180),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        width: AutoSize.w(120),
                        height: AutoSize.h(120),
                        child: Image.network(
                            "https://www.itying.com/images/flutter/list2.jpg",
                            fit: BoxFit.fill),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("四季沐歌 (MICOE) 洗衣机水龙头 洗衣机水嘴 单冷快开铜材质龙头",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.black54)),
                                Text("水龙头 洗衣机",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.black54)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("￥100",
                                        style: TextStyle(color: Colors.red)),
                                    Text("x2"),
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            //详情信息
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text("订单编号: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("124215215xx324")
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text("下单日期: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("2021-12-09")
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text("支付方式: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("微信支付")
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text("配送方式: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("顺丰")
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: <Widget>[
                  ListTile(
                      title: Row(
                    children: <Widget>[
                      Text("总金额:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("￥414元", style: TextStyle(color: Colors.red))
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
