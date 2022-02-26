import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/config/index.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/utils/eventBus.dart';
import 'package:jd_project/utils/signUtils.dart';
import 'package:jd_project/utils/userUtils.dart';
import 'package:jd_project/widgets/button/index.dart';
import 'package:jd_project/widgets/text/jd_text.dart';

class AddressEditPage extends StatefulWidget {
  Map arguments;
  AddressEditPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<AddressEditPage> createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  String area = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.arguments['name'];
    phoneController.text = widget.arguments['phone'];
    addressController.text = widget.arguments['address'];
  }

  @override
  void dispose() {
    super.dispose();
    eventBus.fire(AddressEvent('修改成功...'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('修改收货地址'),
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
              controller: nameController,
              onChanged: (v) {
                nameController.text = v;
              },
            ),
            const SizedBox(height: 10),
            JdText(
              controller: phoneController,
              text: "收货人电话",
              onChanged: (v) {
                phoneController.text = v;
              },
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
                        locationCode: "130102",
                        cancelWidget: const Text(
                          '取消',
                          style: TextStyle(color: Colors.blue),
                        ),
                        confirmWidget: const Text("确定",
                            style: TextStyle(color: Colors.blue)));

                    if (result != null) {
                      setState(() {
                        area =
                            "${result.provinceName}/${result.cityName}/${result.areaName}";
                      });
                    }
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
                                  fontSize: AutoSize.sp(28)))
                    ],
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            JdText(
                controller: addressController,
                text: '详细地址',
                maxLines: 4,
                height: 200,
                onChanged: (v) {
                  addressController.text = v;
                }),
            const SizedBox(height: 10),
            const SizedBox(height: 40),
            ButtonWidget(
              text: "修改",
              color: Colors.red,
              cb: () async {
                List userInfo = await UserServices.getUserInfo();
                var tempJson = {
                  "uid": userInfo[0]["_id"],
                  "id": widget.arguments["id"],
                  "name": nameController.text,
                  "phone": phoneController.text,
                  "address": addressController.text,
                  "salt": userInfo[0]["salt"]
                };
                // 签名
                var sign = SignUtils.getSign(tempJson);
                var api = '${Config.domain}api/editAddress';
                var result = await Dio().post(api, data: {
                  "uid": userInfo[0]["_id"],
                  "id": widget.arguments["id"],
                  "name": nameController.text,
                  "phone": phoneController.text,
                  "address": addressController.text,
                  "sign": sign
                });
                print(result);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
