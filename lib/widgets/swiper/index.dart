// ignore_for_file: unnecessary_new, avoid_unnecessary_containers, prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:jd_project/config/index.dart';

class SwiperWidget extends StatelessWidget {
  final List<dynamic> swiperList;
  SwiperWidget(this.swiperList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        ///宽高比 可以做适配
        aspectRatio: 2 / 1,
        child: new Swiper(
          // 解决：ScrollController not attached to any scroll views.
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            String pic = swiperList[index].pic;
            pic = Config.domain + pic.replaceAll('\\', '/');
            return Image.network(
              "${pic}",
              fit: BoxFit.fill,
            );
          },
          autoplay: true,
          itemCount: swiperList.length,
          pagination: SwiperPagination(),
        ),
      ),
    );
  }
}
