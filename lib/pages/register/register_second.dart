import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/widgets/button/index.dart';
import 'package:jd_project/widgets/text/jd_text.dart';

class RegisterSecondPage extends StatefulWidget {
  RegisterSecondPage({Key? key}) : super(key: key);

  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
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
              child: const Text("请输入xxx手机收到的验证码,请输入xxx手机收到的验证码"),
            ),
            const SizedBox(
              height: 40,
            ),
            Stack(
              children: [
                JdText(
                  text: '请输入验证码',
                  onChanged: (value) {},
                ),
                Positioned(
                    right: 0,
                    top: -5,
                    child: ElevatedButton(
                      child: const Text('重新发送'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black45),
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
              cb: () {
                Navigator.of(context).pushNamed('/registerThird');
              },
            )
          ],
        ),
      ),
    );
  }
}
