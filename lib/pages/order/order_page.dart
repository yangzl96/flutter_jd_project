// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/config/index.dart';
import 'package:jd_project/model/OrderModel.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/utils/signUtils.dart';
import 'package:jd_project/utils/userUtils.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List _orderList = [];
  @override
  void initState() {
    super.initState();
    _getListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的订单'),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, AutoSize.h(80), 0, 0),
            padding: EdgeInsets.only(
                left: AutoSize.w(16),
                right: AutoSize.w(16),
                bottom: AutoSize.w(16)),
            child: ListView(
              children: _orderList.map((value) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/orderInfo');
                    },
                    child: Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("订单编号：${value.sId}",
                                style: const TextStyle(color: Colors.black54)),
                          ),
                          const Divider(),
                          Column(
                            children: _orderItemWidget(value.orderItem),
                          ),
                          const SizedBox(height: 10),
                          ListTile(
                            leading: Text("合计：￥${value.allPrice}"),
                            trailing: TextButton(
                              child: const Text("申请售后"),
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ));
              }).toList(),
            ),
          ),
          Positioned(
              top: 0,
              width: AutoSize.w(750),
              height: AutoSize.h(76),
              child: Container(
                  child: Row(
                children: [
                  Expanded(
                    child: Text("全部", textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("待付款", textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("待收货", textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("已完成", textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("已取消", textAlign: TextAlign.center),
                  )
                ],
              )))
        ],
      ),
    );
  }

  void _getListData() async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {"uid": userinfo[0]['_id'], "salt": userinfo[0]["salt"]};
    var sign = SignUtils.getSign(tempJson);
    var api =
        '${Config.domain}api/orderList?uid=${userinfo[0]['_id']}&sign=$sign';
    var response = await Dio().get(api);
    print(response.data is Map);
    setState(() {
      var orderMode = OrderModel.fromJson(response.data);
      print(orderMode);
      _orderList = orderMode.result;
    });
  }

  // 商品项
  List<Widget> _orderItemWidget(orderItems) {
    List<Widget> template = [];
    for (var i = 0; i < orderItems.length; i++) {
      template.add(Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Container(
              width: AutoSize.w(120),
              height: AutoSize.h(120),
              child: Image.network(
                '${orderItems[i].productImg}',
                fit: BoxFit.cover,
              ),
            ),
            title: Text("${orderItems[i].productTitle}"),
            trailing: Text('x${orderItems[i].productCount}'),
          ),
          const SizedBox(height: 10)
        ],
      ));
    }
    return template;
  }
}
