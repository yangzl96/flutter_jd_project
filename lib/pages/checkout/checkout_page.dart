// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/config/index.dart';
import 'package:jd_project/provider/Checkout.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/utils/eventBus.dart';
import 'package:jd_project/utils/signUtils.dart';
import 'package:jd_project/utils/userUtils.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List _addressList = [];
  @override
  void initState() {
    super.initState();
    _getDefaultAddress();

    //监听广播
    eventBus.on<CheckOutEvent>().listen((event) {
      _getDefaultAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    var checkOutProvider = Provider.of<CheckOut>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('结算'),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    _addressList.isNotEmpty
                        ? InkWell(
                            child: Container(
                                padding: EdgeInsets.all(AutoSize.w(20)),
                                height: AutoSize.h(120),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "${_addressList[0]["name"]}  ${_addressList[0]["phone"]}"),
                                        SizedBox(height: 10),
                                        Text("${_addressList[0]["address"]}"),
                                      ],
                                    ),
                                    Icon(Icons.navigate_next)
                                  ],
                                )),
                            onTap: () {
                              Navigator.of(context).pushNamed('/addressList');
                            },
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/addressAdd');
                            },
                            child: Container(
                              height: AutoSize.h(120),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_location),
                                  Text("请添加收货地址"),
                                  Icon(Icons.navigate_next)
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(AutoSize.w(20)),
                child: Column(
                    children: checkOutProvider.checkOutListData.map((value) {
                  return Column(
                    children: [_checkOutItem(value), Divider()],
                  );
                }).toList()),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(AutoSize.w(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("商品总金额:￥100"),
                    Divider(),
                    Text("立减:￥5"),
                    Divider(),
                    Text("运费:￥0"),
                  ],
                ),
              )
            ],
          ),
          Positioned(
              bottom: 0,
              width: AutoSize.w(750),
              height: AutoSize.h(100),
              child: Container(
                  width: AutoSize.w(750),
                  height: AutoSize.h(100),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.black26))),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text('总价：￥112',
                            style: TextStyle(color: Colors.red)),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.only(right: AutoSize.w(16)),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                child: Text('立即下单'),
                                onPressed: () {}),
                          ))
                    ],
                  )))
        ],
      ),
    );
  }

  _checkOutItem(item) {
    return Row(
      children: [
        Container(
          width: AutoSize.w(120),
          height: AutoSize.h(120),
          child: Image.network("${item["pic"]}", fit: BoxFit.cover),
        ),
        Expanded(
            flex: 1,
            child: Container(
              height: AutoSize.h(120),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${item["title"]}", maxLines: 2),
                  Text("${item["selectedAttr"]}", maxLines: 2),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("￥${item["price"]}",
                            style: TextStyle(color: Colors.red)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("x${item["count"]}"),
                      )
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }

  void _getDefaultAddress() async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {"uid": userinfo[0]["_id"], "salt": userinfo[0]["salt"]};
    var sign = SignUtils.getSign(tempJson);
    var api =
        '${Config.domain}api/oneAddressList?uid=${userinfo[0]["_id"]}&sign=${sign}';
    var response = await Dio().get(api);
    setState(() {
      _addressList = response.data['result'];
    });
  }
}
