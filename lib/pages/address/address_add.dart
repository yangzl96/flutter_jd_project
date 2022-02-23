import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/widgets/button/index.dart';
import 'package:jd_project/widgets/text/jd_text.dart';

class AddressAddPage extends StatefulWidget {
  AddressAddPage({Key? key}) : super(key: key);

  @override
  State<AddressAddPage> createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String area = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("增加收货地址"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            JdText(
              text: "收货人姓名",
            ),
            const SizedBox(height: 10),
            JdText(
              text: "收货人电话",
            ),
            // const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 5),
              height: AutoSize.h(78),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: InkWell(
                  onTap: () async {
                    Result? result = await CityPickers.showCityPicker(
                        context: context,
                        cancelWidget: const Text(
                          '取消',
                          style: TextStyle(color: Colors.blue),
                        ),
                        confirmWidget: const Text("确定",
                            style: TextStyle(color: Colors.blue)));

                    setState(() {
                      if (result != null) {
                        area =
                            "${result.provinceName}/${result.cityName}/${result.areaName}";
                      }
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_location,
                        color: Colors.red,
                      ),
                      area.isNotEmpty
                          ? Text(area,
                              style: const TextStyle(color: Colors.black54))
                          : Text('省/市/区',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: AutoSize.sp(32)))
                    ],
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            JdText(text: '详细地址', maxLines: 4, height: 200),
            const SizedBox(height: 10),
            const SizedBox(height: 40),
            ButtonWidget(text: "增加", color: Colors.red)
          ],
        ),
      ),
    );
  }
}
