import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/config/index.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/utils/toast.dart';
import 'package:jd_project/widgets/button/index.dart';
import 'package:jd_project/widgets/text/jd_text.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key? key}) : super(key: key);

  @override
  State<RegisterFirstPage> createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String tel = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户注册 - 第一步'),
      ),
      body: Container(
        padding: EdgeInsets.all(AutoSize.w(20)),
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            JdText(
              text: '请输入手机号',
              onChanged: (value) {
                setState(() {
                  tel = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                text: '下一步', color: Colors.red, height: 74, cb: sendCode)
          ],
        ),
      ),
    );
  }

  // 发送验证码
  sendCode() async {
    RegExp reg = RegExp(r"^1\d{10}$");
    if (reg.hasMatch(tel)) {
      var api = '${Config.domain}api/sendCode';
      var response = await Dio().post(api, data: {"tel": tel});
      if (response.data["success"]) {
        print(response); //演示期间服务器直接返回  给手机发送的验证码
        Navigator.of(context)
            .pushNamed('/registerSecond', arguments: {"tel": tel});
      } else {
        ShowToast.toast("${response.data['message']}");
      }
    } else {
      ShowToast.toast('手机格式不正确');
    }
  }
}
