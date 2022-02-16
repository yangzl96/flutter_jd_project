import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/widgets/button/index.dart';
import 'package:jd_project/widgets/text/jd_text.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key? key}) : super(key: key);

  @override
  State<RegisterFirstPage> createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
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
                print(value);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              text: '下一步',
              color: Colors.red,
              height: 74,
              cb: () {
                Navigator.of(context).pushNamed('/registerSecond');
              },
            )
          ],
        ),
      ),
    );
  }
}
