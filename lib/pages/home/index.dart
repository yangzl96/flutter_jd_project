import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/widgets/swiper/index.dart';
import 'package:jd_project/widgets/title/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map> imgList = [
    {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
    {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
    {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // 轮播图
        SwiperWidget(imgList),
        SizedBox(
          height: AutoSize.h(20),
        ),
        const TitleWidget('猜你喜欢'),
        SizedBox(
          height: AutoSize.h(20),
        ),
        _hotProductList(),
        SizedBox(
          height: AutoSize.h(20),
        ),
        const TitleWidget('热门推荐'),
      ],
    );
  }

  // 热门商品
  Widget _hotProductList() {
    // Listview中嵌套listView的时候，要在外面包一层Container并设置宽高
    // 否则不生效
    return Container(
      height: AutoSize.h(200),
      padding: EdgeInsets.symmetric(horizontal: AutoSize.w(20)),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: AutoSize.h(160),
                  margin: EdgeInsets.only(right: AutoSize.w(20)),
                  child: Image.network(
                    'https://www.itying.com/images/flutter/hot${index + 1}.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: AutoSize.h(10)),
                    height: AutoSize.h(34),
                    child: Text('第$index条'))
              ],
            );
          }),
    );
  }
}
