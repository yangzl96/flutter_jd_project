//https://material.io/tools/icons/?icon=favorite&style=baseline

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/utils/eventBus.dart';
import 'package:jd_project/utils/userUtils.dart';
import 'package:jd_project/widgets/button/index.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _isLogin = false;
  List _userInfo = [];
  @override
  void initState() {
    super.initState();
    _getUserInfo();
    // 监听登录成功的时候
    eventBus.on<UserEvent>().listen((event) {
      _getUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("用户中心"),
        // ),
        body: ListView(
      children: <Widget>[
        Container(
          height: AutoSize.h(220),
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/user_bg.jpg'), fit: BoxFit.cover)),
          child: Row(
            children: <Widget>[
              Container(
                  width: AutoSize.w(100),
                  height: AutoSize.h(100),
                  margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                              _isLogin ? 'images/aaa.jpeg' : 'images/user.png'),
                          fit: BoxFit.cover))),
              !_isLogin
                  ? Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/login');
                          },
                          child: Text("登录/注册",
                              style: TextStyle(color: Colors.white))),
                    )
                  : Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("用户名：${_userInfo[0]['username']}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AutoSize.sp(32))),
                          Text("普通会员",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AutoSize.sp(24))),
                        ],
                      ),
                    )
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.assignment, color: Colors.red),
          title: Text("全部订单"),
          onTap: () {
            Navigator.pushNamed(context, '/order');
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment, color: Colors.green),
          title: Text("待付款"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.local_car_wash, color: Colors.orange),
          title: Text("待收货"),
        ),
        Container(
            width: double.infinity,
            height: 10,
            color: Color.fromRGBO(242, 242, 242, 0.9)),
        ListTile(
          leading: Icon(Icons.favorite, color: Colors.lightGreen),
          title: Text("我的收藏"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.people, color: Colors.black54),
          title: Text("在线客服"),
        ),
        Divider(),
        SizedBox(
          height: AutoSize.h(40),
        ),
        _isLogin
            ? ButtonWidget(
                text: '退出登录',
                color: Colors.red,
                cb: () {
                  UserServices.loginOut();
                  _getUserInfo();
                },
              )
            : Container()
      ],
    ));
  }

  // 获取用户信息
  void _getUserInfo() async {
    var isLogin = await UserServices.getUserLoginState();
    var userInfo = await UserServices.getUserInfo();
    print(isLogin);
    print(userInfo);
    setState(() {
      _userInfo = userInfo;
      _isLogin = isLogin;
    });
  }
}
