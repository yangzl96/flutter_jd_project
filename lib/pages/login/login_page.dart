import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:jd_project/config/index.dart';
import 'package:jd_project/utils/Stroage.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/utils/eventBus.dart';
import 'package:jd_project/utils/toast.dart';
import 'package:jd_project/widgets/button/index.dart';
import 'package:jd_project/widgets/text/jd_text.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    eventBus.fire(UserEvent('登录成功'));
  }
  String username = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [TextButton(onPressed: () {}, child: Text('客服'))],
      ),
      body: Container(
        padding: EdgeInsets.all(AutoSize.w(20)),
        child: ListView(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                height: AutoSize.h(160),
                width: AutoSize.w(160),
                child: Center(
                    child: Text(
                  'Logo',
                  style: TextStyle(fontSize: AutoSize.sp(52)),
                )),
                // child: Image.asset(
                //   'images/login.png',
                //   fit: BoxFit.cover,
                // )
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            JdText(
              text: '请输入用户名',
              onChanged: (value) {
                username = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            JdText(
              text: '请输入密码',
              password: true,
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(AutoSize.w(20)),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('忘记密码'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/registerFirst');
                      },
                      child: const Text('新用户注册'),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              text: '登录',
              color: Colors.red,
              height: 74,
              cb: doLogin,
            )
          ],
        ),
      ),
    );
  }

  doLogin() async {
    RegExp reg = RegExp(r"^1\d{10}");
    if (!reg.hasMatch(username)) {
      ShowToast.toast('手机号格式不正确');
    } else if (password.length < 6) {
      ShowToast.toast('密码不正确');
    } else {
      var api = '${Config.domain}api/doLogin';
      var response = await Dio()
          .post(api, data: {"username": username, "password": this.password});
      if (response.data["success"]) {
        print(response.data);
        //保存用户信息
        Storage.setString('userInfo', json.encode(response.data["userinfo"]));
        Navigator.pop(context);
      } else {
        ShowToast.toast('${response.data["message"]}');
      }
    }
  }
}
