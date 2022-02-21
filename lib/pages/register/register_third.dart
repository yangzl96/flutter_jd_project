import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/config/index.dart';
import 'package:jd_project/utils/Stroage.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/utils/toast.dart';
import 'package:jd_project/widgets/button/index.dart';
import 'package:jd_project/widgets/tabs/index.dart';
import 'package:jd_project/widgets/text/jd_text.dart';

class RegisterThirdPage extends StatefulWidget {
  Map arguments;
  RegisterThirdPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<RegisterThirdPage> createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  late String tel;
  late String code;
  String password = "";
  String rpassword = "";
  @override
  void initState() {
    super.initState();
    tel = widget.arguments['tel'];
    code = widget.arguments['code'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户注册 - 第三步'),
      ),
      body: Container(
        padding: EdgeInsets.all(AutoSize.w(20)),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 50),
            JdText(
              text: "请输入密码",
              password: true,
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(height: 10),
            JdText(
              text: "请输入确认密码",
              password: true,
              onChanged: (value) {
                rpassword = value;
              },
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              text: "登录",
              color: Colors.red,
              height: 74,
              cb: doRegister,
            )
          ],
        ),
      ),
    );
  }

  // 注册
  doRegister() async {
    if (password.length < 6) {
      ShowToast.toast('密码长度不可小于6');
    } else if (rpassword != password) {
      ShowToast.toast('两次密码不一致');
    } else {
      var api = '${Config.domain}api/register';
      var response = await Dio()
          .post(api, data: {"tel": tel, "code": code, "password": password});
      if (response.data['success']) {
        // 保存用户信息
        Storage.setString('userInfo', json.encode(response.data['userinfo']));
        // 返回到根
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Tabs()),
            (route) => route == null);
      }
    }
  }
}
