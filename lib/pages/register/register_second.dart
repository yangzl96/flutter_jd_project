import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/config/index.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/utils/toast.dart';
import 'package:jd_project/widgets/button/index.dart';
import 'package:jd_project/widgets/text/jd_text.dart';

class RegisterSecondPage extends StatefulWidget {
  Map arguments;
  RegisterSecondPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  late String tel;
  late String code;
  bool sendCodeBtn = false;
  int seconds = 10;

  @override
  void initState() {
    super.initState();
    tel = widget.arguments['tel'];
    _showTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户注册 - 第二步'),
      ),
      body: Container(
        padding: EdgeInsets.all(AutoSize.w(20)),
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text("验证码已经发送到了您的${tel}手机，请输入收到的验证码"),
            ),
            const SizedBox(
              height: 40,
            ),
            Stack(
              children: [
                JdText(
                  text: '请输入验证码',
                  onChanged: (value) {
                    code = value;
                  },
                ),
                Positioned(
                    right: 0,
                    top: -5,
                    child: sendCodeBtn
                        ? ElevatedButton(
                            child: const Text('重新发送'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.redAccent),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: sendCode,
                          )
                        : ElevatedButton(
                            child: Text('${seconds}秒后重发'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black54),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {},
                          ))
              ],
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              text: '下一步',
              color: Colors.red,
              height: 74,
              cb: validateCode,
            )
          ],
        ),
      ),
    );
  }

  // 定时器
  void _showTimer() {
    Timer t;
    t = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        seconds--;
      });
      if (seconds == 0) {
        timer.cancel();
        setState(() {
          sendCodeBtn = true;
        });
      }
    });
  }

  void sendCode() async {
    setState(() {
      sendCodeBtn = false;
      seconds = 10;
      _showTimer();
    });
    var api = '${Config.domain}api/sendCode';
    var response = await Dio().post(api, data: {"tel": tel});
    if (response.data["success"]) {
      ShowToast.toast('${response.data["message"]}: ${response.data["code"]}');
      //演示期间服务器直接返回  给手机发送的验证码

    }
  }

  validateCode() async {
    var api = '${Config.domain}api/validateCode';
    var response = await Dio().post(api, data: {"tel": tel, "code": code});
    if (response.data["success"]) {
      Navigator.pushNamed(context, '/registerThird');
    } else {
      ShowToast.toast('${response.data["message"]}');
    }
  }
}
