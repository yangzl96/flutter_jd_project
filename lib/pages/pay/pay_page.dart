import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/widgets/button/index.dart';

class PayPage extends StatefulWidget {
  PayPage({Key? key}) : super(key: key);

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  List payList = [
    {
      "title": "支付宝支付",
      "checked": true,
      "image": "https://www.itying.com/themes/itying/images/alipay.png"
    },
    {
      "title": "微信支付",
      "checked": false,
      "image": "https://www.itying.com/themes/itying/images/weixinpay.png"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('去支付'),
      ),
      body: Column(
        children: [
          Container(
            height: AutoSize.h(600),
            padding: EdgeInsets.all(AutoSize.w(40)),
            child: ListView.builder(
                itemCount: payList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Image.network("${payList[index]['image']}"),
                        title: Text("${payList[index]['title']}"),
                        trailing: payList[index]['checked'] == true
                            ? const Icon(
                                Icons.check,
                                color: Colors.red,
                              )
                            : const Text(""),
                        onTap: () {
                          // 选中
                          setState(() {
                            for (var i = 0; i < payList.length; i++) {
                              payList[i]['checked'] = false;
                            }
                            payList[index]["checked"] = true;
                          });
                        },
                      ),
                      const Divider()
                    ],
                  );
                }),
          ),
          ButtonWidget(
            text: '支付',
            color: Colors.red,
            height: AutoSize.h(100),
            cb: () {
              print('支付111');
            },
          )
        ],
      ),
    );
  }
}
