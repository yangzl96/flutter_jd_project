import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_project/utils/autoSize.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: ScreenUtil().setHeight(32),
      height: AutoSize.h(34),
      padding: EdgeInsets.only(left: AutoSize.w(20)),
      margin: EdgeInsets.only(left: AutoSize.w(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  width: AutoSize.w(10), color: Colors.red))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style:
                  TextStyle(color: Colors.black54, fontSize: AutoSize.sp(26)),
            ),
          ]),
    );
  }
}
