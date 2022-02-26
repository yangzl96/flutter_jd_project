// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/config/index.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/utils/eventBus.dart';
import 'package:jd_project/utils/signUtils.dart';
import 'package:jd_project/utils/userUtils.dart';

class AddressListPage extends StatefulWidget {
  AddressListPage({Key? key}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List addressList = [];
  @override
  void initState() {
    super.initState();
    _getAddressList();
    // 监听增加完收货地址后
    eventBus.on<AddressEvent>().listen((event) {
      _getAddressList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    eventBus.fire(CheckOutEvent('选择地址结束...'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收货地址列表'),
      ),
      body: Container(
        child: Stack(
          children: [
            ListView.builder(
                itemCount: addressList.length,
                itemBuilder: (context, index) {
                  if (addressList[index]['default_address'] == 1) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          leading: Icon(Icons.check, color: Colors.red),
                          title: InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${addressList[index]['name']} ${addressList[index]['phone']}"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("${addressList[index]['address']}")
                              ],
                            ),
                            onTap: () {
                              _changeDefaultAddress(addressList[index]["_id"]);
                            },
                            onLongPress: () {
                              _showDelAlertDialog(addressList[index]["_id"]);
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit, color: Colors.black54),
                            onPressed: () {
                              Navigator.pushNamed(context, '/addressEdit',
                                  arguments: {
                                    "id": addressList[index]["_id"],
                                    "name": addressList[index]["name"],
                                    "phone": addressList[index]["phone"],
                                    "address": addressList[index]["address"],
                                  });
                            },
                          ),
                        ),
                        Divider(height: 20),
                      ],
                    );
                  } else {
                    return InkWell(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20),
                          ListTile(
                            title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      "${addressList[index]["name"]}  ${addressList[index]["phone"]}"),
                                  SizedBox(height: 10),
                                  Text("${addressList[index]["address"]}"),
                                ]),
                            trailing: IconButton(
                              icon: Icon(Icons.edit, color: Colors.black54),
                              onPressed: () {
                                Navigator.pushNamed(context, '/addressEdit',
                                    arguments: {
                                      "id": addressList[index]["_id"],
                                      "name": addressList[index]["name"],
                                      "phone": addressList[index]["phone"],
                                      "address": addressList[index]["address"],
                                    });
                              },
                            ),
                          ),
                          Divider(height: 20),
                        ],
                      ),
                      onTap: () {
                        _changeDefaultAddress(addressList[index]["_id"]);
                      },
                      onLongPress: () {
                        _showDelAlertDialog(addressList[index]["_id"]);
                      },
                    );
                  }
                }),
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

  // 获取地址
  void _getAddressList() async {
    List userInfo = await UserServices.getUserInfo();
    var tempJson = {"uid": userInfo[0]['_id'], "salt": userInfo[0]['salt']};
    var sign = SignUtils.getSign(tempJson);
    var api =
        '${Config.domain}api/addressList?uid=${userInfo[0]['_id']}&sign=$sign';
    var response = await Dio().get(api);
    setState(() {
      addressList = response.data["result"];
    });
  }

  // 改变默认地址
  void _changeDefaultAddress(id) async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {
      "uid": userinfo[0]['_id'],
      "id": id,
      "salt": userinfo[0]["salt"]
    };
    var sign = SignUtils.getSign(tempJson);

    var api = '${Config.domain}api/changeDefaultAddress';
    await Dio()
        .post(api, data: {"uid": userinfo[0]['_id'], "id": id, "sign": sign});
    Navigator.pop(context);
  }

  // 删除弹窗
  void _showDelAlertDialog(id) async {
    var result = await showDialog(
        barrierDismissible: false, //点击背景是否消失
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: Center(child: Text('提示信息')),
            content: Text('确定要删除该地址信息吗?'),
            actions: [
              TextButton(
                  onPressed: () async {
                    _delAddress(id);
                    Navigator.pop(context);
                  },
                  child: Text("确定", style: TextStyle(color: Colors.red))),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("取消", style: TextStyle(color: Colors.black54))),
            ],
          );
        });
  }

  // 删除地址
  void _delAddress(id) async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {
      "uid": userinfo[0]["_id"],
      "id": id,
      "salt": userinfo[0]["salt"]
    };

    var sign = SignUtils.getSign(tempJson);

    var api = '${Config.domain}api/deleteAddress';
    await Dio()
        .post(api, data: {"uid": userinfo[0]["_id"], "id": id, "sign": sign});
    _getAddressList();
  }
}
